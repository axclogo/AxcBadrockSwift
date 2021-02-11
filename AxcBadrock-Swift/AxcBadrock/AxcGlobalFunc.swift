//
//  AxcGlobalFunc.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 颜色
// MARK: RGB颜色
/// RGB颜色
/// - Parameters:
///   - r: 红
///   - g: 绿
///   - b: 蓝
///   - a: 透明度 0-1
/// - Returns: UIColor
func AxcColorRGB(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat, a: CGFloat = 1) -> UIColor {
    return UIColor(r,g,b,a: a)
}

// MARK: Hex颜色
/// 十六进制颜色
/// - Parameters:
///   - hex: 十六进制
///   - a: 透明度 0-1
/// - Returns: UIColor
func AxcColorHex(_ hex: String, a: CGFloat = 1) -> UIColor? {
    return UIColor(hexStr: hex, alpha: a)
}

// MARK: - 类名转Class
/// 类名转Class
func AxcClassFromString(_ className: String) -> AnyClass! {
    return NSClassFromString(Axc_projectName + "." + className)
}

// MARK: - 全局枚举
// MARK: 文件数据枚举
/// 沙盒目录枚举
enum AxcSandboxDir: String {
    /// 保存应用程序的重要数据文件和用户数据文件等。iTunes 同步时会备份该目录。
    case documents      = "/Documents"
    /// Library
    case library        = "/Library"
    /// 二级目录，保存应用程序相关的文件的目录
    enum Library: String{
        /// 保存应用程序使用时产生的支持文件和缓存文件，还有日志文件最好也放在这个目录。iTunes 同步时不会备份该目录。
        case caches         = "/Library/Caches"
        /// 保存应用程序的偏好设置文件（使用 NSUserDefaults 类设置时创建，不应该手动创建）。
        case preferences    = "/Library/Preferences"
    }
    /// 保存应用运行时所需要的临时数据，iphone 重启时，会清除该目录下所有文件。
    case tmp            = "/tmp"
}


// MARK: - 全局结构体
// MARK: 方向结构体
/// 方向结构体
public enum AxcDirection: Int {
    case top       = 1
    case left      = 2
    case bottom    = 4
    case right     = 8
    case center    = 16
}

// MARK: 极坐标结构体
/// 创建极坐标结构体
public struct AxcPolarAxis {
    /// 获取一个角度为  0 ～ 180 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - angle: 角度  0 ～ 180
    ///   - direction: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    public static func transform(center: CGPoint, distance: Float, angle: Float, direction: AxcDirection = .top) -> CGPoint{
        return CGPoint(center: center, distance: distance, angle: angle, direction: direction)
    }
    
    /// 获取一个角度为  0 ～ 2pi 的极轴坐标
    /// - Parameters:
    ///   - center: 中心
    ///   - distance: 距离
    ///   - radian: 弧度 0 ～ 2pi
    ///   - direction: 起始方位，上下左右 默认顶部为起始方位
    /// - Returns: CGPoint
    public static func transform(center: CGPoint, distance: Float, radian: Float, direction: AxcDirection = .top) -> CGPoint{
        return CGPoint(center: center, distance: distance, radian: radian, direction: direction)
    }
}

// MARK: GCD结构体
/// GCD结构体
public struct AxcGCD {
    
    /// 主线程任务Block调用
    /// - Parameter task: 主线程任务
    public static func main(_ task: @escaping () -> Void) {
        DispatchQueue.main.sync { task() }
    }
    
    /// 异步任务Block调用
    /// - Parameters:
    ///   - task: 异步任务
    ///   - mainTask: 回调主线任务
    public static func async(_ task: @escaping () -> Void, _ mainTask: (() -> Void)? = nil) {
        DispatchQueue.axc_async(task, mainTask)
    }
    
    /// 延时任务Block调用
    /// - Parameters:
    ///   - delay: 延时时间
    ///   - task: 延时任务
    ///   - mainTask: 回调主线任务
    /// - Returns: 工作元素
    @discardableResult
    public static func delay(_ delay: Double, _ task: @escaping () -> Void, _ mainTask: (() -> Void)? = nil) -> DispatchWorkItem {
        return DispatchQueue.axc_delay(delay, task, mainTask)
    }
    
    /// 单次执行Block，已加锁防止多线程
    /// - Parameters:
    ///   - identifier: 该单次执行的唯一标识符
    ///   - task: 任务Block
    public static func once(_ identifier: String, task: () -> Void){
        DispatchQueue.axc_once(identifier: identifier, block: task)
    }
}


