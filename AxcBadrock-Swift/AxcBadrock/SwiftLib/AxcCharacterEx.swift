//
//  AxcCharacterEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/2.
//

public extension Character {
    
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
