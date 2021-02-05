//
//  AxcArrayEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import Foundation


// MARK: - 数据转换
public extension Array {
    /// 转换成JsonData
    func axc_jsonData(options: JSONSerialization.WritingOptions = .prettyPrinted) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    /// 转换成JsonString
    var axc_jsonStr: String? {
        guard let jsonData = axc_jsonData() else { return nil }
        return jsonData.axc_strValue
    }
}

// MARK: - 属性 & Api
public extension Array {
    /// 随机返回一个值
    var axc_random: Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /// 获取一个洗牌乱序打乱数组
    var axc_shuffleArr: Array {
        var result = self
        result.shuffle()
        return result
    }
    
    /// 根据索引获取元素
    func axc_obj(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    /// 向头部插入一个元素
    mutating func axc_insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    /// 安全移动一个元素form Idx 到 to idx
    mutating func axc_move(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
}
/// 当数组元素为String时，增加以下扩展
public extension Array where Element == String {
    /// 拼接字符串
    var axc_joint: String {
        return axc_joint()
    }
    /// 拼接字符串
    func axc_joint(_ jointStr: String = "") -> String {
        return self.joined(separator: jointStr)
    }
    /// 排重
    mutating func axc_removeRepeat(){
        var dic: [String:String] = [:]
        forEach{ dic[$0] = "" }
        self = [String](dic.keys)
    }
    /// 排空
    mutating func axc_removeEmpty(){
        self = filter{ !$0.isEmpty || $0.count != 0 }
    }

}

// MARK: - 快速取值
public extension Array  {
    // MARK: 顺序取值
    /// 获取第1个元素
    var axc_firstObj: Any? { guard let obj = self.first else { return nil }
        return obj
    }
    /// 获取第2个元素
    var axc_secondObj: Any? { guard let obj = self.axc_obj(at: 1) else { return nil }
        return obj
    }
    /// 获取第3个元素
    var axc_thirdObj: Any? { guard let obj = self.axc_obj(at: 2) else { return nil }
        return obj
    }
    /// 获取第4个元素
    var axc_fourthObj: Any? { guard let obj = self.axc_obj(at: 3) else { return nil }
        return obj
    }
    /// 获取第5个元素
    var axc_fifthObj: Any? { guard let obj = self.axc_obj(at: 4) else { return nil }
        return obj
    }
    
    // MARK: 倒序取值
    /// 获取倒数第1个元素
    var axc_lastObj: Any? { guard let obj = self.last else { return nil }
        return obj
    }
    /// 获取倒数第2个元素
    var axc_lastSecondObj: Any? { guard let obj = self.axc_obj(at: self.count - 2) else { return nil }
        return obj
    }
    /// 获取倒数第3个元素
    var axc_lastThirdObj: Any? { guard let obj = self.axc_obj(at: self.count - 3) else { return nil }
        return obj
    }
    /// 获取倒数第4个元素
    var axc_lastFourthObj: Any? { guard let obj = self.axc_obj(at: self.count - 4) else { return nil }
        return obj
    }
    /// 获取倒数第5个元素
    var axc_lastFifthObj: Any? { guard let obj = self.axc_obj(at: self.count - 5) else { return nil }
        return obj
    }
    
}
