//
//  AxcConstFile.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit


// MARK: - 系统单例
/// Bundle
let AxcBundle               = Bundle.main
/// FileManager
let AxcFileManager          = FileManager.default
/// UserDefaults
let AxcUserDefaults         = UserDefaults.standard
/// NotificationCenter
let AxcNotificationCenter   = NotificationCenter.default
/// Application
let AxcApplication          = UIApplication.shared
/// AppDelegate
let AxcAppDelegate          = AxcApplication.delegate
/// Window
var AxcAppWindow            = AxcAppDelegate?.window

// MARK: - 常用常量
// MARK: UI尺寸数据
/// CGFloat支持的最小正数值
let AxcFloat_Min = CGFloat.axc_min
/// CGFloat支持的最大值
let AxcFloat_Max = CGFloat.axc_max

/// 屏大小
let AxcScreen_Size = UIScreen.main.bounds.size
/// 屏宽
let AxcScreen_Width = AxcScreen_Size.width
/// 屏高
let AxcScreen_Height = AxcScreen_Size.height
/// 状态栏高度
var AxcStatus_Height: CGFloat {
    if #available(iOS 13.0, *) { return AxcApplication.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }
    else { return UIApplication.shared.statusBarFrame.size.height }
}
///底部安全高度
var AxcSafeBottom_Height: CGFloat {
    if #available(iOS 11.0, *) { return (AxcAppWindow??.safeAreaInsets.bottom)! }
    else { return 0 }
}
///顶部安全高度
var AxcSafeTop_Height: CGFloat {
    if #available(iOS 11.0, *) { return (AxcAppWindow??.safeAreaInsets.top)! }
    else { return 0 }
}

// MARK: 普通常量
let AxcTrue: String     = "true"
let AxcFalse: String    = "false"

// MARK: 请求返回的格式常量
let kAxcReqData: String = "data"
let kAxcReqcode: String = "code"
let kAxcReqmsg: String  = "msg"

// MARK: 日期常量
/// 常用时间戳格式
public struct AxcTimeStamp {
    // MARK: 年月日
    /// "yyyy-MM-dd"
    public static var ymd_minus                 = "yyyy-MM-dd"
    /// "yyyy/MM/dd"
    public static var ymd_semicolon             = "yyyy/MM/dd"
    /// "yyyy年MM月dd日"
    public static var ymd_cn                    = "yyyy年MM月dd日"
    // MARK: 时分秒
    /// "HH:mm:ss"
    public static var hms_colon                 = "HH:mm:ss"
    /// "HH时mm分ss秒"
    public static var hms_cn                    = "HH时mm分ss秒"
    // MARK: 年月日+时分秒
    /// "yyyy-MM-dd HH:mm:ss"
    public static var ymd_minus_Hms_colon       = "yyyy-MM-dd HH:mm:ss"
    /// "yyyy年MM月dd日 HH时mm分ss秒"
    public static var ymd_hms_cn                = "yyyy年MM月dd日 HH时mm分ss秒"
}

// MARK: - 文件数据
/// 沙盒目录枚举
enum AxcSandboxDir: String {
    /// 保存应用程序的重要数据文件和用户数据文件等。iTunes 同步时会备份该目录。
    case documents      = "/Documents"
    /// Library
    enum Library: String{   /// 二级目录，保存应用程序相关的文件的目录
        case library        = "/Library"
        /// 保存应用程序使用时产生的支持文件和缓存文件，还有日志文件最好也放在这个目录。iTunes 同步时不会备份该目录。
        case caches         = "/Library/Caches"
        /// 保存应用程序的偏好设置文件（使用 NSUserDefaults 类设置时创建，不应该手动创建）。
        case preferences    = "/Library/Preferences"
    }
    /// 保存应用运行时所需要的临时数据，iphone 重启时，会清除该目录下所有文件。
    case tmp            = "/tmp"
}

/// Documents路径
let AxcDocumentsPath    =  NSHomeDirectory().appending(AxcSandboxDir.documents.rawValue)
/// Library路径
let AxcLibraryPath      =  NSHomeDirectory().appending(AxcSandboxDir.Library.library.rawValue)
/// Caches路径
let AxcCachesPath       =  NSHomeDirectory().appending(AxcSandboxDir.Library.caches.rawValue)
/// Preferences路径
let AxcPreferencesPath  =  NSHomeDirectory().appending(AxcSandboxDir.Library.preferences.rawValue)
/// Tmp路径
let AxcTmpPath          =  NSHomeDirectory().appending(AxcSandboxDir.tmp.rawValue)

// MARK: 系统常量
/// 当前系统语言
let AxcSystemLanguage   = NSLocale.preferredLanguages.first!
/// 当前系统版本
let AxcSystemVersion    = UIDevice.current.systemVersion
/// 当前app版本
let AxcAppVersion       = AxcBundle.infoDictionary!["CFBundleShortVersionString"]! as! String

