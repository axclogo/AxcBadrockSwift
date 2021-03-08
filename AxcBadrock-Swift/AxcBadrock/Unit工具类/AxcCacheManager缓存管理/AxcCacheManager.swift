//
//  AxcCacheManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import UIKit

public class AxcCacheManager: NSObject {
    /// 私有实例化
    private override init(){
        super.init()
        createDir(axc_cacheRootDir) // 创建根目录
    }
    /// 单例实例化
    static let shared: AxcCacheManager = {
        let cache = AxcCacheManager()
        
        return cache
    }()
    
    // MARK: - 私有
    /// 文件管理器
    private let fileManager = Axc_fileManager
    /// 缓存根目录
    private var axc_cachePath = Axc_documentsPath
    /// 缓存文件夹名
    private var cacheFolderName = "/AxcBadrockCache"
    /// 默认缓存根目录名
    private var cacheDefaultRootName = "default"
    /// 缓存文件占位名
    private var cacheFilePlaceholderName = "none"
    /// 创建目录
    private func createDir(_ path: String) {
        let exist = fileManager.fileExists(atPath: path)
        if !exist { // 目录不存在，创建
            do { try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil) }
            catch { AxcLog("缓存目录已存在\n\(error)") }
        }
    }
    
    // MARK: - Api
    /// 获取缓存根目录地址
    var axc_cacheRootDir: String {
        return axc_cachePath.appending(cacheFolderName)
    }
    
    /// 存储一个数据文件
    /// - Parameters:
    ///   - data: data数据
    ///   - key: 键值
    ///   - folder: 存储文件名
    ///   - validityTime: 有效时间 如 3.axc_day 代表3天
    func axc_saveCache(_ data: Data, key: String, folder: String? = nil, validityTime: AxcDateChunk? = nil) {
        var saveFolderName = cacheDefaultRootName
        if let folderName = folder {    // 设置默认存储文件夹名称
            saveFolderName = folderName
        }
        let saveDir = axc_cacheRootDir.appending("/\(saveFolderName)")  // 存储目录
        let saveKey = key.axc_hashDigestStr(.md5)   // md5化
        guard let md5SaveKey = saveKey else {
            AxcLog("键值MD5失败！\n:%@", saveKey, level: .warning)
            return
        } // 创建目录
        let fileDir = saveDir.appending("/\(md5SaveKey)")
        createDir(fileDir) // 写文件前移除该目录下所有文件
        var contentsOfPath: [String]?   // 目录文件集合
        do { contentsOfPath = try fileManager.contentsOfDirectory(atPath: fileDir)}
        catch { AxcLog("读取缓存根目录文件失败！\n\(error)", level: .warning) }    // 警告级
        contentsOfPath?.forEach{    // 遍历删除
            if let fileUrlPath = "\(fileDir)/\($0)".axc_fileUrlPath {
                do { try fileManager.removeItem(at: fileUrlPath) }
                catch { AxcLog("删除文件失败！\nError:\(error)", level: .warning) }
            }
        } // 设置时间戳
        var timeStamp = cacheFilePlaceholderName
        if let overdueTime = validityTime { // 设置过期时间戳
            let saveTime = Date() + overdueTime
            timeStamp = saveTime.axc_iso8601Str
        }
        let saveDataPath = fileDir.appending("/\(timeStamp)") // 存储文件地址
        guard let saveUrl = saveDataPath.axc_fileUrlPath else {
            AxcLog("缓存文件Url转换失败！\nPath:\(saveDataPath)", level: .warning)
            return
        } // 写入文件
        do { try data.write(to: saveUrl) }
        catch { AxcLog("写入缓存文件失败！\n\(error)", level: .warning) }    // 警告级
    }
    
    /// 缓存文件读取
    /// - Parameters:
    ///   - key: 键值
    ///   - folder: 文件名
    /// - Returns: 缓存数据
    func axc_readCache(key: String, folder: String? = nil) -> Data? {
        var saveFolderName = cacheDefaultRootName
        if let folderName = folder {    // 设置默认存储文件夹名称
            saveFolderName = folderName
        }
        let saveDir = axc_cacheRootDir.appending("/\(saveFolderName)")  // 存储目录
        let saveKey = key.axc_hashDigestStr(.md5)   // md5化
        guard let md5SaveKey = saveKey else {
            AxcLog("键值MD5失败！\n:%@", saveKey, level: .warning)
            return nil
        }
        let cacheDir = saveDir.appending("/\(md5SaveKey)") // 缓存文件目录
        var contents: [String]?   // 根目录文件集合
        do { contents = try fileManager.contentsOfDirectory(atPath: cacheDir)}
        catch { AxcLog("读取缓存根目录文件失败！\n\(error)", level: .warning) }    // 警告级
        guard contents?.count == 1 else {   // 保证只存在一个文件
            AxcLog("缓存文件目录结构错误！\nPath:\(cacheDir)\nContents:%@",contents , level: .warning)
            return nil
        }
        let fileName = contents?.first;
        guard let contentFileName = fileName else { // 未找到
            AxcLog("\(saveFolderName)目录下未找到\(key)对应的缓存文件！", level: .warning)
            return nil
        }
        let cacheFilePath = cacheDir.appending("/\(contentFileName)")    // 拼接文件地址
        guard let cacheFileUrl = cacheFilePath.axc_fileUrlPath else {   // 转url
            AxcLog("缓存文件Url转换失败！\nPath:\(cacheFilePath)", level: .warning)
            return nil
        } // 校验有效期
        if contentFileName != cacheFilePlaceholderName { // 有有效期设置
            guard let date = Date(dateString: contentFileName, format: AxcTimeStamp.iso8601) else {
                AxcLog("有效期解析失败！\nTimeStamp:\(contentFileName)", level: .warning)
                return nil
            }
            guard date > Date() else { // 文件已过期，删除
                if let deleteUrl = cacheDir.axc_fileUrlPath {
                    do { try fileManager.removeItem(at: deleteUrl) }
                    catch { AxcLog("删除文件失败！\nError:\(error)", level: .warning) }
                }
                return nil
            }
        } // 有效期大于当前时间 或 无有效期  有效
        var data: Data?
        do { data = try Data(contentsOf: cacheFileUrl) }
        catch { AxcLog("获取文件失败！\n\(error)", level: .warning) }
        guard let _data = data else {
            AxcLog("获取文件为空！", level: .warning)
            return nil
        }
        return _data
    }
    
    func axc_clearAllCache() {
        
    }
}
