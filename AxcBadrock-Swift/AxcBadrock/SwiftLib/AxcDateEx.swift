//
//  AxcDateEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 数据转换
public extension Date {
 // MARK: 协议
 // MARK: 扩展
}

// MARK: - 类方法/属性
public extension Date {
 // MARK: 协议
 // MARK: 扩展
}

// MARK: - 属性 & Api
public extension Date {
    /// 秒级-当前时间
    var axc_secondsTime: Int {
        return Int(self.timeIntervalSinceNow)
    }
    /// 毫秒级-当前时间
    var axc_milliTime: Int {
        return Int(round(Double(axc_secondsTime * 1000)))
    }
}

// MARK: - 【对象特性扩展区】
public extension Date {
 // MARK: 协议
 // MARK: 扩展
}

// MARK: - 决策判断
public extension Date {
 // MARK: 协议
 // MARK: 扩展
}

// MARK: - 操作符
public extension Date {
}

// MARK: - 运算符
public extension Date {
}
