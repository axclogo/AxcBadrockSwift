//
//  AxcAnimationManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

// MARK: - 动画部分Key
public extension AxcAnimationManager.Key {
    // MARK: Transform 转换
    /// 比例转换
    static var transform_scale          = AxcAnimationManager.Key("transform.scale")
    /// 比例转换 X
    static var transform_scale_x        = AxcAnimationManager.Key("transform.scale.x")
    /// 比例转换 Y
    static var transform_scale_y        = AxcAnimationManager.Key("transform.scale.y")
    /// 旋转
    static var transform_rotation       = AxcAnimationManager.Key("transform.rotation")
    /// 旋转x
    static var transform_rotation_x     = AxcAnimationManager.Key("transform.rotation.x")
    /// 旋转y
    static var transform_rotation_y     = AxcAnimationManager.Key("transform.rotation.y")
    /// 旋转z
    static var transform_rotation_z     = AxcAnimationManager.Key("transform.rotation.z")
    /// 位移x
    static var transform_translation_x  = AxcAnimationManager.Key("transform.translation.x")
    /// 位移y
    static var transform_translation_y  = AxcAnimationManager.Key("transform.translation.y")
    
    // MARK: ContentsRect 框
    /// 内容
    static var contents                 = AxcAnimationManager.Key("contents")
    /// 内容Rect
    static var contentsRect             = AxcAnimationManager.Key("contentsRect")
    /// 内容width
    static var contentsRect_size_width  = AxcAnimationManager.Key("contentsRect.size.width")
    /// 内容height
    static var contentsRect_size_Height = AxcAnimationManager.Key("contentsRect.size.height")
    
    // MARK: Stroke 线
    /// 绘制进度0-1
    static var strokeEnd    = AxcAnimationManager.Key("strokeEnd")
    /// 绘制进度1-0
    static var strokeStart  = AxcAnimationManager.Key("strokeStart")
    
    // MARK: Layer 图层
    /// 透明度
    static var opacity          = AxcAnimationManager.Key("opacity")
    /// 背景色
    static var backgroundColor  = AxcAnimationManager.Key("backgroundColor")
    /// 圆角
    static var cornerRadius     = AxcAnimationManager.Key("cornerRadius")
    /// 边框宽度
    static var borderWidth      = AxcAnimationManager.Key("borderWidth")
    /// 内容隐藏
    static var hidden           = AxcAnimationManager.Key("hidden")
    /// 布局
    static var margin           = AxcAnimationManager.Key("margin")
    /// 大小
    static var bounds           = AxcAnimationManager.Key("bounds")
    /// 大小位置
    static var frame            = AxcAnimationManager.Key("frame")
    /// 高度
    static var zPosition        = AxcAnimationManager.Key("zPosition")
    /// 遮罩
    static var mask             = AxcAnimationManager.Key("mask")
    /// 切割
    static var masksToBounds    = AxcAnimationManager.Key("masksToBounds")
    /// 位置
    static var position         = AxcAnimationManager.Key("position")
    
    // MARK: Shadow 阴影
    /// 阴影颜色
    static var shadowColor      = AxcAnimationManager.Key("shadowColor")
    /// 阴影偏移
    static var shadowOffset     = AxcAnimationManager.Key("shadowOffset")
    /// 阴影透明
    static var shadowOpacity    = AxcAnimationManager.Key("shadowOpacity")
    /// 阴影圆角
    static var shadowRadius     = AxcAnimationManager.Key("shadowRadius")

}

/// 动画管理器
public class AxcAnimationManager {
    /// 动画变化键值Key
    public struct Key: Hashable, Equatable, RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) { self.rawValue = rawValue }
        internal init(_ rawValue: String) { self.init(rawValue: rawValue) }
    }
    
    
}
