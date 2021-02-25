//
//  AxcUIColorEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import UIKit

// MARK: - 数据转换
extension UIColor: AxcBaseStrTransform {
    // MARK: 协议
    /// 转换成颜色的十六进制大写字符串
    public var axc_strValue: String {
        return String(format: "%02x%02x%02x", axc_redValue,axc_greenValue,axc_blueValue).uppercased()
    }
    
    // MARK: 扩展
    /// 转换成元组
    public var axc_tuplesValue: (Int,Int,Int,CGFloat) {
        return (axc_redValue,axc_greenValue,axc_blueValue,axc_alpha)
    }
    
    /// 颜色生成图片
    public func axc_image(_ size: CGSize = CGSize.axc_1024Size) -> UIImage? {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext()  else { return nil }
        UIGraphicsGetCurrentContext()
        return image
    }
}

// MARK: - 类方法/属性
public extension UIColor {
    /// RGBA自动/255 自适应创建颜色
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, a: CGFloat = 1) {
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
        } else { // TODO: 如果下方方法被声明废弃，则直接删除即可
            self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
        }
    }
    
    /// 通过HexString实例化
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度
    convenience init(hexStr: String, alpha: CGFloat = 1) {
        var formatted = hexStr.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat((hex & 0xFF0000) >> 16)
            let green = CGFloat((hex & 0x00FF00) >> 8)
            let blue = CGFloat((hex & 0x0000FF) >> 0)
            self.init(red,green,blue, a: alpha)
        } else { self.init(0,0,0) }
    }
    
    /// 通过Int十六进制类型实例化
    /// - Parameters:
    ///   - hexInt: 十六进制长整型
    ///   - alpha: 透明度
    convenience init(hexInt: Int, alpha: CGFloat = 1) {
        self.init( CGFloat((hexInt & 0xFF0000) >> 16),
                   CGFloat((hexInt & 0xFF00) >> 8),
                   CGFloat((hexInt & 0xFF)), a: alpha )
    }
    
    /// 生成一个灰色
    /// - Parameters:
    ///   - gray: 灰色度
    ///   - alpha: 透明度
    convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(gray,gray,gray,a: alpha)
    }
    
    /// 获取一个随机色
    static var axc_random: UIColor {
        return AxcColorRGB( CGFloat.axc_random(255), CGFloat.axc_random(255), CGFloat.axc_random(255))
    }
}

// MARK: - 属性 & Api
public extension UIColor {
    /// 设置自身颜色的透明度
    @discardableResult
    func axc_alpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
    
    /// 获取该颜色的反色
    var axc_inverseColor: UIColor {
        var r: CGFloat = 0,g: CGFloat = 0,b: CGFloat = 0,a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(-r, -g, -b, a: a)
    }
}

// MARK: - 获取
public extension UIColor {
    /// 获取红色值Int
    var axc_redValue: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }

    /// 获取绿色值Int
    var axc_greenValue: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }

    /// 获取蓝色值Int
    var axc_blueValue: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    /// 获取透明值Int
    var axc_alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
}

// MARK: - 决策判断
public extension UIColor {
    /// 比较颜色是否一致
    /// - Parameter color: 比较的颜色
    /// - Returns: Bool
    func axc_isEqual(_ color: UIColor) -> Bool {
        return axc_strValue == color.axc_strValue
    }
    
    /// 是否浅色、淡色
    var axc_isLight: Bool {
        let redValue    = Float(axc_redValue)   * 0.299
        let greenValue  = Float(axc_greenValue) * 0.578
        let blueValue   = Float(axc_blueValue)  * 0.114
        return (redValue + greenValue + blueValue) >= 192
    }
}
