//
//  AxcUIViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension UIView {
    /// 对视图进行截图，转换成Image
    var axc_screenshot: UIImage? {
        return axc_screenshot(layer.frame)
    }
    /// 对视图部分区域进行截图，转换成Image
    func axc_screenshot(_ rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIRectClip(rect)
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - 类方法/属性
public extension UIView {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 属性 & Api
public extension UIView {
    /// 添加一组视图
    func axc_addSubviews(_ views: [UIView]) -> UIView {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
        return self
    }
    /// 移除所有子视图
    func axc_removeAllSubviews() -> UIView {
        for subview in subviews { subview.removeFromSuperview() }
        return self
    }
}

// MARK: - 重写扩展属性 & 方法
extension UIView {
    // 初始这个类的时候进行处理：
//    open override class func initialize() {
//        AxcGCD.once("UIViewLoadFuncExchange") {
//            AxcRuntime.methodSwizzle(_class: self,
//                                     originalSelector: #selector(layoutSubviews),
//                                     swizzledSelector: #selector(axc_layoutSubviews))
//        }
//    }
//    @objc func axc_layoutSubviews() {
//        layoutSubviews()
//    }
}

// MARK: - 视觉扩展属性 & 方法
public extension UIView {
    /// 快速设置阴影 支持圆角阴影
    /// - Parameters:
    ///   - offset: 阴影偏移量
    ///   - radius: 阴影圆角
    ///   - color: 阴影颜色
    ///   - opacity: 阴影透明
    ///   - cornerRadius: 圆角
    func axc_addShadow(offset: CGSize = CGSize(width: 5, height: 5),
                       radius: CGFloat = 5,
                       color: UIColor = UIColor.black,
                       opacity: Float = 0.7,
                       cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
}

// MARK: - Xib扩展属性
public extension UIView {
    /// 边框颜色
    @IBInspectable var axc_borderColor: UIColor? {
        get { return layer.axc_borderColor }
        set { layer.axc_borderColor = newValue }
    }
    /// 边框宽度
    @IBInspectable var axc_borderWidth: CGFloat {
        get { return layer.axc_borderWidth }
        set { layer.axc_borderWidth = newValue }
    }
    /// 圆角
    @IBInspectable var axc_cornerRadius: CGFloat {
        get { return layer.axc_cornerRadius }
        set { layer.axc_cornerRadius = newValue }
    }
    /// 阴影颜色
    @IBInspectable var axc_shadowColor: UIColor? {
        get { guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { layer.shadowColor = nil; return }
            layer.shadowColor = color.cgColor }
    }
    /// 阴影透明度
    @IBInspectable var axc_shadowOpacity: CGFloat {
        get { return layer.shadowOpacity.axc_cgFloatValue }
        set { layer.shadowOpacity = newValue.axc_floatValue }
    }
    /// 阴影偏移
    @IBInspectable var axc_shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    /// 阴影圆角
    @IBInspectable var axc_shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
}

// MARK: - frame扩展属性
public extension UIView {
    /// 读写x
    var axc_x: CGFloat {
        set { frame = CGRect(x: newValue, y: frame.axc_y, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_x }
    }
    /// 读写y
    var axc_y: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: newValue, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_y }
    }
    /// 读写width
    var axc_width: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: newValue, height: frame.axc_height) }
        get { return frame.axc_width }
    }
    /// 读写height
    var axc_height: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: frame.axc_width, height: newValue) }
        get { return frame.axc_height }
    }
    /// 读写left
    var axc_left: CGFloat {
        set { axc_x = newValue }
        get { return frame.axc_left }
    }
    /// 读写right
    var axc_right: CGFloat {
        set { axc_x = newValue - axc_width }
        get { return frame.axc_right }
    }
    /// 读写top
    var axc_top: CGFloat {
        set { axc_y = newValue }
        get { return frame.axc_top }
    }
    /// 读写bottom
    var axc_bottom: CGFloat {
        set { axc_y = newValue - axc_height }
        get { return frame.axc_bottom }
    }
    /// 读写origin
    var axc_origin: CGPoint {
        set { frame = CGRect(origin: newValue, size: axc_size ) }
        get { return frame.axc_origin }
    }
    /// 读写size
    var axc_size: CGSize {
        set { frame = CGRect(origin: frame.axc_origin, size: newValue) }
        get { return frame.axc_size }
    }
    /// 读写centerX
    var axc_centerX: CGFloat {
        get { return center.x }
        set { center.x = newValue }
    }
    /// 读写centerY
    var axc_centerY: CGFloat {
        get { return self.center.y }
        set { self.center.y = newValue }
    }
}

// MARK: - 决策判断
public extension UIView {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 操作符
public extension UIView {
}

// MARK: - 运算符
public extension UIView {
}
