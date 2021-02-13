//
//  AxcStylizeStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit

// MARK: - 风格化滤镜组对象
public class AxcStylizeStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcStylizeStyleFilter {
    /// 渲染Alpha蒙版混合滤镜
    /// 输入图片被maskImage图片形状镂空
    /// 后透出backgroundImage
    var axc_blendWithAlphaMaskFilter: AxcBlendWithAlphaMaskFilter {
        return AxcBlendWithAlphaMaskFilter().axc_inputUIImage(image)
    }
    /// 渲染蒙版混合滤镜
    /// 输入图片被maskImage带颜色部分镂空
    /// 后透出backgroundImage
    var axc_blendWithMaskFilter: AxcBlendWithMaskFilter {
        return AxcBlendWithMaskFilter().axc_inputUIImage(image)
    }
    /// 渲染Bloom布鲁姆滤镜
    var axc_bloomFilter: AxcBloomFilter {
        return AxcBloomFilter().axc_inputUIImage(image).axc_radius(10).axc_intensity(1)
    }
    /// 渲染像漫画书一样勾勒（图像）边缘，并应用半色调效果滤镜
    var axc_comicEffectFilter: AxcComicEffectFilter {
        return AxcComicEffectFilter().axc_inputUIImage(image)
    }
    /// 渲染用一个3x3旋转矩阵来调整像素值滤镜
    var axc_convolution3x3Filter: AxcConvolution3X3Filter {
        let vector = CIVector(values: [0.0, 0.0, 0.0,
                                       0.0, 1.0, 0.0,
                                       0.0, 0.0, 0.0], count: 9)
        return AxcConvolution3X3Filter().axc_inputUIImage(image).axc_bias(0).axc_weights(vector)
    }
    /// 渲染用一个5x5旋转矩阵来调整像素值滤镜
    var axc_convolution5x5Filter: AxcConvolution5X5Filter {
        let vector = CIVector(values: [0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 1.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0], count: 25)
        return AxcConvolution5X5Filter().axc_inputUIImage(image).axc_bias(0).axc_weights(vector)
    }
    /// 渲染用一个7x7旋转矩阵来调整像素值滤镜
    var axc_convolution7x7Filter: AxcConvolution7X7Filter {
        let vector = CIVector(values: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], count: 49)
        return AxcConvolution7X7Filter().axc_inputUIImage(image).axc_bias(0).axc_weights(vector)
    }
    
}

// MARK: - 所有可选滤镜
/// Alpha蒙版混合滤镜
public class AxcBlendWithAlphaMaskFilter: AxcBaseFilter,
                                          AxcFilterBackgroundImageInterFace,    // 设置底部图片
                                          AxcFilterMaskImageInterFace {         // 设置切割的遮罩层图
    override func setFilterName() -> String { return "CIBlendWithAlphaMask" }
}

/// 蒙版混合滤镜
public class AxcBlendWithMaskFilter: AxcBaseFilter,
                                          AxcFilterBackgroundImageInterFace,    // 设置底部图片
                                          AxcFilterMaskImageInterFace {         // 设置切割的遮罩层图
    override func setFilterName() -> String { return "CIBlendWithMask" }
}

/// Bloom布鲁姆滤镜
public class AxcBloomFilter: AxcBaseFilter,
                             AxcFilterRadiusInterFace,
                             AxcFilterIntensityInterFace {
    override func setFilterName() -> String { return "CIBloom" }
}

/// 像漫画书一样勾勒（图像）边缘，并应用半色调效果
public class AxcComicEffectFilter: AxcBaseFilter {
    override func setFilterName() -> String { return "CIComicEffect" }
}

/// 用一个3x3旋转矩阵来调整像素值
public class AxcConvolution3X3Filter: AxcBaseFilter,
                                      AxcFilterBiasInterFace,
                                      AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution3X3" }
}

/// 用一个5x5旋转矩阵来调整像素值
public class AxcConvolution5X5Filter: AxcBaseFilter,
                                      AxcFilterBiasInterFace,
                                      AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution5X5" }
}

/// 用一个7x7旋转矩阵来调整像素值
public class AxcConvolution7X7Filter: AxcBaseFilter,
                                      AxcFilterBiasInterFace,
                                      AxcFilterWeightsInterFace {
    override func setFilterName() -> String { return "CIConvolution7X7" }
}


