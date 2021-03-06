//
//  AxcCacheManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import UIKit

public class AxcCacheManager: NSObject {
    /// 单例实例化
    static let shared: AxcCacheManager = {
        let cache = AxcCacheManager()
        
        
        return cache
    }()
    
    func test() {
        fileManager.urls(for: .documentDirectory, in:.userDomainMask)
    }
    
    /// 缓存目录
    var axc_cachePath = Axc_cachesPath
    /// 文件管理器
    private let fileManager = Axc_fileManager
    
}
