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
        guard let cgimage = axc_cgImage else { return UIImage() }
        return UIImage(cgImage: cgimage )
    }
    
    /// 转换成CGImage
    var axc_cgImage: CGImage? {
        let context = CIContext()
        let cgImage: CGImage = context.createCGImage(self, from: self.extent)!
        return cgImage
    }
    
    /// 转换成高清CGImage
    func axc_hdImage(_ size: CGSize = CGSize.axc_byteMaxSize ) -> CGImage? {
        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(self, from: extent)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height),
                                      bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let scale = min(size.width / extent.width, size.height / extent.height)
        bitmapContext!.interpolationQuality = CGInterpolationQuality.none
        bitmapContext?.scaleBy(x: scale, y: scale)
        bitmapContext?.draw(bitmapImage!, in: extent)
        guard let scaledImage = bitmapContext?.makeImage() else { return nil }
        return scaledImage
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
