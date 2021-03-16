//
//  AxcNSObjectEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import Foundation

// MARK: - 属性 & Api
public extension NSObject {
    /// 获取本类的类名
    var axc_className: String {
        return AxcClassFromString(self)
    }
    /// 获取本类的类名
    static var axc_className: String {
        return AxcClassFromString(self)
    }
    
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
    
    /// 添加通知
    /// - Parameters:
    ///   - name: 通知名
    ///   - selector: 方法
    func axc_addNotification(_ name: NSNotification.Name, selector: Selector) {
        axc_notificationCenter.addObserver(self, selector: selector, name: name, object: nil)
    }
    /// 移除通知
    /// - Parameter name: 通知名
    func axc_removeNotification(_ name: NSNotification.Name) {
        axc_notificationCenter.removeObserver(self, name: name, object: nil)
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
