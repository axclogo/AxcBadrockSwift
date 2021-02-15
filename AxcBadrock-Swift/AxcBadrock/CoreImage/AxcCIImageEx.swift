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
    /// 转换成CGImage
    var axc_cgImage: CGImage {
        let context = CIContext()
        let cgImage: CGImage = context.createCGImage(self, from: self.extent)!
        return cgImage
    }
    
    
}

// MARK: - 类方法/属性
public extension CIImage {
}

// MARK: - 属性 & Api
public extension CIImage {
    /// 合并两张图
    func axc_backgroundCIImage(_ backgroundCIImage: CIImage ) -> CIImage? {
        let filter = CIFilter(name: "CISourceOverCompositing")!
        filter.setValue(self, forKey: "inputImage")
        filter.setValue(backgroundCIImage, forKey: "inputBackgroundImage")
        return filter.outputImage
    }
    /// 图片旋转 0 - 320
    func axc_rotate(angle: CGFloat) -> CIImage {
        return axc_rotate(radians: angle.axc_angleToRadian)
    }
    /// 图片旋转 0 - 2.pi
    func axc_rotate(radians: CGFloat) -> CIImage {
        return self.transformed(by: CGAffineTransform(rotationAngle: radians))
    }
}

// MARK: - 决策判断
public extension CIImage {
}

// MARK: - 操作符
public extension CIImage {
}

// MARK: - 运算符
public extension CIImage {
}
