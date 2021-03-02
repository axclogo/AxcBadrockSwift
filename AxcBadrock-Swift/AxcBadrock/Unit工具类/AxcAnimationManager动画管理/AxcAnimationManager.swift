//
//  AxcAnimationManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit


/// 动画管理器
public class AxcAnimationManager {
    // MARK: - 出入场动画
    // MARK: 渐入渐出
    /// 创建渐入渐出动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_fade(isIn: Bool,
                         _ duration: TimeInterval? = nil,
                         _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.opacity)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
        setInOutAnimation( animation )
        return animation
    }
    
    // MARK: 缩放出入
    /// 创建大小缩放动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_scale(isIn: Bool,
                          _ duration: TimeInterval? = nil,
                          _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.transform_scale)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
        setInOutAnimation( animation )
        return animation
    }
    /// 创建水平缩放动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_scaleHorizontal(isIn: Bool,
                                    _ duration: TimeInterval? = nil,
                                    _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.transform_scale_x)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
        setInOutAnimation( animation )
        return animation
    }
    /// 创建垂直缩放动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_scaleVerticality(isIn: Bool,
                                     _ duration: TimeInterval? = nil,
                                     _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.transform_scale_y)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
        setInOutAnimation( animation )
        return animation
    }
    
    // MARK: 旋转出入
    /// 创建水平旋转出入动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_rotationHorizontal(isIn: Bool,
                                       _ duration: TimeInterval? = nil,
                                       _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.transform_rotation_x)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(90.0.axc_angleToRadian).axc_setToValue(0) }
        else    { animation.axc_setFromValue(0).axc_setToValue(90.0.axc_angleToRadian) }
        setInOutAnimation( animation )
        return animation
    }
    /// 创建垂直旋转出入动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_rotationVerticality(isIn: Bool,
                                        _ duration: TimeInterval? = nil,
                                        _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.transform_rotation_y)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(90.0.axc_angleToRadian).axc_setToValue(0) }
        else    { animation.axc_setFromValue(0).axc_setToValue(90.0.axc_angleToRadian) }
        setInOutAnimation( animation )
        return animation
    }
    
    // MARK: 圆角渐变出入
    /// 创建圆角渐变出入动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - size: 视图大小
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_cornerRadius(isIn: Bool,
                                 size: CGSize,
                                 _ duration: TimeInterval? = nil,
                                 _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let cornerRadiusAnimation = CABasicAnimation(.cornerRadius)
        if isIn { cornerRadiusAnimation.axc_setFromValue(size.axc_smallerValue/2).axc_setToValue(0) }
        else    { cornerRadiusAnimation.axc_setFromValue(0).axc_setToValue(size.axc_smallerValue/2) }
        let groupAnimation = CAAnimationGroup()
            .axc_addAnimation(axc_fade(isIn: isIn, duration))
            .axc_addAnimation(cornerRadiusAnimation)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        setInOutAnimation( groupAnimation )
        return groupAnimation
    }
    
    // MARK: 边框线渐变出入
    /// 边框线渐变出入
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - size: 视图大小
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation   
    static func axc_borderWidth(isIn: Bool,
                                size: CGSize,
                                _ duration: TimeInterval? = nil,
                                _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let borderWidthAnimation = CABasicAnimation(.borderWidth)
        if isIn { borderWidthAnimation.axc_setFromValue(size.axc_smallerValue/2).axc_setToValue(0) }
        else    { borderWidthAnimation.axc_setFromValue(0).axc_setToValue(size.axc_smallerValue/2) }
        let groupAnimation = CAAnimationGroup()
            .axc_addAnimation(axc_fade(isIn: isIn, duration))
            .axc_addAnimation(borderWidthAnimation)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        setInOutAnimation( groupAnimation )
        return groupAnimation
    }
    // MARK: 私有
    /// 设置出入场动画通用参数
    private static func setInOutAnimation(_ animation: CAAnimation) {
        animation
            .axc_setTimingFunction(.easeInEaseOut)  // 动画曲线
            .axc_setFillMode(.forwards)             // 保留最后状态
            .axc_setRemovedOnCompletion(false)      // 完成后移除
    }
    
    
    // MARK: - 提醒动画
    // MARK: 水平垂直抖动
    private static var verticalHorizontalShakeValues = [0,12,-12,9,-9,6,-6,0]
    /// 水平抖动
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_shakeHorizontal(_ duration: TimeInterval? = nil,
                                    _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        return CAKeyframeAnimation(.transform_translation_x).axc_setValues( verticalHorizontalShakeValues )
            .axc_setDuration(duration).axc_setEndBlock(completion)
    }
    /// 垂直抖动
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_shakeVertical(_ duration: TimeInterval? = nil,
                                  _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        return CAKeyframeAnimation(.transform_translation_y).axc_setValues( verticalHorizontalShakeValues )
            .axc_setDuration(duration).axc_setEndBlock(completion)
    }
    
    // MARK: 缩放抖动
    private static var scaleShakeValues = [1, 1.1, 0.9, 1.05, 0.95, 1.08, 0.98, 1]
    private static var narrowScaleShakeValues = [1, 0.9, 1.1, 0.95, 1.05, 0.98, 1.08, 1]
    /// 缩放抖动
    /// - Parameters:
    ///   - isNarrow: 是否先小后大
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_shakeScale(isNarrow: Bool = true,
                               _ duration: TimeInterval? = nil,
                               _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_scale)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isNarrow { animation.axc_setValues( narrowScaleShakeValues ) } // 先缩小
        else        { animation.axc_setValues( scaleShakeValues ) }
        return animation
    }
    /// 水平缩放抖动
    /// - Parameters:
    ///   - isNarrow: 是否先小后大
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_shakeScaleHorizontal(isNarrow: Bool = true,
                                         _ duration: TimeInterval? = nil,
                                         _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_scale_x)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isNarrow { animation.axc_setValues( narrowScaleShakeValues ) } // 先缩小
        else        { animation.axc_setValues( scaleShakeValues ) }
        return animation
    }
    /// 垂直缩放抖动
    /// - Parameters:
    ///   - isNarrow: 是否先小后大
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_shakeScaleVertical(isNarrow: Bool = true,
                                       _ duration: TimeInterval? = nil,
                                       _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_scale_y)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isNarrow { animation.axc_setValues( narrowScaleShakeValues ) } // 先缩小
        else        { animation.axc_setValues( scaleShakeValues ) }
        return animation
    }
    
    #warning("需要更多动画")
    // MARK: 旋转抖动
//    var angle = <#value#>
    
    /// 顺逆时针旋转抖动
    /// - Parameters:
    ///   - isClockwise: 是否顺时针
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    static func axc_shakeRotation(isClockwise: Bool = true,
                                  _ duration: TimeInterval? = nil,
                                  _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_rotation)
            .axc_setDuration(duration).axc_setEndBlock(completion)
//        if isClockwise { animation.axc_setValues( [9.axc_angleToRadian, -9.axc_angleToRadian, 7.axc_angleToRadian, -7.axc_angleToRadian ) } // 顺时针
//        else        { animation.axc_setValues( scaleShakeValues ) }
        return animation
    }
}
