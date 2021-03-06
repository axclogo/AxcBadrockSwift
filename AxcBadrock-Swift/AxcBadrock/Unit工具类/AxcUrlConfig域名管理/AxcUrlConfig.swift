//
//  AxcSolidNet.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/5.
//

import UIKit

// MARK: - 定义
/// 网络模块结构体
public struct AxcUrlConfigModule {
    /// 模块名称
    var name: String
    /// 该模块当前使用的Url
    var currentUrl: AxcEnvironmentTuples?
    /// 模块唯一ID
    var identifier: String
    /// 模块所有环境信息
    var environment: [ AxcEnvironmentType ]
    
    /// 实例化方法
    /// - Parameters:
    ///   - name: 模块名称
    ///   - urls: 所有Url和标题
    init(_ name: String, identifier: String, environment: [ AxcEnvironmentType ] ) {
        self.name = name
        self.identifier = identifier
        self.environment = environment
    }
}

/// 环境类型结构体
public struct AxcEnvironmentType {
    /// 环境键值
    var environmentKey: String
    /// 环境备用Url集合
    var standbyUrls: [ AxcEnvironmentTuples ]
}
/// 备用环境元组
typealias AxcEnvironmentTuples = (title: String, url: String)

// MARK: - AxcUrlConfig
/**
 网络层管理类
 用于隔离数据结构、环境切换
 模块管理等
 */
public class AxcUrlConfig {
    /// 单例实例化
    static let shared: AxcUrlConfig = {
        let solidNet = AxcUrlConfig()
        return solidNet
    }()
    
    // MARK: 获取方法
    /// 当前环境
    var currentEnvironmentKey: String?
    
    /// 通过模块ID获取模块当前Url
    func axc_getCurrentUrl(_ identifier: String ) -> AxcEnvironmentTuples? {
        let module = axc_getModule(identifier)
        return module?.currentUrl
    }
    
    // MARK: 切换方法
    /// 所有模块统一切换环境
    /// - Parameter environmentKey: 环境键值
    func axc_switchEnvironment(_ environmentKey: String) {
        currentEnvironmentKey = environmentKey
        for idx in 0..<netModules.count {  // 遍历所有模块依次设置环境地址
            var module = netModules[idx]
            guard let currentUrl = axc_getModuleStandbyUrl(module, environmentKey: environmentKey, idx: 0)
            else { return }
            module.currentUrl = currentUrl
            netModules[idx] = module
        }
    }
    
    /// 切换单个模块的备用地址
    /// - Parameters:
    ///   - identifier: 模块ID
    ///   - environmentKey: 哪个环境？
    ///   - idx: 备用地址的索引
    func axc_switchStandbyUrl(_ identifier: String, environmentKey: String, idx: Int) {
        guard var module = axc_getModule(identifier),
              let currentUrl = axc_getModuleStandbyUrl(module, environmentKey: environmentKey, idx: idx)
        else { return }
        module.currentUrl = currentUrl // 设置环境
        axc_replaceModule(module, identifier: identifier) // 修改
    }
    
