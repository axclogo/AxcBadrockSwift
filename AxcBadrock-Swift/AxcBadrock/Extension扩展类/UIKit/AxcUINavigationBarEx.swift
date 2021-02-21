//
//  AxcUINavigationBarEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

public extension UINavigationBar {
    /// 设置导航栏的标题，标题颜色和字体
    /// - Parameters:
    ///   - font: 字体
    ///   - color: 标题颜色
    
    /// 设置导航栏字色
    /// - Parameter color: 颜色
    func axc_setTitleColor(_ color: UIColor) {
        var att: [NSAttributedString.Key : Any] = [:]
        if let _att = titleTextAttributes { att = _att }
        att[.foregroundColor] = color
        titleTextAttributes = att
    }
    /// 设置导航栏字体
    /// - Parameter font: 字体
    func axc_setTitleFont(_ font: UIFont) {
        var att: [NSAttributedString.Key : Any] = [:]
        if let _att = titleTextAttributes { att = _att }
        att[.font] = font
        titleTextAttributes = att
    }
    /// 让导航栏改变颜色 默认白色
    func axc_setColor(_ tintColor: UIColor = .white) {
        backgroundColor = tintColor
        barTintColor = tintColor
        setBackgroundImage(UIImage(), for: .default)
        self.tintColor = tintColor
        shadowImage = UIImage()
    }
}
