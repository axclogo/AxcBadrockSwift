//
//  AxcUIGestureRecognizerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension UIGestureRecognizer {
}

// MARK: - 类方法/属性
public extension UIGestureRecognizer {
    convenience init(_ actionBlock: @escaping AxcGestureActionBlock) {
        self.init()
        axc_actionBlock = actionBlock
        addTarget(self, action: #selector(gestureAction(_:)))
    }
}

// MARK: - 属性 & Api
public extension UIGestureRecognizer {
    /// 从view中移除
    func axc_removeFromView() {
        view?.removeGestureRecognizer(self)
    }
}

// MARK: - 动态绑定参数
public typealias AxcGestureActionBlock = (UIGestureRecognizer) -> Void
/// actionBlock的键
private var kaxc_actionBlock = "kaxc_actionBlock"
public extension UIGestureRecognizer {
    /// 手势触发的Block
    var axc_actionBlock: AxcGestureActionBlock? {
        set {
            AxcRuntime.setAssociatedObj(self, &kaxc_actionBlock, newValue, .OBJC_ASSOCIATION_COPY)
            
        }
        get { guard let block = AxcRuntime.getAssociatedObj(self, &kaxc_actionBlock) as? AxcGestureActionBlock else { return nil }
            return block
        }
    }
    /// 手势触发的方法
    @objc private func gestureAction(_ sender: UIGestureRecognizer) {
        guard let block = axc_actionBlock else { return }
        block(sender)
    }
}

// MARK: - 决策判断
public extension UIGestureRecognizer {
}

