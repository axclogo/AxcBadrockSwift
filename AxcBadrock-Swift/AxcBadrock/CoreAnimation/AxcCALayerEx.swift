//
//  AxcCALayerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension CALayer {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 类方法/属性
public extension CALayer {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 属性 & Api
public extension CALayer {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 边框圆角
public extension CALayer {
    /// 边框颜色
    var axc_borderColor: UIColor? {
        get { guard let color = borderColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { borderColor = nil; return }
            borderColor = color.cgColor }
    }
    /// 边框宽度
    var axc_borderWidth: CGFloat {
        get { return borderWidth }
        set { borderWidth = newValue }
    }
    /// 圆角 调用后会自动设置masksToBounds = true
    var axc_cornerRadius: CGFloat {
        get { return cornerRadius }
        set { masksToBounds = true; cornerRadius = newValue.axc_abs }
    }
    /// 阴影颜色
    @IBInspectable var axc_shadowColor: UIColor? {
        get { guard let color = shadowColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { shadowColor = nil; return }
            shadowColor = color.cgColor }
    }
    /// 阴影透明度
    @IBInspectable var axc_shadowOpacity: CGFloat {
        get { return shadowOpacity.axc_cgFloatValue }
        set { shadowOpacity = newValue.axc_floatValue }
    }
    /// 阴影偏移
    @IBInspectable var axc_shadowOffset: CGSize {
        get { return shadowOffset }
        set { shadowOffset = newValue }
    }
    /// 阴影圆角
    @IBInspectable var axc_shadowRadius: CGFloat {
        get { return shadowRadius }
        set { shadowRadius = newValue }
    }
}

// MARK: - 决策判断
public extension CALayer {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 操作符
public extension CALayer {
}

// MARK: - 运算符
public extension CALayer {
}
