//
//  AxcDispatchEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import Foundation

// MARK: - 类方法/属性
public extension DispatchQueue {
    /// 记录所有
    private static var _onceTracker = [String]()
    /// 扩展实现单次执行的Block
    /// - Parameters:
    ///   - Identifier: 唯一标识符
    ///   - identifier: 任务块
    static func axc_once(identifier: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(identifier) { return }
        _onceTracker.append(identifier)   // 分隔所有标记
        block()
    }
    
    /// 延时任务Block调用
    /// - Parameters:
    ///   - delay: 延时时间
    ///   - task: 延时任务
    ///   - mainTask: 回调主线任务
    /// - Returns: 工作元素
    @discardableResult
    static func axc_delay(_ delay: Double, _ task: @escaping () -> Void, _ mainTask: (() -> Void)? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        main.asyncAfter(deadline: DispatchTime.now() + delay, execute: item)
        if let main = mainTask { item.notify(queue: .main, execute: main) }
        return item
    }
    
    /// 异步任务Block调用
    /// - Parameters:
    ///   - task: 异步任务
    ///   - mainTask: 回调主线任务
    static func axc_async(_ task: @escaping () -> Void, _ mainTask: (() -> Void)? = nil) {
        let item = DispatchWorkItem(block: task)
        global().async(execute: item)
        if let main = mainTask { item.notify(queue: .main, execute: main) }
    }
    
}

// MARK: - 属性 & Api
public extension DispatchQueue {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 【对象特性扩展区】
public extension DispatchQueue {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension DispatchQueue {
// MARK: 协议
// MARK: 扩展
}

