//
//  AxcDataEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/2.
//

import UIKit
import CommonCrypto

extension Data {
    var axc_base64Str: String {
        return base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}
extension Data {
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

extension Data {
    /// Sign data to an array of UInt8
     func axc_hashSignBytes(_ algorithm:AxcAlgorithm_Hmac, key:String) -> [UInt8]{
        let string = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        let stringLength = self.count
        let digestLength = algorithm.axc_digestLength
        let keyString = key.cString(using: String.Encoding.utf8)!
        let keyLength = key.lengthOfBytes(using: String.Encoding.utf8)
        var result = [UInt8](repeating: 0, count: digestLength)
        CCHmac(algorithm.axc_toCCEnum, keyString, keyLength, string, stringLength, &result)
        return result
    }
    /// Sign with an algorithm
     func axc_hashSignData(_ algorithm:AxcAlgorithm_Hmac, key:String) -> Data {
        let bytes = self.axc_hashSignBytes(algorithm, key: key)
        let data = Data(bytes: bytes, count: bytes.count)
        return data
    }
    /// Sign a data and export to a hexadecimal string
     func axc_hashSignStr(_ algorithm:AxcAlgorithm_Hmac, key:String)->String {
        let bytes = self.axc_hashSignBytes(algorithm, key: key)
        let digestLength = bytes.count
        var hash: String = ""
        for i in 0..<digestLength {
            hash += String(format: "%02x", bytes[i])
        }
        return hash
    }
    /// Sign a data and export to a base64 string
     func axc_hashSignBase64(_ algorithm:AxcAlgorithm_Hmac, key:String) -> String {
        let data = self.axc_hashSignData(algorithm, key: key)
        return data.axc_base64Str
    }
    
}
