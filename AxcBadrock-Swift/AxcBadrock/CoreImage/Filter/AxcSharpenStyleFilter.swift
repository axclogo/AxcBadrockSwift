//
//  AxcSharpenStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit

// MARK: - 锐化滤镜组对象
public class AxcSharpenStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcSharpenStyleFilter {
    /// 渲染提高亮度滤镜
    var axc_sharpenLuminanceFilter: AxcSharpenLuminanceFilter {
        return AxcSharpenLuminanceFilter().axc_inputUIImage(image).axc_sharpness(0.5)
    }
}

// MARK: - 所有可选滤镜
/// 提高亮度滤镜
public class AxcSharpenLuminanceFilter: AxcBaseFilter,
                                        AxcFilterSharpnessInterFace {
    override func setFilterName() -> String { return "CISharpenLuminance" }
}

