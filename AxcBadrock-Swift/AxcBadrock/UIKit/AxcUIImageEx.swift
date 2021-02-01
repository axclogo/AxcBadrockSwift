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

}
