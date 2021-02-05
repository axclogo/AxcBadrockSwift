//
//  AxcDictionaryEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import Foundation

// MARK: - 数据转换
public extension Dictionary {
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
public extension Dictionary where Value: Equatable {
    /// 获取一个Value的所有Key
    func axc_keysFor(value: Value) -> [Key] {
        return keys.filter { self[$0] == value }
    }
}
public extension Dictionary where Key: StringProtocol {
    /// 将所有的key键转换为小写
    mutating func axc_lowercaseAllKeys() {
        for key in keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = removeValue(forKey: key)
            }
        }
    }
}
public extension Dictionary {
    /// 随机返回一个值
    var axc_random: Value? { return Array(values).axc_random }
    
    /// 随机移除一个键值对
    @discardableResult
    mutating func axc_removeRandomKey() -> Value? {
        guard let randomKey = keys.randomElement() else { return nil }
        return removeValue(forKey: randomKey)
    }
    
    /// 过滤筛选一个字典
    func axc_filter(_ test: (Key, Value) -> Bool) -> Dictionary {
        var result = Dictionary()
        for (key, value) in self {
            if test(key, value) {
                result[key] = value
            }
        }
        return result
    }
}

// MARK: - 决策判断
public extension Dictionary {
    /// 判断这个Key是否存在
    func axc_isHasKey(_ key: Key) -> Bool { return index(forKey: key) != nil }
}

// MARK: - 操作符
public extension Dictionary {
}

// MARK: - 运算符
public extension Dictionary {
    /// 使两个字典相加
    ///
    /// let dict: [String: String] = ["key1": "value1"]
    /// let dict2: [String: String] = ["key2": "value2"]
    /// let result = dict + dict2
    /// result["key1"] -> "value1"
    /// result["key2"] -> "value2"
    ///
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    /// 将第二个字典中的键和值附加到第一个字典中
    ///
    /// var dict: [String: String] = ["key1": "value1"]
    /// let dict2: [String: String] = ["key2": "value2"]
    /// dict += dict2
    /// dict["key1"] -> "value1"
    /// dict["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1 }
    }
    
    /// 从字典中删除序列中包含的键
    ///
    /// let dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
    /// let result = dict-["key1", "key2"]
    /// result.keys.contains("key3") -> true
    /// result.keys.contains("key1") -> false
    /// result.keys.contains("key2") -> false
    ///
    static func - <S: Sequence>(lhs: [Key: Value], keys: S) -> [Key: Value] where S.Element == Key {
        var result = lhs
        keys.forEach { result.removeValue(forKey: $0) }
        return result
    }
    
    /// 删除序列中包含的键附加到字典中
    ///
    ///        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
    ///        dict-=["key1", "key2"]
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    static func -= <S: Sequence>(lhs: inout [Key: Value], keys: S) where S.Element == Key {
        keys.forEach { lhs.removeValue(forKey: $0) }
    }
}
