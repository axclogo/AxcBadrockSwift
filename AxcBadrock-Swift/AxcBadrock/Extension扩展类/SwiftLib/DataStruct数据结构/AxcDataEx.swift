//
//  AxcDataEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/2.
//

import UIKit
import CommonCrypto

// MARK: - 数据转换
public extension Data {
    // MARK: Foundation转换
    /// 通过utf8来返回字符串
    var axc_strValue: String? {
        return axc_strValue()
    }
    /// 通过给定的编码来返回字符串
    func axc_strValue(_ encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// 转换为Base64字符串
    var axc_base64Str: String {
        return base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    /// 转换为十六进制字符串
    var axc_hexStr : String {
        let string = NSMutableString(capacity: count * 2)
        var byte: UInt8 = 0
        for i in 0 ..< count {
            copyBytes(to: &byte, from: i..<index(after: i))
            string.appendFormat("%02x", byte)
        }
        return string as String
    }
    
    /// 转换成富文本的附件对象
    var axc_textAttachment: NSTextAttachment {
        return axc_textAttachment()
    }
    /// 转换成富文本的附件对象
    func axc_textAttachment(_ type: String? = nil) -> NSTextAttachment {
        return NSTextAttachment(data: self, ofType: type)
    }
    /// 转换成Json对象
    var axc_jsonObj: Any? {
        return axc_jsonObj()
    }
    /// 根据选择转换成数据对象
    func axc_jsonObj(options: JSONSerialization.ReadingOptions = .mutableContainers) -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: options)
    }
    
    /// 以字节数组的形式返回数据
    var axc_bytes: [UInt8] { return [UInt8](self) }
    
    /// 以字节数组的形式返回数据
    func axc_byteArray() -> [UInt8] {
        let count = self.count / MemoryLayout<UInt8>.size
        var bytesArray = [UInt8](repeating: 0, count: count)
        (self as NSData).getBytes(&bytesArray, length:count * MemoryLayout<UInt8>.size)
        return bytesArray
    }
    
    // MARK: UIKit转换
    /// data转图片
    var axc_image: UIImage? {
        return UIImage(data: self)
    }
}

// MARK: - 类方法/属性
public extension Data {
}

// MARK: - 属性 & Api
public extension Data {
    
 
}

// MARK: - Hash摘要算法
public extension Data {
    /// 获取摘要字符串
    func axc_hashDigestStr(_ algorithm:AxcAlgorithm_Digest)->String{
        let digestLength = algorithm.axc_digestLength
        let bytes = self.axc_hashDigestBytes(algorithm)
        var hashString: String = ""
        for i in 0..<digestLength {
            hashString += String(format: "%02x", bytes[i])
        }
        return hashString
    }
    /// 获取摘要[UInt8]数组
    func axc_hashDigestBytes(_ algorithm:AxcAlgorithm_Digest)->[UInt8]{
        let string = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        let stringLength = UInt32(self.count)
        let closure = algorithm.axc_progressClosure()
        let bytes = closure(string, stringLength)
        return bytes
    }
    /// 获取Data摘要
    func axc_hashDigestData(_ algorithm:AxcAlgorithm_Digest)->Data{
        let bytes = self.axc_hashDigestBytes(algorithm)
        return Data(bytes: bytes, count: bytes.count)
    }
    /// 获取摘要的Base64字符串
    func axc_hashDigestBase64(_ algorithm:AxcAlgorithm_Digest)->String{
        let data = self.axc_hashDigestData(algorithm)
        return data.axc_base64Str
    }
    
}

// MARK: - Hmac签名算法
public extension Data {
    /// 获取签名字符串
    func axc_hamcSignStr(_ algorithm: AxcAlgorithm_Hmac, key: String)->String {
        let bytes = self.axc_hamcSignBytes(algorithm, key: key)
        let digestLength = bytes.count
        var hash: String = ""
        for i in 0..<digestLength {
            hash += String(format: "%02x", bytes[i])
        }
        return hash
    }
    /// 获取签名[UInt8]数组
    func axc_hamcSignBytes(_ algorithm: AxcAlgorithm_Hmac, key: String) -> [UInt8]{
        let string = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        let stringLength = self.count
        let digestLength = algorithm.axc_digestLength
        let keyString = key.cString(using: String.Encoding.utf8)!
        let keyLength = key.lengthOfBytes(using: String.Encoding.utf8)
        var result = [UInt8](repeating: 0, count: digestLength)
        CCHmac(algorithm.axc_toCCEnum, keyString, keyLength, string, stringLength, &result)
        return result
    }
    /// 获取Data签名
    func axc_hamcSignData(_ algorithm: AxcAlgorithm_Hmac, key: String) -> Data {
        let bytes = self.axc_hamcSignBytes(algorithm, key: key)
        let data = Data(bytes: bytes, count: bytes.count)
        return data
    }
    /// 获取签名的Base64字符串
    func axc_hamcSignBase64(_ algorithm: AxcAlgorithm_Hmac, key: String) -> String {
        let data = self.axc_hamcSignData(algorithm, key: key)
        return data.axc_base64Str
    }
}
