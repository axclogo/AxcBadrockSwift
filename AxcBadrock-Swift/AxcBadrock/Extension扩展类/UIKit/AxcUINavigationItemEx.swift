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
    func axc_addBarItem(title: String? = nil, image: UIImage? = nil,
                        size: CGSize? = nil,
                        contentLayout: AxcButton.Style = .imgLeft_textRight ,
                        direction: AxcDirection = .left, animate: Bool = true,
                        actionBlock: @escaping AxcActionBlock) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let btn = AxcButton(title: title, image: image)
        btn.axc_contentInset = UIEdgeInsets.zero
        btn.axc_contentStyle = contentLayout
        btn.axc_addEvent(actionBlock: actionBlock)
        var itemSize = Axc_navigationItemSize
        if let _size = size { itemSize = _size }
        let view = UIView(CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
        btn.frame = view.bounds
        view.addSubview(btn)
        let item = UIBarButtonItem(customView: view)
        if direction == .left { // 左
            var items: [UIBarButtonItem] = []
            if let _items = self.leftBarButtonItems { items = _items }
            items.append(item)
            self.leftBarButtonItems = items
            self.setLeftBarButtonItems(items, animated: animate)
        }else if direction == .right { // 右
            var items: [UIBarButtonItem] = []
            if let _items = self.rightBarButtonItems { items = _items }
            items.append(item)
            self.setRightBarButtonItems(items, animated: animate)
        }
    }
    
    func axc_removeBarItem(direction: AxcDirection = .left, idx: Int? = nil) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left { // 左
            if let _idx = idx {
                self.leftBarButtonItems?.axc_remove(_idx)
            }else{
                self.leftBarButtonItems = nil
            }
        }else if direction == .right { // 右
            if let _idx = idx {
                self.rightBarButtonItems?.axc_remove(_idx)
            }else{
                self.rightBarButtonItems = nil
            }
        }
    }
}


// MARK: - 决策判断
public extension UINavigationItem {
}

