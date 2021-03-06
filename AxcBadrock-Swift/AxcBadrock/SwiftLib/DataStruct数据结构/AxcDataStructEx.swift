//
//  AxcDataStructEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import UIKit

// MARK: - Data/String类型转换
public protocol  AxcDataStringTransform {}
public extension AxcDataStringTransform where Self : Collection {
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
