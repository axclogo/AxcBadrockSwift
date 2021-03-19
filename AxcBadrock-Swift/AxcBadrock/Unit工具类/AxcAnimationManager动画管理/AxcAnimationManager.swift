//
//  AxcAnimationManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

public extension AxcAnimationManager {
    typealias AxcCustomAnimationBlock = () -> CAAnimation
    /// 动画样式
    enum Style {
        // MARK: 出入场
        /// 出入场-渐入渐出
        case inout_fade(isIn: Bool,
                        _ duration: TimeInterval? = nil,
                        _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-缩放
        case inoutScale(isIn: Bool,
                        _ duration: TimeInterval? = nil,
                        _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-水平缩放
        case inoutScaleHorizontal(isIn: Bool,
                                  _ duration: TimeInterval? = nil,
                                  _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-垂直缩放
        case inoutScaleVerticality(isIn: Bool,
                                   _ duration: TimeInterval? = nil,
                                   _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-水平旋转
        case inoutRotationHorizontal(isIn: Bool,
                                     _ duration: TimeInterval? = nil,
                                     _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-垂直旋转
        case inoutRotationVerticality(isIn: Bool,
                                      _ duration: TimeInterval? = nil,
                                      _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-圆角渐变
        case inoutCornerRadius(isIn: Bool,
                               size: CGSize,
                               _ duration: TimeInterval? = nil,
                               _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-边框渐变
        case inoutBorderWidth(isIn: Bool,
                              size: CGSize,
                              _ duration: TimeInterval? = nil,
                              _ completion: AxcCAAnimationEndBlock? = nil)
        /// 出入场-场外移动
        case inoutMove(isIn: Bool,
                       size: CGSize,
                       superFrame: CGRect,
                       direction: AxcDirection,
                       _ useSpring: Bool = true,
                       _ duration: TimeInterval? = nil,
                       _ completion: AxcCAAnimationEndBlock? = nil)
        
        // MARK: 提示 - [ 抖动 ]
        /// 提示-水平晃动
        case shakeHorizontal(_ duration: TimeInterval? = nil,
                             _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-垂直晃动
        case shakeVertical(_ duration: TimeInterval? = nil,
                           _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-移动抖动
        case shakeMove(direction: AxcDirection = .top,
                       _ duration: TimeInterval? = nil,
                       _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-缩放抖动
        case shakeScale(isNarrow: Bool = true,
                        _ duration: TimeInterval? = nil,
                        _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-水平缩放抖动
        case shakeScaleHorizontal(isNarrow: Bool = true,
                                  _ duration: TimeInterval? = nil,
                                  _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-垂直缩放抖动
        case shakeScaleVertical(isNarrow: Bool = true,
                                _ duration: TimeInterval? = nil,
                                _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-旋转抖动
        case shakeRotation(isClockwise: Bool = true,
                           _ duration: TimeInterval? = nil,
                           _ completion: AxcCAAnimationEndBlock? = nil)
        
        // MARK: 提示 - [ 重点 ]
        /// 提示-闪烁
        case remindFlashing(flashingCount: Int = 3,
                            _ duration: TimeInterval? = nil,
                            _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-边框勾勒
        case remindBorderWidth(remindCount: Int = 3,
                               _ duration: TimeInterval? = nil,
                               _ completion: AxcCAAnimationEndBlock? = nil)
        /// 提示-边框颜色
        case remindBorderColor(remindCount: Int = 3,
                               fromColor: UIColor,
                               toColor: UIColor,
                               _ duration: TimeInterval? = nil,
                               _ completion: AxcCAAnimationEndBlock? = nil)
        /// 自定义动画
        case custom(animationBlock: AxcCustomAnimationBlock)
    }
}

/// 动画管理器
open class AxcAnimationManager {
    // MARK: - 枚举动画
    /// 生成一种样式的动画
    /// - Parameters:
    ///   - style: 动画样式
    /// - Returns: 动画对象
    public static func axc_animationStyle(style: AxcAnimationManager.Style) -> CAAnimation {
        var animation = CAAnimation()
        switch style {  // 枚举动画
        case .inout_fade(isIn: let isIn, let duration, let completion): 
            animation = axc_inoutFade(isIn: isIn, duration, completion)
        case .inoutScale(isIn: let isIn, let duration, let completion):
            animation = axc_inoutScale(isIn: isIn, duration, completion)
        case .inoutScaleHorizontal(isIn: let isIn, let duration, let completion):
            animation = axc_inoutScaleHorizontal(isIn: isIn, duration, completion)
        case .inoutScaleVerticality(isIn: let isIn, let duration, let completion):
            animation = axc_inoutScaleVerticality(isIn: isIn, duration, completion)
        case .inoutRotationHorizontal(isIn: let isIn, let duration, let completion):
            animation = axc_inoutRotationHorizontal(isIn: isIn, duration, completion)
        case .inoutRotationVerticality(isIn: let isIn, let duration, let completion):
            animation = axc_inoutRotationVerticality(isIn: isIn, duration, completion)
        case .inoutCornerRadius(isIn: let isIn, size: let size, let duration, let completion):
            animation = axc_inoutCornerRadius(isIn: isIn, size: size, duration, completion)
        case .inoutBorderWidth(isIn: let isIn, size: let size, let duration, let completion):
            animation = axc_inoutBorderWidth(isIn: isIn, size: size, duration, completion)
        case .inoutMove(isIn: let isIn, size: let size, superFrame: let superFrame, direction: let direction, let useSpring, let duration, let completion):
            animation = axc_inoutMove(isIn: isIn, size: size, superFrame: superFrame, direction: direction, useSpring, duration, completion)
        case .shakeHorizontal(let duration, let completion):
            animation = axc_shakeHorizontal(duration, completion)
        case .shakeVertical(let duration, let completion):
            animation = axc_shakeVertical(duration, completion)
        case .shakeMove(direction: let direction, let duration, let completion):
            animation = axc_shakeMove(direction: direction, duration, completion)
        case .shakeScale(isNarrow: let isNarrow, let duration, let completion):
            animation = axc_shakeScale(isNarrow: isNarrow, duration, completion)
        case .shakeScaleHorizontal(isNarrow: let isNarrow, let duration, let completion):
            animation = axc_shakeScaleHorizontal(isNarrow: isNarrow, duration, completion)
        case .shakeScaleVertical(isNarrow: let isNarrow, let duration, let completion):
            animation = axc_shakeScaleVertical(isNarrow: isNarrow, duration, completion)
        case .shakeRotation(isClockwise: let isClockwise, let duration, let completion):
            animation = axc_shakeRotation(isClockwise: isClockwise, duration, completion)
        case .remindFlashing(flashingCount: let flashingCount, let duration, let completion):
            animation = axc_remindFlashing(flashingCount: flashingCount, duration, completion)
        case .remindBorderWidth(remindCount: let remindCount, let duration, let completion):
            animation = axc_remindBorderWidth(remindCount: remindCount, duration, completion)
        case .remindBorderColor(remindCount: let remindCount, fromColor: let fromColor, toColor: let toColor, let duration, let completion):
            animation = axc_remindBorderColor(remindCount: remindCount, fromColor: fromColor, toColor: toColor, duration, completion)
        case .custom(animationBlock: let block ):
            animation = block()
        }
        return animation
    }
    
    // MARK: - 出入场动画
    // MARK: 渐入渐出
    /// 创建渐入渐出动画效果
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_inoutFade(isIn: Bool,
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
    public static func axc_inoutScale(isIn: Bool,
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
    public static func axc_inoutScaleHorizontal(isIn: Bool,
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
    public static func axc_inoutScaleVerticality(isIn: Bool,
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
    public static func axc_inoutRotationHorizontal(isIn: Bool,
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
    public static func axc_inoutRotationVerticality(isIn: Bool,
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
    public static func axc_inoutCornerRadius(isIn: Bool,
                                             size: CGSize,
                                             _ duration: TimeInterval? = nil,
                                             _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let cornerRadiusAnimation = CABasicAnimation(.cornerRadius)
        if isIn { cornerRadiusAnimation.axc_setFromValue(size.axc_smallerValue/2).axc_setToValue(0) }
        else    { cornerRadiusAnimation.axc_setFromValue(0).axc_setToValue(size.axc_smallerValue/2) }
        let groupAnimation = CAAnimationGroup()
            .axc_addAnimation(axc_inoutFade(isIn: isIn, duration))
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
    public static func axc_inoutBorderWidth(isIn: Bool,
                                            size: CGSize,
                                            _ duration: TimeInterval? = nil,
                                            _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let borderWidthAnimation = CABasicAnimation(.borderWidth)
        if isIn { borderWidthAnimation.axc_setFromValue(size.axc_smallerValue/2).axc_setToValue(0) }
        else    { borderWidthAnimation.axc_setFromValue(0).axc_setToValue(size.axc_smallerValue/2) }
        let groupAnimation = CAAnimationGroup()
            .axc_addAnimation(axc_inoutFade(isIn: isIn, duration))
            .axc_addAnimation(borderWidthAnimation)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        setInOutAnimation( groupAnimation )
        return groupAnimation
    }
    
    // MARK: 移动出入
    /// 移动出入
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - size: 视图大小
    ///   - superFrame: 入场动画框
    ///   - direction: 入场方位
    ///   - useSpring: 使用弹性动画 默认 true
    ///   - duration: 持续时间 当使用弹性动画时，不传持续时间则使用自动估算时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_inoutMove(isIn: Bool,
                                     size: CGSize,
                                     superFrame: CGRect,
                                     direction: AxcDirection,
                                     _ useSpring: Bool = true,
                                     _ duration: TimeInterval? = nil,
                                     _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let tuples = getMoveAnimationKeyAndValue(size: size, superFrame: superFrame, direction: direction)
        let key = tuples.0
        let fromValue = tuples.1
        let moveAnimation = useSpring ? CASpringAnimation(key) : CABasicAnimation(key)
        moveAnimation.axc_setDuration(duration).axc_setEndBlock(completion)
        if let springAnimation = moveAnimation as? CASpringAnimation {
            if duration == nil { springAnimation.axc_setAutoDuration() }  // 弹性自动适配时间
        }
        if isIn { moveAnimation.axc_setFromValue(fromValue).axc_setToValue(0) }
        else { moveAnimation.axc_setFromValue(0).axc_setToValue(fromValue) }
        setInOutAnimation( moveAnimation )
        return moveAnimation
    }
    
    // MARK: 私有
    /// 获取移动动画相关参数
    private static func getMoveAnimationKeyAndValue(size: CGSize,
                                                    superFrame: CGRect,
                                                    direction: AxcDirection) -> (AxcAnimationMaker.Key?, CGFloat) {
        var key: AxcAnimationMaker.Key?
        var fromValue: CGFloat = 0;
        switch direction {
        case .top:
            key = .transform_translation_y
            fromValue = -size.height
        case .left:
            key = .transform_translation_x
            fromValue = -size.width
        case .bottom:
            key = .transform_translation_y
            fromValue = superFrame.axc_height
        case .right:
            key = .transform_translation_x
            fromValue = superFrame.axc_width
        default: break
        }
        return (key, fromValue)
    }
    
    
    /// 设置出入场动画通用参数
    private static func setInOutAnimation(_ animation: CAAnimation) {
        animation
            .axc_setTimingFunction(.easeInEaseOut)  // 动画曲线
            .axc_setFillMode(.forwards)             // 保留最后状态
            .axc_setRemovedOnCompletion(false)      // 完成后不移除
    }
    
    // MARK: - 提示动画 - [ 抖动 ]
    // MARK: 水平垂直抖动
    private static var moveShakeValues = [0,12,-12,9,-9,6,-6,0]
    /// 水平抖动
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_shakeHorizontal(_ duration: TimeInterval? = nil,
                                           _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_translation_x).axc_setValues( moveShakeValues )
            .axc_setDuration(duration).axc_setEndBlock(completion)
        setRemindAnimation(animation)
        return animation
    }
    /// 垂直抖动
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_shakeVertical(_ duration: TimeInterval? = nil,
                                         _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_translation_y).axc_setValues( moveShakeValues )
            .axc_setDuration(duration).axc_setEndBlock(completion)
        setRemindAnimation(animation)
        return animation
    }
    
    // MARK: 移动抖动
    /// 移动抖动
    /// - Parameters:
    ///   - direction: 移动方位 支持上下左右位运算多选
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_shakeMove(direction: AxcDirection = .top,
                                     _ duration: TimeInterval? = nil,
                                     _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let moveNegativeShakeValues = moveShakeValues.map { (int) -> Int in return -int }
        let groupAnimation = CAAnimationGroup().axc_setDuration(duration).axc_setEndBlock(completion)
        if direction.contains(.top) {
            groupAnimation.axc_addAnimation(CAKeyframeAnimation(.transform_translation_y).axc_setValues(moveNegativeShakeValues))
        }
        if direction.contains(.left) {
            groupAnimation.axc_addAnimation(CAKeyframeAnimation(.transform_translation_x).axc_setValues(moveNegativeShakeValues))
        }
        if direction.contains(.bottom) {
            groupAnimation.axc_addAnimation(CAKeyframeAnimation(.transform_translation_y).axc_setValues(moveShakeValues))
        }
        if direction.contains(.right) {
            groupAnimation.axc_addAnimation(CAKeyframeAnimation(.transform_translation_x).axc_setValues(moveShakeValues))
        }
        setRemindAnimation(groupAnimation)
        return groupAnimation
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
    public static func axc_shakeScale(isNarrow: Bool = true,
                                      _ duration: TimeInterval? = nil,
                                      _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_scale)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isNarrow { animation.axc_setValues( narrowScaleShakeValues ) } // 先缩小
        else        { animation.axc_setValues( scaleShakeValues ) }
        setRemindAnimation(animation)
        return animation
    }
    /// 水平缩放抖动
    /// - Parameters:
    ///   - isNarrow: 是否先小后大
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_shakeScaleHorizontal(isNarrow: Bool = true,
                                                _ duration: TimeInterval? = nil,
                                                _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_scale_x)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isNarrow { animation.axc_setValues( narrowScaleShakeValues ) } // 先缩小
        else        { animation.axc_setValues( scaleShakeValues ) }
        setRemindAnimation(animation)
        return animation
    }
    /// 垂直缩放抖动
    /// - Parameters:
    ///   - isNarrow: 是否先小后大
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_shakeScaleVertical(isNarrow: Bool = true,
                                              _ duration: TimeInterval? = nil,
                                              _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation{
        let animation = CAKeyframeAnimation(.transform_scale_y)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isNarrow { animation.axc_setValues( narrowScaleShakeValues ) } // 先缩小
        else        { animation.axc_setValues( scaleShakeValues ) }
        setRemindAnimation(animation)
        return animation
    }
    
    // MARK: 旋转抖动
    /// 顺逆时针旋转抖动
    /// - Parameters:
    ///   - isClockwise: 是否顺时针
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_shakeRotation(isClockwise: Bool = true,
                                         _ duration: TimeInterval? = nil,
                                         _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        var shakeRotationAngle: [Float] = []
        for float in [9.0,7.0,6.0,2.0,0.0] {
            shakeRotationAngle.append(Float(float.axc_angleToRadian))
            shakeRotationAngle.append(Float(-float.axc_angleToRadian))
        }
        let animation = CAKeyframeAnimation(.transform_rotation)
            .axc_setDuration(duration).axc_setEndBlock(completion)
        if isClockwise { animation.axc_setValues( shakeRotationAngle ) } // 顺时针
        else        { animation.axc_setValues( scaleShakeValues ) }
        setRemindAnimation(animation)
        return animation
    }
    
    // MARK: - 提示动画 - [ 重点 ]
    // MARK: 闪烁提醒
    /// 闪烁提醒动画
    /// - Parameters:
    ///   - flashingCount: 闪烁次数
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_remindFlashing(flashingCount: Int = 3,
                                          _ duration: TimeInterval? = nil,
                                          _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let _duration = duration?.axc_floatValue ?? Axc_duration.axc_floatValue
        let animation = CABasicAnimation(.opacity).axc_setRepeatCount(flashingCount)
            .axc_setDuration( _duration / flashingCount.axc_floatValue ).axc_setEndBlock(completion)
            .axc_setFromValue(1).axc_setToValue(0.7).axc_setAutoreverses(true)  // 设置倒叙播放
        setRemindAnimation(animation)
        return animation
    }
    
    // MARK: 边框提醒
    /// 边框宽度提醒动画
    /// - Parameters:
    ///   - remindCount: 提醒次数
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_remindBorderWidth(remindCount: Int = 3,
                                             _ duration: TimeInterval? = nil,
                                             _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let _duration = duration?.axc_floatValue ?? Axc_duration.axc_floatValue
        let animation = CABasicAnimation(.borderWidth).axc_setRepeatCount(remindCount)
            .axc_setDuration( _duration / remindCount.axc_floatValue ).axc_setEndBlock(completion)
            .axc_setFromValue(0).axc_setToValue(2).axc_setAutoreverses(true)  // 设置倒叙播放
        setRemindAnimation(animation)
        return animation
    }
    /// 边框提醒动画
    /// - Parameters:
    ///   - remindCount: 提醒次数
    ///   - fromColor: 从。。颜色
    ///   - toColor: 到。。颜色
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    public static func axc_remindBorderColor(remindCount: Int = 3,
                                             fromColor: UIColor,
                                             toColor: UIColor,
                                             _ duration: TimeInterval? = nil,
                                             _ completion: AxcCAAnimationEndBlock? = nil) -> CAAnimation {
        let _duration = duration?.axc_floatValue ?? Axc_duration.axc_floatValue
        let animation = CABasicAnimation(.borderColor).axc_setRepeatCount(remindCount)
            .axc_setDuration( _duration / remindCount.axc_floatValue ).axc_setEndBlock(completion)
            .axc_setFromValue(fromColor.cgColor).axc_setToValue(toColor.cgColor)
            .axc_setAutoreverses(true)  // 设置倒叙播放
        setRemindAnimation(animation)
        return animation
    }
    
    // MARK: 私有
    /// 设置提醒动画通用参数
    private static func setRemindAnimation(_ animation: CAAnimation) {
        animation.axc_setTimingFunction(.easeInEaseOut)  // 动画曲线
    }
}
