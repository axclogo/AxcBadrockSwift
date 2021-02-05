//
//  AxcGlobalFunc.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

/// RGB颜色
/// - Parameters:
///   - r: 红
///   - g: 绿
///   - b: 蓝
///   - a: 透明度 0-1
func AxcRGB(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat, a: CGFloat = 1) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}





