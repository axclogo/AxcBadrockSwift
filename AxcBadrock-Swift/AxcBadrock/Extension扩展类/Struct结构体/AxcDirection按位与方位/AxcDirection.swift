//
//  File.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/19.
//

import UIKit

/// 方向结构体
public struct AxcDirection : OptionSet {
    public init(rawValue: UInt) { self.rawValue = rawValue }
    internal init(_ rawValue: UInt) { self.init(rawValue: rawValue) }
    public private(set) var rawValue: UInt
    
    public static var top:      AxcDirection { return AxcDirection(UInt(1) << 0) }
    public static var left:     AxcDirection { return AxcDirection(UInt(1) << 1) }
    public static var bottom:   AxcDirection { return AxcDirection(UInt(1) << 2) }
    public static var right:    AxcDirection { return AxcDirection(UInt(1) << 3) }
    public static var center:   AxcDirection { return AxcDirection(UInt(1) << 4) }
    
    /// 选择性使用可选区间
    /// - Parameter types: 可选
    /// - Returns: 是否为可选范围内
    public func selectType(_ types: [AxcDirection]) -> Bool {
        var select = false
        types.forEach{ if self == $0 { select = true; return } }
        if !select { AxcLog("[\(self)] 不是一个可选的的方位！\n可选值:\(types)", level: .warning) }
        return select
    }
}
