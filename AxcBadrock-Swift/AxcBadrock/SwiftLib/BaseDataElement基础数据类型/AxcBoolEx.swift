//
//  AxcBoolEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 数据转换
extension Bool: AxcDataElementTransform {
    // MARK: 协议
    // TODO: 转换问题
    /// 转换NSNumber类型
    public var axc_number: NSNumber? {  return NSNumber(value: axc_intValue) }
    /// 转换String类型
    public var axc_strValue: String { return self ? AxcTrue : AxcFalse }
    /// 转换为Bool类型
    public var axc_boolValue: Bool { return self }
    /// 转换UInt类型
    public var axc_uIntValue: UInt { return self ? 1 : 0 }
    /// 转换Int类型
    public var axc_intValue: Int { return self ? 1 : 0 }
    /// 转换Double类型
    public var axc_doubleValue: Double { return self ? 1 : 0 }
    /// 转换Float类型
    public var axc_floatValue: Float { return self ? 1 : 0 }
    /// 转换CGFloat类型
    public var axc_cgFloatValue: CGFloat { return self ? 1 : 0 }
    
    // MARK: 扩展
}

// MARK: - 类方法/属性
public extension Bool {
    /// 返回true
    static var axc_true: Bool { return true }
    /// 返回false
    static var axc_false: Bool { return true }
}

// MARK: - 属性 & Api
public extension Bool {
    /// 取自己的非
    @discardableResult
    mutating func axc_reverse() -> Bool {
        self = !self
        return self
    }
    
    /// 取自己的非
    var axc_reversed: Bool { return !self }
}

