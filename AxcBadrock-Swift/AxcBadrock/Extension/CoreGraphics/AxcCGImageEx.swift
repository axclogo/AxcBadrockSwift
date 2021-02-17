//
//  AxcCGImageEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/15.
//

import UIKit

// MARK: - 数据转换
public extension CGImage {
    /// 转CIImage
    var axc_ciImage: CIImage {
        return CIImage(cgImage: self)
    }
    /// 转UIImage
    var axc_image: UIImage {
        return UIImage(cgImage: self)
    }
}

// MARK: - 类方法/属性
public extension CGImage {
}

// MARK: - 属性 & Api
public extension CGImage {
    /// 图片旋转 0 - 320
    func axc_rotate(angle: CGFloat) -> CGImage? {
        return axc_rotate(radians: angle.axc_angleToRadian)
    }
    /// 图片旋转 0 - 2.pi
    func axc_rotate(radians: CGFloat) -> CGImage? {
        let ciImage = CIImage(cgImage: self)
        return ciImage.axc_rotate(radians: radians).axc_cgImage
    }
}

// MARK: - 决策判断
public extension CGImage {
}

// MARK: - 操作符
public extension CGImage {
}

// MARK: - 运算符
public extension CGImage {
}
