//
//  AxcIntEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

// MARK: - 数据转换 - 协议
extension Int: AxcDataElementTransform {
    /// 转换NSNumber类型
    var axc_number: NSNumber? { return NSNumber(value: self) }
    /// 转换String类型
    var axc_strValue: String {  return String(self) }
    /// 转换Int类型
    var axc_intValue: Int { return self }
    /// 转换UInt类型
    var axc_uIntValue: UInt {  return UInt(self) }
    /// 转换Double类型
    var axc_doubleValue: Double { return Double(self) }
    /// 转换Float类型
    var axc_floatValue: Float { return Float(self) }
    /// 转换CGFloat类型
    var axc_cgFloatValue: CGFloat {  return CGFloat(self) }
}

// MARK: - 数据转换 - 扩展
extension Int {
    /// 转换为k单位的数据字符串
    /// 1k, -2k, 100k, 1kk, -5kk..
    var axc_unit_K: String {
        var sign: String { return self >= 0 ? "" : "-" }
        let abs = Swift.abs(self)
        if abs == 0                             { return "0k" }
        else if abs >= 0, abs < 1000            { return "0k" }
        else if abs >= 1000, abs < 1_000_000    { return String(format: "\(sign)%ik", abs / 1000) }
        return String(format: "\(sign)%ikk", abs / 100_000)
    }
    
    /// 转换为罗马数字
    var axc_roman: String? {
        guard self > 0 else {  return nil }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        var romanValue = ""
        var startingValue = self
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            for _ in 0..<div {
                romanValue.append(romanChar)
            }
            startingValue -= arabicValue * div
        }
        return romanValue
    }
}

// MARK: - 类方法/属性
extension Int {
}

// MARK: - 属性 & Api
extension Int {
    /// 数字位数
    var axc_digitsCount: Int {
        guard self != 0 else { return 1 }
        let number = Double(abs)
        return Int(log10(number) + 1)
    }
}

// MARK: - 决策判断
extension Int {
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

// MARK: - 操作符
extension Int {
}

// MARK: - 运算符
extension Int {
}
