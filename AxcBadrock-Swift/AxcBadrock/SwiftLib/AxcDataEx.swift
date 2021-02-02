//
//  AxcDataEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/2.
//

import UIKit


public extension Data {
    /// 获取摘要字符串
    func axc_digestStr(_ algorithm:AxcDigestAlgorithm)->String{
        let digestLength = algorithm.axc_digestLength
        let bytes = self.axc_digestBytes(algorithm)
        var hashString: String = ""
        for i in 0..<digestLength {
            hashString += String(format: "%02x", bytes[i])
        }
        return hashString
    }
    /// 获取摘要[UInt8]数组
    func axc_digestBytes(_ algorithm:AxcDigestAlgorithm)->[UInt8]{
        let string = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        let stringLength = UInt32(self.count)
        let closure = algorithm.axc_progressClosure()
        let bytes = closure(string, stringLength)
        return bytes
    }
    /// 获取Data摘要
    func axc_digestData(_ algorithm:AxcDigestAlgorithm)->Data{
        let bytes = self.axc_digestBytes(algorithm)
        return Data(bytes: bytes, count: bytes.count)
    }
    /// 获取摘要的Base64字符串
    func axc_digestBase64(_ algorithm:AxcDigestAlgorithm)->String{
        let data = self.axc_digestData(algorithm)
        return data.axc_base64Str
    }
    
    var axc_base64Str: String {
        return base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}
