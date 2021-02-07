//
//  AxcUIImageEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

public extension UIImage {
    /// 将这个图片转换成base64字符
    var axc_base64String: String? {
        guard let data = self.pngData() else { return nil }
        return data.base64EncodedString(options: .lineLength64Characters)
    }
    
    /// 转成Data
    var axc_pngData: Data? {
        return self.pngData()
    }
    /// 压缩这个image生成data
    var axc_jpegData: Data? {
        return self.axc_jpegData()
    }
    /// 压缩这个image生成data
    func axc_jpegData(rate: CGFloat = 1) -> Data? {
        return self.jpegData(compressionQuality: rate)
    }
    
    /// 转换成富文本的附件对象
    func axc_textAttachment(_ type: String? = nil) -> NSTextAttachment {
        return NSTextAttachment(image: self)
    }
    
}
