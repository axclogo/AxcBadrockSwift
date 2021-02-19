//
//  AxcUINavigationControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

// MARK: - 属性 & Api
public extension UINavigationController {
    /// 带执行完毕回调的push
    /// - Parameters:
    ///   - viewController: viewController
    ///   - completion: completion
    func axc_pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    /// 带执行完毕回调的pop
    /// - Parameters:
    ///   - animated: animated
    ///   - completion: completion
    func axc_popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// 设置透明渲染色
    /// - Parameter tint: 颜色
    func axc_makeTransparent(_ tintColor: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
    }
}
