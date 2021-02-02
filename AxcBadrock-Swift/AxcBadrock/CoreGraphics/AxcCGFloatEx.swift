//
//  AxcCGFloatEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 类型转换
public extension CGFloat {
    
    /// 转Int
    var axc_int: Int { return Int(self) }

    /// 转Float.
    var axc_float: Float { return Float(self) }

    /// 转Double.
    var axc_double: Double { return Double(self) }

    /// 角度转弧度
    var axc_degreesToRadians: CGFloat { return .pi * self / 180.0 }

    /// 弧度转角度
    var axc_radiansToDegrees: CGFloat { return self * 180 / CGFloat.pi }
    
}

// MARK: - 计算
public extension CGFloat {
    
    /// 取绝对值
    var axc_abs: CGFloat { return Swift.abs(self) }

    /// 向上取整
    var axc_ceil: CGFloat { return Foundation.ceil(self) }
    
    /// 向下取整
    var axc_floor: CGFloat { return Foundation.floor(self) }
    
    /// 最大值
    static var axc_MAX: CGFloat { return CGFloat.greatestFiniteMagnitude }
    
    /// 最小正值
    static var axc_MIN: CGFloat { return CGFloat.leastNonzeroMagnitude }
    
}

// MARK: - 判断条件
public extension CGFloat {
    
    /// 是否为正
    var axc_isPositive: Bool { return self > 0 }

    /// 是否为负
    var axc_isNegative: Bool { return self < 0 }
    
}
