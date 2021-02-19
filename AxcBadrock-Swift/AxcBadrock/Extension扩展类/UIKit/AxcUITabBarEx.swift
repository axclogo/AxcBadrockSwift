//
//  AxcUITabBarEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

public extension UITabBar {
    /// 设置背景色
    func axc_backgroundColor(_ color: UIColor? = nil) {
        let isColor = color != nil
        backgroundImage = isColor ? UIImage() : nil
        backgroundColor = isColor ? color : nil
    }
}
