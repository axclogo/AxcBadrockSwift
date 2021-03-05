//
//  AxcSolidNet.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/5.
//

import UIKit

// MARK: - 定义
/// 网络模块结构体
public struct AxcSolidNetModule {
    /// 模块名称
    var name: String
    /// 模块唯一ID
    var identifier: String
    /// 模块所有Url，默认第一个Url为主Url
    var urls: [ AxcEnvironmentStandbyTuples ]
    
    /// 实例化方法
    /// - Parameters:
    ///   - name: 模块名称
    ///   - urls: 所有Url和标题
    init(_ name: String, identifier: String, urls: [ AxcEnvironmentStandbyTuples ] ) {
        self.name = name
        self.identifier = identifier
        self.urls = urls
    }
}
/// 备用环境元组
typealias AxcEnvironmentStandbyTuples = (title: String, url: String)

// MARK: - AxcSolidNet
/**
 网络层管理类
 用于隔离数据结构、环境切换
 模块管理等
 */
public class AxcSolidNet {
    /// 单例实例化
    static let shared: AxcSolidNet = {
        let solidNet = AxcSolidNet()
        return solidNet
    }()
    /// 存放环境变量的数组
    private var environmentModules: [AxcSolidNetModule] = []
    
    /// 添加一个模块
    /// - Parameters:
    ///   - title: 标题
    ///   - defaultUrl: 默认初始Url
    ///   - standby: 备用域名
    func axc_addModule(_ module: AxcSolidNetModule ) {
        environmentModules.append(module)
    }
    
    /// 移除
    /// - Parameter idx: 索引
    func axc_removeModule(_ idx: Int ) {
        environmentModules.axc_remove(idx)
    }
    /// 移除
    /// - Parameter identifier: 模块唯一ID
    func axc_removeModule(_ identifier: String ) {
        environmentModules = environmentModules.filter { (module) -> Bool in
            return module.identifier != identifier
        }
    }
    
    /// 修改
    /// - Parameter idx: 索引
    func axc_replaceModule(_ module: AxcSolidNetModule, idx: Int ) {
        if environmentModules.axc_safeIdx(idx) {
            environmentModules[idx] = module
        }else{
            let log = "修改AxcSolidNet模块索引错误！\nIndex:\(idx)"
            AxcLog(log, level: .fatal)
            if AxcBadrock.fatalError { fatalError(log) }
        }
    }
    /// 修改
    /// - Parameter identifier: 模块唯一ID
    func axc_replaceModule(_ module: AxcSolidNetModule, identifier: String ) {
        axc_replaceModule(module, idx: axc_identifierForIdx(identifier))
    }
    
    /// 通过索引获取模块
    /// - Parameters:
    ///   - module: 模块
    ///   - idx: 索引
    /// - Returns: 模块
    func axc_getModule(_ module: AxcSolidNetModule, idx: Int ) -> AxcSolidNetModule? {
        if environmentModules.axc_safeIdx(idx) {
            return environmentModules[idx]
        }else{
            let log = "获取AxcSolidNet模块索引错误！\nIndex:\(idx)"
            AxcLog(log, level: .fatal)
            if AxcBadrock.fatalError { fatalError(log) }
        }
        return nil
    }
        /// 通过ID获取模块
    /// - Parameters:
    ///   - module: 模块
    ///   - identifier: ID
    /// - Returns: 模块
    func axc_getModule(_ module: AxcSolidNetModule, identifier: String ) -> AxcSolidNetModule? {
        return axc_getModule(module, idx: axc_identifierForIdx(identifier))
    }
    
    /// 通过索引获取ID
    /// - Parameter idx: 索引
    /// - Returns: 模型
    func axc_idxForIdentifier(_ idx: Int) -> String? {
        if environmentModules.axc_safeIdx(idx) {
            return environmentModules[idx].identifier
        }else{
            let log = "获取AxcSolidNet模块索引错误！\nIndex:\(idx)"
            AxcLog(log, level: .fatal)
            if AxcBadrock.fatalError { fatalError(log) }
        }
        return nil
    }
    /// 通过ID获取索引
    /// - Parameter identifier: ID
    /// - Returns: 索引
    func axc_identifierForIdx(_ identifier: String) -> Int {
        var idx = 0
        for module in environmentModules {
            if module.identifier == identifier { break }
            idx += 1
        }
        return idx
    }
    
}
