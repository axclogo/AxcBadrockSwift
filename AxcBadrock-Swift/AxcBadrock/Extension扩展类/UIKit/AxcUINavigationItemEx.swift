//
//  AxcUINavigationItemEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// MARK: - 属性 & Api
public extension UINavigationItem {
    /// 添加一个item按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - direction: 方位
    ///   - animate: 添加动画
    func axc_addBarItem(title: String, image: UIImage, direction: AxcDirection = .left, animate: Bool = true) {
        if direction != .left || direction != .right { // 只有左右可选
            AxcLog("[\(direction)] 不是一个可选的NavBarItem的方位！", level: .warning)
            return
        }
        let btn = AxcButton(title: title, image: image)
        let item = UIBarButtonItem(customView: btn)
        if direction == .left { // 左
            var items = self.leftBarButtonItems
            items?.append(item)
            self.leftBarButtonItems = items
            self.setLeftBarButtonItems(items, animated: animate)
        }else if direction == .right { // 右
            var items = self.rightBarButtonItems
            items?.append(item)
            self.setRightBarButtonItems(items, animated: animate)
        }
    }
}


// MARK: - 决策判断
public extension UINavigationItem {
}

