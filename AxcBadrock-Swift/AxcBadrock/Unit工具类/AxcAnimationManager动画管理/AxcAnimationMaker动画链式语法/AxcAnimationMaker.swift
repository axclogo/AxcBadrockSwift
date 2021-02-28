//
//  AxcAnimationMaker.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

public typealias AxcAnimationMakerBlock = (_ make: AxcAnimationMaker) -> Void

public class AxcAnimationMaker: NSObject {
    public convenience init(_ layer: CALayer) {
        self.init()
        self.layer = layer
    }
    public override init() { super.init() }
    
    // MARK: - Api
    /// 执行动画的layer
    var layer: CALayer? = nil
    /// 所有动画
    var animations: [CAAnimation] = []
    /// 所有组动画
    var animationGroups: [CAAnimation] = []
    
    // MARK: CABasicAnimation 基础动画
    /// 基础动画
    var basicAnimation: CABasicAnimation {
        return basicAnimation()
    }
    /// 基础动画
    func basicAnimation(_ key: AxcAnimationManager.Key? = nil) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(key)
        addAnimation(basicAnimation)
        return basicAnimation
    }
    // MARK: CAKeyframeAnimation 关键帧动画
    /// 关键帧动画
    var keyframeAnimation: CAKeyframeAnimation {
        return keyframeAnimation()
    }
    /// 关键帧动画
    func keyframeAnimation(_ key: AxcAnimationManager.Key? = nil) -> CAKeyframeAnimation {
        let keyframeAnimation = CAKeyframeAnimation(key)
        addAnimation(keyframeAnimation)
        return keyframeAnimation
    }
    // MARK: CASpringAnimation 弹性动画
    /// 弹性动画
    var springAnimation: CASpringAnimation {
        return springAnimation()
    }
    /// 弹性动画
    func springAnimation(_ key: AxcAnimationManager.Key? = nil) -> CASpringAnimation {
        let springAnimation = CASpringAnimation(key)
        addAnimation(springAnimation)
        return springAnimation
    }
    // MARK: CAAnimationGroup 组动画
    /// 组动画
    var groupAnimation: CAAnimationGroup {
        let basicAnimation = CAAnimationGroup()
        addAnimation(basicAnimation)
        return basicAnimation
    }
    
    /// 添加一个动画
    /// - Parameter animation: 动画
    /// - Returns: 添加的动画
    @discardableResult
    func addAnimation(_ animation: CAAnimation) -> CAAnimation {
        animations.append(animation)
        return animation
    }
}
