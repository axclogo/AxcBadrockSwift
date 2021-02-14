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
    
    /// 合并两张图
    func axc_addBackgroundCIImage(_ backgroundCIImage: CIImage ) -> CIImage? {
        let filter = CIFilter(name: "CISourceOverCompositing")!
        filter.setValue(self, forKey: "inputImage")
        filter.setValue(backgroundCIImage, forKey: "inputBackgroundImage")
        return filter.outputImage
    }
}
