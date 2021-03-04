//
//  AxcCGFloatEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 数据转换
extension CGFloat: AxcDataElementTransform {
    // MARK: 协议
    /// 转换NSNumber类型
    public var axc_number: NSNumber? { return NSNumber(value: axc_floatValue) }
    /// 转换String类型
    public var axc_strValue: String {  return String.init(format:"%f", self) }
    /// 转换为Bool类型
    public var axc_boolValue: Bool { return self.axc_isPositive }
    /// 转换Int类型
    public var axc_intValue: Int { return Int(self) }
    /// 转换UInt类型
    public var axc_uIntValue: UInt {  return UInt(self) }
    /// 转换Double类型
    public var axc_doubleValue: Double { return Double(self) }
    /// 转换Float类型
    public var axc_floatValue: Float { return Float(self) }
    /// 转换CGFloat类型
    public var axc_cgFloatValue: CGFloat {  return self }
    
    // MARK: 扩展
    /// 角度转弧度
    var axc_angleToRadian: CGFloat { return .pi * self / 180.0 }

    /// 弧度转角度
    var axc_radianToAngle: CGFloat { return self * 180 / CGFloat.pi }

    /// 转换成UIFont
    var axc_font: UIFont { return UIFont.systemFont(ofSize: self) }
    
    /// 转换成CGRect
    var axc_cgRect: CGRect { return CGRect(self) }
    /// 转换成CGPoint
    var axc_cgPoint: CGPoint { return CGPoint(self) }
    /// 转换成CGSize
    var axc_cgSize: CGSize { return CGSize(self) }
    /// 转换成UIEdgeInsets
    var axc_uiEdge: UIEdgeInsets { return UIEdgeInsets(self) }
    
}

// MARK: - 类方法/属性
public extension CGFloat {
    /// 取随机值
    static func axc_random(_ value: UInt32) -> CGFloat {
        return CGFloat(arc4random() % value)
    }
}

// MARK: - 类方法/属性
extension CGFloat: AxcDataElementMaxMinValue {
    /// 最大值
    public static var axc_max: CGFloat { return CGFloat.greatestFiniteMagnitude }
    
    /// 最小正值
    public static var axc_min: CGFloat { return CGFloat.leastNonzeroMagnitude }
    
    /// 无限
    public static var axc_infinity: CGFloat { return CGFloat(Float.infinity) }
}

// MARK: - 属性 & Api
extension CGFloat: AxcDataElementMath {
    // MARK: 协议
    /// 取几次幂
    public func axc_power(_ power: Double) -> Double { return self *^ power }
    /// 求平方根
    public var axc_sqrtRoot: Double { return √self }
    
    // MARK: 扩展
    /// 绝对值
    public var axc_abs: CGFloat { return Swift.abs(self) }
    /// 向上取整
    public var axc_ceil: CGFloat { return Foundation.ceil(self) }
    /// 向下取整
    public var axc_floor: CGFloat { return Foundation.floor(self) }
}

// MARK: - 决策判断
public extension CGFloat {
    /// 是否为正
    var axc_isPositive: Bool { return self > 0 }

    /// 是否为负
    var axc_isNegative: Bool { return self < 0 }
}
