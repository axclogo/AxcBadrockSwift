//
//  AxcUrlEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/8.
//

import Foundation


// MARK: - 数据转换
public extension URL {
    /// 转换成字符串
    var axc_strValue: String? { return self.absoluteString }
    
    /// 转换成URLComponents
    var axc_urlComponents: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)
    }
}

// MARK: - 类方法/属性
public extension URL {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
public extension URL {
    
    /// 向url尾部添加参数
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.axc_appendQueryParam(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: 参数字典
    /// - Returns: 添加后参数后的Url
    mutating func axc_addParam(_ param: [String: String]) {
        guard var urlComponents = axc_urlComponents else { return }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) +
            param.map { URLQueryItem(name: $0, value: $1) }
        guard let url = urlComponents.url else { return }
        self = url
    }
    
    /// 通过key获取参数中的值
    /// - Parameter key: String
    /// - Returns: String
    func axc_value(for key: String) -> String? {
        return URLComponents(string: absoluteString)?.queryItems?.first(where: { $0.name == key })? .value
    }
    
}

// MARK: - 【对象特性扩展区】
public extension URL {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension URL {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension URL {
    /// 使url取值能像字典一样
    ///
    ///     var url = "https://google.com".axc_url
    ///     url["123"] = "456" -> "https://google.com?123=456"
    ///
    subscript(_ key: String) -> String? {
        set{ if (newValue != nil) { self.axc_addParam([key:newValue!]) } }
        get{ return self.axc_value(for: key) }
    }
}

// MARK: - 运算符
public extension URL {
    
    /// 向Url中加一段键值对
    ///
    ///     "https://google.com".axc_url + ["axc":"Swifter"] -> "https://google.com?axc=Swifter"
    ///
    static func + (leftValue: URL, rightValue: [String:String]) -> URL? {
        var url = leftValue
        url.axc_addParam(rightValue)
        return url
    }
    
//    static func - (leftValue: URL, rightValue: String) -> URL{
//        return leftValue.axc_queryAddParam(rightValue)
//    }
}
