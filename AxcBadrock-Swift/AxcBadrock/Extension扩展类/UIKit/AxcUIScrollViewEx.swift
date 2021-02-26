//
//  AxcUIScrollViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 数据转换
public extension UIScrollView {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension UIScrollView {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
public extension UIScrollView {
    /// 滑动
    /// - Parameters:
    ///   - direction: 滑动方位
    ///   - animated: 是否动画
    func axc_scroll(_ direction: AxcDirection, animated: Bool = true) {
        var scrollPoint = CGPoint.zero
        if direction == .top    { scrollPoint = CGPoint(( contentOffset.x, 0)) }
        if direction == .left   { scrollPoint = CGPoint(( 0, contentOffset.y)) }
        if direction == .bottom { scrollPoint = CGPoint(( 0, contentSize.height - axc_height)) }
        if direction == .right  { scrollPoint = CGPoint(( contentSize.width - axc_width, 0)) }
        if direction == .center  { scrollPoint = CGPoint(( (contentSize.width - axc_width) / 2, (contentSize.height - axc_height) / 2)) }
        setContentOffset(scrollPoint, animated: animated)
    }
}


// MARK: - 决策判断
public extension UIScrollView {
// MARK: 协议
// MARK: 扩展
}
