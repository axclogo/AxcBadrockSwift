//
//  AxcDoubleEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 数据转换
extension Double: AxcDataElementTransform {
    // MARK: 协议 /// 转换NSNumber类型
    public var axc_number: NSNumber? { return NSNumber(value: self) }
    /// 转换String类型
    public var axc_strValue: String {  return String(self) }
    /// 转换为Bool类型
    public var axc_boolValue: Bool { return self != 0 }
    /// 转换Int类型
    public var axc_intValue: Int { return Int(self) }
    /// 转换UInt类型
    public var axc_uIntValue: UInt {  return UInt(self) }
    /// 转换Double类型
    public var axc_doubleValue: Double { return self }
    /// 转换Float类型
    public var axc_floatValue: Float { return Float(self) }
    /// 转换CGFloat类型
    public var axc_cgFloatValue: CGFloat {  return CGFloat(self) }
    
    // MARK: 扩展
}

// MARK: - 类方法/属性
extension Double: AxcDataElementMaxMinValue {
    // MARK: 协议
    /// 最大值
    public static var axc_max: Double { return Double.greatestFiniteMagnitude }
    /// 最小值
    public static var axc_min: Double { return Double.leastNormalMagnitude }
}

// MARK: - 属性 & Api
extension Double: AxcDataElementMath {
    // MARK: 协议
    /// 取几次幂
    public func axc_power(_ power: Double) -> Double { return self *^ power }
    /// 求平方根
    public var axc_sqrtRoot: Double { return √self }
}
