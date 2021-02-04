//
//  AxcConstFile.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 常用常量
// MARK: UI数据
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
    if #available(iOS 13.0, *) {
        let height = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return height
    } else {
        return UIApplication.shared.statusBarFrame.size.height
    }
}
///底部安全高度
var AxcBottomSafe_Height: CGFloat {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)!
    } else {
        return 0
    }
}

// MARK: 普通常量
let AxcTrue: String = "true"
let AxcFalse: String = "false"


// MARK: 日期相关
public struct AxcTimeStamp {
    /// Era 标志符 -Text -"AD"
    public static var G = "GG"
    /// 年 -Year -"1996 ; 96"
    public static var y = "yyyy"
    /// 年中的月份 -Month "July ; Jul ; 07"
    public static var M = "MM"
    /// 年中的周数 -Number - "27"
    public static var w = "ww"
    /// 月份中的周数 -Number "2"
    public static var W = "WW"
    /// 年中的天数 -Number "189"
    public static var D = "DDDD"
    /// 月份中的天数 -Number "31"
    public static var d = "dd"
    /// 月份中的星期 -Number "2"
    public static var F = "FF"
    /// 星期中的天数 -Text -"Tuesday ; Tue"
    public static var E = "EE"
    /// Am/pm 标记 -Text -"AM ; PM"
    public static var a = "aa"
    /// 一天中的小时数（0-23） -Number "23"
    public static var H = "HH"
    /// am/pm 中的小时数（0-11） -Number "0"
    public static var K = "KK"
    /// 一天中的小时数（1-24） -Number "24"
    public static var k = "kk"
    /// am/pm 中的小时数（1-12）-Number "12"
    public static var h = "hh"
    /// 小时中的分钟数 -Number "30"
    public static var m = "mm"
    /// 毫秒数 -Number "978"
    public static var S = "SSSS"
    /// 分钟中的秒数 -Number "55"
    public static var s = "ss"
    /// 时区 -General time zone - "Pacific Standard Time ; PST ; GMT-08:00"
    public static var Z = "ZZZZ"
    /// 时区 -RFC 822 time zone -"-0800"
    public static var z = "zz"
    
    // 常用的时间戳格式
    private  let separ_1 = "-"
    private  let separ_2 = ":"
    /// "yyyyMMddhhmmss" 格式的时间戳
    public static var yyyyMMddhhmmss: String {
        return AxcTimeStamp.y + AxcTimeStamp.M + AxcTimeStamp.d +
               AxcTimeStamp.h + AxcTimeStamp.m + AxcTimeStamp.s
    }
    /// "yyyy-MM-dd-hh:mm:ss" 格式的时间戳
    public static var yyyyMMddhhmmss_colon: String {
        return AxcTimeStamp.y + AxcTimeStamp.M + AxcTimeStamp.d + AxcTimeStamp.h + AxcTimeStamp.m + AxcTimeStamp.s
    }
}

// MARK: - 系统单例

/// Bundle
let AxcBundle               = Bundle.main
/// FileManager
let AxcFileManager          = FileManager.default
/// UserDefaults
let AxcUserDefaults         = UserDefaults.standard
/// NotificationCenter
let AxcNotificationCenter   = NotificationCenter.default

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

