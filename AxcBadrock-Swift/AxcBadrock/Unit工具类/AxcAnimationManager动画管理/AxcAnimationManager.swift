//
//  AxcAnimationManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit


/// 动画管理器
public class AxcAnimationManager {
    
    //    static func axc_makeAnimation() ->
    
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(0).axc_setToValue(1) }
        else    { animation.axc_setFromValue(1).axc_setToValue(0) }
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(90.0.axc_angleToRadian).axc_setToValue(0) }
        else    { animation.axc_setFromValue(0).axc_setToValue(90.0.axc_angleToRadian) }
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        if isIn { animation.axc_setFromValue(90.0.axc_angleToRadian).axc_setToValue(0) }
        else    { animation.axc_setFromValue(0).axc_setToValue(90.0.axc_angleToRadian) }
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
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
            .axc_setFillMode(.forwards).axc_setRemovedOnCompletion(false)
            .axc_setDuration(duration?.axc_cgFloatValue)
            .axc_setEndBlock(completion)
        return groupAnimation
    }
}
