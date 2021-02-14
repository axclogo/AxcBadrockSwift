//
//  AxcReductionStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/14.
//

import UIKit

// MARK: - 风格化滤镜组对象
public class AxcReductionStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcReductionStyleFilter {
    /// 渲染一个单像素图像，其中包含一块颜色区内的平均颜色滤镜
    var axc_areaHistogramFilter: AxcAreaHistogramFilter {
        let filter = AxcAreaHistogramFilter().axc_inputUIImage(image).axc_radius(10)
//        guard let img = image else { return filter }
//        filter.axc_extent( CIVector(values: [0.0, 0.0, img.axc_width, img.axc_height], count: 4) )
        return filter
    }
}

/// 返回一个单像素图像，其中包含一块颜色区内的平均颜色
public class AxcAreaHistogramFilter: AxcBaseFilter,
                                     AxcFilterImageInterFace,
                                     AxcFilterRadiusInterFace {
    override func setFilterName() -> String { return "CIBoxBlur" }
}

