//
//  AxcCharacterEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/2.
//

import UIKit

// MARK: - 数据转换 - 协议
extension Character: AxcDataElementTransform {
    /// 转换NSNumber类型
    var axc_number: NSNumber? {
        return NumberFormatter().number(from: axc_strValue)
    }
    /// 转换String类型
    var axc_strValue: String {
        return String(self)
    }
    /// 转换UInt类型
    var axc_uIntValue: UInt {
        if let num = axc_number { return num.uintValue }
        else { return 0 }
    }
    /// 转换成Int类型
    var axc_intValue: Int {
        if let num = axc_number { return num.intValue }
        else { return 0 }
    }
    /// 转换成Double类型
    var axc_doubleValue: Double {
        if let num = axc_number { return num.doubleValue }
        else { return 0 }
    }
    /// 转换成Float类型
    var axc_floatValue: Float {
        if let num = axc_number { return num.floatValue }
        else { return 0 }
    }
    /// 转换成CGFloat类型
    var axc_cgFloatValue: CGFloat {
        if let num = axc_number { return CGFloat(truncating: num) }
        else { return 0 }
    }
}

// MARK: - 数据转换 - 扩展
extension Character {
    /// 转小写
    var axc_lowercased: Character { return String(self).lowercased().first! }
    
    /// 转大写
    var axc_uppercased: Character { return String(self).uppercased().first! }
}

// MARK: - 类方法/属性
extension Character {
    /// 获取一个随机的字符
    static func axc_random() -> Character {
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
    }
}

// MARK: - 属性 & Api
extension Character {
}

// MARK: - 决策判断
extension Character {
    /// 检查字符是否为Emoji
    var axc_isEmoji: Bool {
        let scalarValue = String(self).unicodeScalars.first!.value
        switch scalarValue {
        case 0x1F600...0x1F64F, // 表情符号
             0x1F300...0x1F5FF, // 杂项符号和象形文字
             0x1F680...0x1F6FF, // 运输和地图
             0x1F1E6...0x1F1FF, // 地区国家国旗
             0x2600...0x26FF,   // Misc符号
             0x2700...0x27BF,   // 装饰标志
             0xE0020...0xE007F, // 标志
             0xFE00...0xFE0F,   // 音符
             0x1F900...0x1F9FF, // 补充符号和象形文字
             127_000...127_600, // 各种亚洲字符
             65024...65039,     // 选择器
             9100...9300,       // Misc 元素
             8400...8447:       // 组合变音符符号为符号
            return true
        default:
            return false
        }
    }
    
}

// MARK: - 操作符
extension Character {
}

// MARK: - 运算符
extension Character {
    /// 这个字符乘几次
    ///  "a" * 3 -> "aaa"
    /// - Parameters:
    ///   - lhs: 准备乘的字符
    ///   - rhs: 倍数
    static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }
    
    /// 乘几次这个字符串
    ///  3 * "a" -> "aaa"
    /// - Parameters:
    ///   - lhs: 倍数
    ///   - rhs: 准备乘的字符
    static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }
}
