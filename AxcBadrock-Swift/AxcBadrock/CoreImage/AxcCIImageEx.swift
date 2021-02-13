//
//  AxcCIImageEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit
import CoreImage

// MARK: - 数据转换
public extension CIImage {
    /// 转换成UIImage
    var axc_image: UIImage {
        return UIImage(ciImage: self)
    }
}
