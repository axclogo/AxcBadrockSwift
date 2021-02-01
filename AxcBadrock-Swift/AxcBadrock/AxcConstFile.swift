//
//  AxcConstFile.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

/// CGFloat支持的最小正数值
let AxcFloat_Min = CGFloat.axc_MIN

/// CGFloat支持的最大值
let AxcFloat_Max = CGFloat.axc_MAX

/// RGB颜色
/// - Parameters:
///   - r: 红
///   - g: 绿
///   - b: 蓝
///   - a: 透明度 0-1
/// - Returns: 颜色
func Axc_RGB(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat, a: CGFloat = 1) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func currentLanguage() -> String {
    return NSLocale.preferredLanguages.first!
}

func systemVersion() -> String {
    return UIDevice.current.systemVersion
}

//func appVersion() -> String {
//    return String(Bundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]!)
//}
