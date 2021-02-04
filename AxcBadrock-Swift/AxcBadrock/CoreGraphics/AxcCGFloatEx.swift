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
    var axc_degreesToRadians: CGFloat { return .pi * self / 180.0 }

    /// 弧度转角度
    var axc_radiansToDegrees: CGFloat { return self * 180 / CGFloat.pi }
}

// MARK: - 类方法/属性
extension CGFloat: AxcDataElementMaxMinValue {
    /// 最大值
    public static var axc_max: CGFloat { return CGFloat.greatestFiniteMagnitude }
    
    /// 最小正值
    public static var axc_min: CGFloat { return CGFloat.leastNonzeroMagnitude }
}

// MARK: - 属性 & Api
public extension CGFloat {
    /// 绝对值
    var axc_abs: CGFloat { return Swift.abs(self) }
    /// 向上取整
    var axc_ceil: CGFloat { return Foundation.ceil(self) }
    /// 向下取整
    var axc_floor: CGFloat { return Foundation.floor(self) }
}

// MARK: - 决策判断
public extension CGFloat {
    /// 是否为正
    var axc_isPositive: Bool { return self > 0 }

    /// 是否为负
    var axc_isNegative: Bool { return self < 0 }
}

// MARK: - 运算符
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
/// 求幂运算符
infix operator *^: PowerPrecedence
/// 求平方根运算符
prefix operator √
/// ±中间 - 进行一次加减运算

public extension CGFloat {
    /// 求幂的值
    ///
    /// 2 *^ 3 = 8
    /// 3 *^ 3 = 9
    /// 5 *^ 2 = 25
    ///
    static func *^ (lhs: CGFloat, rhs: CGFloat) -> Double {
        return pow(Double(lhs), Double(rhs))
    }
    
    /// 计算一个非负实数的平方根
    ///
    /// √9 = 3
    /// √25 = 5
    ///
    static prefix func √ (float: CGFloat) -> Double {
        return float.axc_isPositive ? sqrt(Double(float)) : 0
    }
}
