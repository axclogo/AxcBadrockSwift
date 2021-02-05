//
//  AxcFloatingPointEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 数据转换
public extension FloatingPoint {
    /// 角度转弧度
    var axc_degreesToRadians: Self { return .pi * self / Self(180) }

    /// 弧度转角度
    var axc_radiansToDegrees: Self { return self * 180 / Self.pi }
}

// MARK: - 属性 & Api
public extension FloatingPoint {
    /// 取绝对值
    var axc_abs: Self { return Swift.abs(self) }
    /// 向上取整
    var axc_ceil: Self { return Foundation.ceil(self) }
    /// 向下取整
    var axc_floor: Self { return Foundation.floor(self) }
}

// MARK: - 决策判断
public extension FloatingPoint {
    /// 是否为正数
    var axc_isPositive: Bool { return self > 0 }
    /// 是否为负数
    var axc_isNegative: Bool { return self < 0 }
}


