//
//  AxcIntEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

// MARK: - 数据转换
extension Int: AxcDataElementTransform {
    // MARK: 协议
    /// 转换NSNumber类型
    public var axc_number: NSNumber? { return NSNumber(value: self) }
    /// 转换String类型
    public var axc_strValue: String {  return String(self) }
    /// 转换为Bool类型
    public var axc_boolValue: Bool { return self.axc_isPositive }
    /// 转换Int类型
    public var axc_intValue: Int { return self }
    /// 转换UInt类型
    public var axc_uIntValue: UInt {  return UInt(self) }
    /// 转换Double类型
    public var axc_doubleValue: Double { return Double(self) }
    /// 转换Float类型
    public var axc_floatValue: Float { return Float(self) }
    /// 转换CGFloat类型
    public var axc_cgFloatValue: CGFloat {  return CGFloat(self) }
    
}

// MARK: - 类方法/属性
extension Int: AxcDataElementMaxMinValue {
    // MARK: 协议
    /// 最大值
    public static var axc_max: Int { return Int.max }
    /// 最小值
    public static var axc_min: Int { return Int.min }
    
    // MARK: 扩展
    /// 秒级-当前时间
    public static var axc_secondsTime: Int { return Date().axc_second }
    
    /// 毫秒级-当前时间
    public static var axc_milliTime: Int { return Date().axc_millisecond }
}

// MARK: - 属性 & Api
extension Int: AxcDataElementMath {
    // MARK: 协议
    /// 取几次幂
    public func axc_power(_ power: Double) -> Double { return self *^ power }
    /// 求平方根
    public var axc_sqrtRoot: Double { return √self }
    
    // MARK: 扩展
    /// 数字位数
    public var axc_digitsCount: Int {
        guard self != 0 else { return 1 }
        let number = Double(axc_abs)
        return Int(log10(number) + 1)
    }
    
    /// 数字位数组成的数组
    public var axc_digits: [Int] {
        guard self != 0 else { return [0] }
        var digits = [Int]()
        var number = axc_abs
        while number != 0 {
            let xNumber = number % 10
            digits.append(xNumber)
            number /= 10
        }
        digits.reverse()    // 反向
        return digits
    }
}

// MARK: - 决策判断
public extension Int {
    /// 是否为素数
    /// 警告：使用大数在计算上可能会很费时
    var axc_isPrime: Bool {
        if self == 2 { return true }
        guard self > 1, self % 2 != 0 else { return false }
        let base = Int(sqrt(Double(self)))
        for int in Swift.stride(from: 3, through: base, by: 2) where self % int == 0 { return false }
        return true
    }
}
