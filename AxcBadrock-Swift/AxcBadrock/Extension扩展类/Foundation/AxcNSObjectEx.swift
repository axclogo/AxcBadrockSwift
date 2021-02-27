//
//  AxcNSObjectEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import Foundation

// MARK: - 属性 & Api
public extension NSObject {
    /// UserDefaults
    var axc_userDefaults: UserDefaults {
        return Axc_userDefaults
    }
    /// 通知中心NotificationCenter
    var axc_notificationCenter: NotificationCenter {
        return Axc_notificationCenter
    }
    
    /// 添加一组观察键值对
    func axc_addObservers(_ keyPaths: [String] ) {
        keyPaths.forEach{ axc_addObserver($0) }
    }
    /// 添加观察者
    func axc_addObserver(_ keyPath: String,
                         options: NSKeyValueObservingOptions = [.new],
                         context: UnsafeMutableRawPointer? = nil) {
        addObserver(self, forKeyPath: keyPath, options: options, context: context)
    }
    /// 移除一组观察者
    func axc_removeObservers(_ keyPaths: [String] ) {
        keyPaths.forEach{ axc_removeObserver($0) }
    }
    /// 移除观察者
    func axc_removeObserver(_ keyPath: String,
                            context: UnsafeMutableRawPointer? = nil) {
        removeObserver(self, forKeyPath: keyPath, context: context)
    }
    /// 拷贝加类型软解包
    func axc_copy() -> Self? {
        guard let copy = self.copy() as? Self else { return nil }
        return copy
    }
}

// MARK: - 决策判断
public extension NSObject {
}
