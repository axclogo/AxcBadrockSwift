//
//  AxcUIMenuItemEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// MARK: - 类方法/属性
public extension UIMenuItem {
    ///一个带block回调的实例化
    /// - Parameters:
    ///   - title: 标题
    ///   - actionBlock: actionBlock
    convenience init(title: String, _ actionBlock: @escaping AxcMenuItemBlock) {
        self.init(title: title, action: #selector(itemAction) )
        axc_actionBlock = actionBlock
    }
}

// MARK: - 添加回调Block
public typealias AxcMenuItemBlock = AxcEmptyBlock
/// actionBlock的键
private var kaxc_actionBlock = "kaxc_actionBlock"
public extension UIMenuItem {
    /// 触发的Block
    var axc_actionBlock: AxcMenuItemBlock? {
        set { AxcRuntime.setAssociatedObj(self, &kaxc_actionBlock, newValue, .OBJC_ASSOCIATION_COPY) }
        get { guard let block = AxcRuntime.getAssociatedObj(self, &kaxc_actionBlock) as? AxcMenuItemBlock else { return nil }
            return block }
    }
    /// 触发的方法
    @objc private func itemAction() {
        guard let block = axc_actionBlock else { return }
        block()
    }
}