    /// 获取某个模块下某个环境的备用地址
    /// - Parameters:
    ///   - module: 模块
    ///   - environmentKey: 环境键值
    ///   - idx: 备用地址索引
    /// - Returns: 地址
    func axc_getModuleStandbyUrl(_ module: AxcUrlConfigModule, environmentKey: String, idx: Int ) -> AxcEnvironmentTuples? {
        var currentUrl: AxcEnvironmentTuples?
        for environ in module.environment {
            if environ.environmentKey == environmentKey {   // 找到这个环境
                if environ.standbyUrls.axc_safeIdx(idx) {   // 判断索引是否越界
                    currentUrl = environ.standbyUrls[idx]
                }else{  // 越界抛出可拦截闪退！
                    let log = "切换模块地址失败！原因：数组越界！\nModule:\(module)\nEnvironmentKey\(environmentKey),\nIdx:\(idx)"
                    AxcLog(log, level: .fatal)
                    if AxcBadrock.fatalError { fatalError(log) }
                }
            }
        }
        return currentUrl
    }
    
    
    // MARK: 操作方法
    /// 加载所有模块
    func axc_loadAllModule() {
        // 检查所有模块的环境个数是否对应
        let moduleEnvironmentCount = netModules.first?.environment.count
        for module in netModules {
            if moduleEnvironmentCount != module.environment.count {
                let log = "模块加载失败！原因：Module:\(module)的环境数量不匹配！"
                AxcLog(log, level: .fatal)
                if AxcBadrock.fatalError { fatalError(log) }
                return
            }
        }
        for idx in 0..<netModules.count {  // 遍历所有模块依次设置环境地址
            var module = netModules[idx]
            // 获取第一个环境
            guard let firstEnvironment = module.environment.first else {
                let log = "模块加载失败！原因，未找到Module:\(module)的首个环境！"
                AxcLog(log, level: .fatal)
                if AxcBadrock.fatalError { fatalError(log) }
                return
            }
            // 获取第一个环境的第一个备用地址
            guard let standbyUrl = firstEnvironment.standbyUrls.first else {
                let log = "模块加载失败！原因，未找到Environment:\(firstEnvironment)的首个备用地址！"
                AxcLog(log, level: .fatal)
                if AxcBadrock.fatalError { fatalError(log) }
                return
            }
            module.currentUrl = standbyUrl
            netModules[idx] = module // 重新覆盖
        }
    }
    
    /// 添加一个模块
    /// - Parameters:
    ///   - title: 标题
    ///   - defaultUrl: 默认初始Url
    ///   - standby: 备用域名
    func axc_addModule(_ module: AxcUrlConfigModule ) {
        netModules.append(module)
    }
    
    /// 移除
    /// - Parameter idx: 索引
    func axc_removeModule(_ idx: Int ) {
        netModules.axc_remove(idx)
    }
    /// 移除
    /// - Parameter identifier: 模块唯一ID
    func axc_removeModule(_ identifier: String ) {
        netModules = netModules.filter { (module) -> Bool in
            return module.identifier != identifier
        }
    }
    
    /// 修改
    /// - Parameter idx: 索引
    func axc_replaceModule(_ module: AxcUrlConfigModule, idx: Int ) {
        if netModules.axc_safeIdx(idx) {
            netModules[idx] = module
        }else{
            let log = "修改AxcSolidNet模块索引错误！\nIndex:\(idx)"
            AxcLog(log, level: .fatal)
            if AxcBadrock.fatalError { fatalError(log) }
        }
    }
    /// 修改
    /// - Parameter identifier: 模块唯一ID
    func axc_replaceModule(_ module: AxcUrlConfigModule, identifier: String ) {
        axc_replaceModule(module, idx: axc_identifierForIdx(identifier))
    }
    
    /// 通过索引获取模块
    /// - Parameters:
    ///   - module: 模块
    ///   - idx: 索引
    /// - Returns: 模块
    func axc_getModule(_ idx: Int ) -> AxcUrlConfigModule? {
        if netModules.axc_safeIdx(idx) {
            return netModules[idx]
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
    func axc_getModule(_ identifier: String ) -> AxcUrlConfigModule? {
        return axc_getModule( axc_identifierForIdx(identifier) )
    }
    
    /// 通过索引获取ID
    /// - Parameter idx: 索引
    /// - Returns: 模型
    func axc_idxForIdentifier(_ idx: Int) -> String? {
        if netModules.axc_safeIdx(idx) {
            return netModules[idx].identifier
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
        for module in netModules {
            if module.identifier == identifier { break }
            idx += 1
        }
        return idx
    }
    
    /// 存放网络模块的数组
    var netModules: [AxcUrlConfigModule] = []
}
