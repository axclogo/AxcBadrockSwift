//
//  AxcConstFile.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit


// MARK: - 系统单例
/// Bundle
let Axc_bundle               = Bundle.main
/// infoDictionary
let Axc_infoDictionary       = Axc_bundle.infoDictionary
/// FileManager
let Axc_fileManager          = FileManager.default
/// UserDefaults
let Axc_userDefaults         = UserDefaults.standard
/// NotificationCenter
let Axc_notificationCenter   = NotificationCenter.default
/// Application
let Axc_application          = UIApplication.shared
/// AppDelegate
let Axc_appDelegate          = Axc_application.delegate

// MARK: - 常用常量
// MARK: UI尺寸数据
/// CGFloat支持的最小正数值
let Axc_floatMin = CGFloat.axc_min
/// CGFloat支持的最大值
let Axc_floatMax = CGFloat.axc_max

/// 屏大小
let Axc_screenSize = UIScreen.main.bounds.size
/// 屏宽
let Axc_screenWidth = Axc_screenSize.width
/// 屏高
let Axc_screenHeight = Axc_screenSize.height
/// 状态栏高度
var Axc_statusHeight: CGFloat {
    if #available(iOS 13.0, *) { return Axc_application.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }
    else { return Axc_application.statusBarFrame.size.height }
}

// MARK: 普通常量
let Axc_true: String     = "true"
let Axc_false: String    = "false"

// MARK: 系统常量
/// 当前系统语言
let Axc_systemLanguage   = NSLocale.preferredLanguages.first!
/// 当前系统版本
let Axc_systemVersion    = UIDevice.current.systemVersion
/// 当前app版本
let Axc_appVersion       = Axc_infoDictionary!["CFBundleShortVersionString"]! as! String
/// 当前项目名称
let Axc_projectName      = Axc_infoDictionary!["CFBundleExecutable"]! as! String

// MARK: 文件路径常量
/// Documents路径
let Axc_documentsPath    =  NSHomeDirectory().appending(AxcSandboxDir.documents.rawValue)
/// Library路径
let Axc_libraryPath      =  NSHomeDirectory().appending(AxcSandboxDir.library.rawValue)
/// Caches路径
let Axc_cachesPath       =  NSHomeDirectory().appending(AxcSandboxDir.Library.caches.rawValue)
/// Preferences路径
let Axc_preferencesPath  =  NSHomeDirectory().appending(AxcSandboxDir.Library.preferences.rawValue)
/// Tmp路径
let Axc_tmpPath          =  NSHomeDirectory().appending(AxcSandboxDir.tmp.rawValue)
