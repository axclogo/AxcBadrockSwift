//
//  AxcUITextFieldEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// MARK: - 数据转换
public extension UITextField {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension UITextField {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
public extension UITextField {
}
// MARK: - 响应回调
extension UITextField: AxcActionBlockProtocol {
    /// 添加响应者
    /// - Parameters:
    ///   - target: 响应者
    ///   - event: 响应类型
    ///   - actionBlock: actionBlock
    /// - Returns: UITextField
    @discardableResult
    public func axc_addTarget(target: Any? = nil,
                              event: UIControl.Event = .editingChanged,
                              actionBlock: @escaping AxcActionBlock ) -> UITextField {
        axc_setActionBlock(actionBlock)
        addTarget(target, action: #selector(eventAction), for: event)
        return self
    }
    // 转block方法
    @objc private func eventAction(_ sender: Any?) {
        guard let block = axc_getActionBlock() else { return }
        block(sender)
    }
}

// MARK: - 【对象特性扩展区】
public extension UITextField {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension UITextField {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension UITextField {
}

// MARK: - 运算符
public extension UITextField {
}
