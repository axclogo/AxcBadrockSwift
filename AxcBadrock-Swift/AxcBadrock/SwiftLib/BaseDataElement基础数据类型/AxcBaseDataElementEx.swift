//
//  AxcBaseDataElementEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 基础数据类型协议
// MARK: 类型互转
public protocol AxcDataElementTransform {
    /// 转换NSNumber类型
    var axc_number:         NSNumber?   { get }
    /// 转换String类型
    var axc_strValue:       String      { get }
    /// 转换Bool类型
    var axc_boolValue:      Bool        { get }
    /// 转换UInt类型
    var axc_uIntValue:      UInt        { get }
    /// 转换Int类型
    var axc_intValue:       Int         { get }
    /// 转换Double类型
    var axc_doubleValue:    Double      { get }
    /// 转换Float类型
    var axc_floatValue:     Float       { get }
    /// 转换CGFloat类型
    var axc_cgFloatValue:   CGFloat     { get }
}

// MARK: 最大值和最小值
public protocol AxcDataElementMaxMinValue {
    /// 最大值
    static var axc_max: Self { get }
    /// 最小值
    static var axc_min: Self { get }
}

// MARK: 数学运算函数
public protocol AxcDataElementMath {
    /// 取几次幂
    func axc_power(_ power: Double) -> Double
    /// 求平方根
    var axc_sqrtRoot: Double { get }
}


// MARK: - 求幂运算符
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator *^: PowerPrecedence

/// 求幂的值
///
/// 2 *^ 3 = 8
/// 3 *^ 3 = 9
/// 5 *^ 2 = 25
///
// MARK: Int
public func *^ (lhs: Int, rhs: Double) -> Double {
    return pow(Double(lhs), rhs)
}
// MARK: Double
public func *^ (lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}
// MARK: Float
public func *^ (lhs: Float, rhs: Double) -> Double {
    return pow(Double(lhs), rhs)
}
// MARK: CGFloat
public func *^ (lhs: CGFloat, rhs: Double) -> Double {
    return pow(Double(lhs), rhs)
}

// MARK: - 求平方根运算符
prefix operator √

/// 计算一个非负实数的平方根
///
/// √9 = 3
/// √25 = 5
///
// MARK: Int
public prefix func √ (int: Int) -> Double {
    return sqrt(Double(int))
}
// MARK: Double
public prefix func √ (double: Double) -> Double {
    return sqrt(double)
}
// MARK: Float
public prefix func √ (float: Float) -> Double {
    return sqrt(Double(float))
}
// MARK: CGFloat
public prefix func √ (float: CGFloat) -> Double {
    return sqrt(Double(float))
}
