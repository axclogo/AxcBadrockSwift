//
//  AxcDataElementTransformEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

// MARK: - 基础数据类型协议
// MARK: 基础数据类型互转
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

// MARK: 基础数据类型最大值和最小值
public protocol AxcDataElementMaxMinValue {
    /// 最大值
    static var axc_max: Self { get }
    /// 最小值
    static var axc_min: Self { get }
}

