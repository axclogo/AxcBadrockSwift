//
//  AxcBaseFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit
import CoreImage

// MARK: - 基类
public class AxcBaseFilter {
    /// 滤镜对象
    lazy var filter: CIFilter? = {
        return CIFilter(name: setFilterName())
    }()
    /// 子类设置自己需要的滤镜名字
    func setFilterName() -> String {
        return ""
    }
    // 资源图片
    private var sourceImage: CIImage?
    // 上下文
    private lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    /// 设置CI图片对象
    @discardableResult
    func axc_inputCIImage(_ inputCIImage: CIImage? ) -> Self {
        sourceImage = inputCIImage
        self.filter?.setValue(sourceImage, forKey: "inputImage")
        return self
    }
    /// 设置CG图片对象
    @discardableResult
    func axc_inputCGImage(_ inputCGImage: CGImage? ) -> Self {
        guard let cgImage = inputCGImage else { return self }
        return axc_inputCIImage( CIImage(cgImage: cgImage) )
    }
    /// 设置UI图片对象
    @discardableResult
    func axc_inputUIImage(_ inputUIImage: UIImage? ) -> Self {
        guard let cgImage = inputUIImage?.cgImage else { return self }
        return axc_inputCGImage(cgImage)
    }
    
    /// 获取渲染后的CIImage
    var axc_ciImage: CIImage? {
        guard let ciImage = filter?.outputImage else { return nil }
        guard let rect = sourceImage?.extent else { return nil }
        guard let cgImage = context.createCGImage(ciImage, from: rect) else { return nil }
        return CIImage(cgImage: cgImage)
    }
    /// 获取渲染后的CIImage
    var axc_cgImage: CGImage? {
        return axc_ciImage?.cgImage
    }
    /// 获取渲染后的UIImage
    var axc_uiImage: UIImage? {
        return axc_ciImage?.axc_image
    }
}

// MARK: - 协议接口
/// 半径参数的接口协议
public protocol AxcFilterRadiusInterFace {}
public extension AxcFilterRadiusInterFace where Self : AxcBaseFilter {
    /// 设置半径
    @discardableResult
    func axc_radius(_ radius: CGFloat = 0 ) -> Self {
        self.filter?.setValue(radius.axc_number, forKey: "inputRadius")
        return self
    }
}

/// 遮罩参数的接口协议
public protocol AxcFilterMaskInterFace {}
public extension AxcFilterMaskInterFace where Self : AxcBaseFilter {
    /// 设置遮罩
    @discardableResult
    func axc_mask(_ mask: CIImage ) -> Self {
        self.filter?.setValue(mask, forKey: "inputMask")
        return self
    }
}

/// 角度参数的接口协议
public protocol AxcFilterAngleInterFace {}
public extension AxcFilterAngleInterFace where Self : AxcBaseFilter {
    /// 设置角度，取值 0 ～ 360，默认0 也就是 .pi
    @discardableResult
    func axc_angle(_ angle: CGFloat = 0 ) -> Self {
        return axc_radian(angle.axc_angleToRadian)
    }
    /// 设置弧度，取值 0 ～ 2.pi，默认0
    @discardableResult
    func axc_radian(_ radian: CGFloat = 0 ) -> Self {
        self.filter?.setValue(radian.axc_number, forKey: "inputAngle")
        return self
    }
}

/// 数量，程度参数的接口协议
public protocol AxcFilterAmountInterFace {}
public extension AxcFilterAmountInterFace where Self : AxcBaseFilter {
    /// 设置数量，程度
    @discardableResult
    func axc_amount(_ amount: CGFloat = 0 ) -> Self {
        self.filter?.setValue(amount.axc_number, forKey: "inputAmount")
        return self
    }
}

/// 中心参数的接口协议
public protocol AxcFilterCenterInterFace {}
public extension AxcFilterCenterInterFace where Self : AxcBaseFilter {
    /// 设置中心 CIVector
    @discardableResult
    func axc_center(_ center: CIVector ) -> Self {
        self.filter?.setValue(center, forKey: "inputCenter")
        return self
    }
    /// 设置中心 CGPoint
    @discardableResult
    func axc_center(_ center: CGPoint ) -> Self {
        return axc_center(CIVector(cgPoint: center))
    }
}


