//
//  AxcCGFloatEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 数据转换 - 协议
extension CGFloat: AxcDataElementTransform {
    /// 转换NSNumber类型
    var axc_number: NSNumber? { return NSNumber(value: axc_floatValue) }
    /// 转换String类型
    var axc_strValue: String {  return String.init(format:"%f", self) }
    /// 转换Int类型
    var axc_intValue: Int { return Int(self) }
    /// 转换UInt类型
    var axc_uIntValue: UInt {  return UInt(self) }
    /// 转换Double类型
    var axc_doubleValue: Double { return Double(self) }
    /// 转换Float类型
    var axc_floatValue: Float { return Float(self) }
    /// 转换CGFloat类型
    var axc_cgFloatValue: CGFloat {  return self }
}

// MARK: - 数据转换 - 扩展
extension CGFloat {
    /// 角度转弧度
    var axc_degreesToRadians: CGFloat { return .pi * self / 180.0 }

    /// 弧度转角度
    var axc_radiansToDegrees: CGFloat { return self * 180 / CGFloat.pi }
}

// MARK: - 类方法/属性
extension CGFloat {
    /// 最大值
    static var axc_MAX: CGFloat { return CGFloat.greatestFiniteMagnitude }
    
    /// 最小正值
    static var axc_MIN: CGFloat { return CGFloat.leastNonzeroMagnitude }
}

// MARK: - 属性 & Api
extension CGFloat {
    /// 取绝对值
    var axc_abs: CGFloat { return Swift.abs(self) }

    /// 向上取整
    var axc_ceil: CGFloat { return Foundation.ceil(self) }
    
    /// 向下取整
    var axc_floor: CGFloat { return Foundation.floor(self) }
}

// MARK: - 决策判断
extension CGFloat {
    /// 是否为正
    var axc_isPositive: Bool { return self > 0 }

    /// 是否为负
    var axc_isNegative: Bool { return self < 0 }
}

// MARK: - 操作符
extension CGFloat {
}
// MARK: - 运算符
extension CGFloat {
}
