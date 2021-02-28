//
//  AxcCALayerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 类方法/属性
public extension CALayer {
}

// MARK: - 属性 & Api
public extension CALayer {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 动画的链式语法扩展
// MARK: Runtime绑定
private var kanimations = "kanimations"
extension CALayer {
    /// 通过链式语法maker添加的动画组
    private var animations: [CAAnimation] {
        set { AxcRuntime.setObj(self, &kanimations, newValue) }
        get { // runtime懒加载
            guard let animations = AxcRuntime.getObj(self, &kanimations) as? [CAAnimation] else {
                let _animations: [CAAnimation] = []
                self.animations = _animations   // set
                return _animations
            }
            return animations
        }
    }
}

// MARK: 设置动画相关
public extension CALayer {
    /// 链式语法中继器
    func axc_makeCAAnimation(_ makeBlock: AxcAnimationMakerBlock, complete: AxcEmptyBlock? = nil) {
        removeAllAnimations() // 移除所有动画
        let make = AxcAnimationMaker(self)
        makeBlock( make )
        animations = make.animations    // 获取所有动画集合
        showAnimations(complete)    // 开始执行
    }
    // 开始动画
    private func showAnimations(_ complete: AxcEmptyBlock? = nil) {
        guard let animation = animations.first else {   // 一滴都没了
            complete?() // 动画全部执行完
            return
        }
        axc_addAnimation(animation, key: "") { [weak self] (animation, _) in
            guard let weakSelf = self else { return }
            weakSelf.showAnimations()   // 递归执行下一个动画
        }
        if animations.axc_safeIdx(0) {  // 如果还有元素
            animations.axc_remove(0)    // 移除这个动画
        }
    }
    /// 添加动画并回调完成
    func axc_addAnimation(_ animation: CAAnimation, key: String? = nil, completeBlock: AxcCAAnimationEndBlock? = nil) {
        if let block = completeBlock { animation.didEndBlock(block) }
        add(animation, forKey: key)
    }
}

// MARK: - 边框圆角
public extension CALayer {
    /// 边框颜色
    @IBInspectable var axc_borderColor: UIColor? {
        get { guard let color = borderColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { borderColor = nil; return }
            borderColor = color.cgColor }
    }
    /// 边框宽度
    @IBInspectable var axc_borderWidth: CGFloat {
        get { return borderWidth }
        set { borderWidth = newValue }
    }
    /// 圆角 调用后会自动设置masksToBounds = true
    var axc_cornerRadius: CGFloat {
        get { return cornerRadius }
        set { masksToBounds = true; cornerRadius = newValue.axc_abs }
    }
    /// 阴影颜色
    var axc_shadowColor: UIColor? {
        get { guard let color = shadowColor else { return nil }
            return UIColor(cgColor: color) }
        set { guard let color = newValue else { shadowColor = nil; return }
            shadowColor = color.cgColor }
    }
    /// 阴影透明度
    var axc_shadowOpacity: CGFloat {
        get { return shadowOpacity.axc_cgFloatValue }
        set { shadowOpacity = newValue.axc_floatValue }
    }
    /// 阴影偏移
    var axc_shadowOffset: CGSize {
        get { return shadowOffset }
        set { shadowOffset = newValue }
    }
    /// 阴影圆角
    var axc_shadowRadius: CGFloat {
        get { return shadowRadius }
        set { shadowRadius = newValue }
    }
    /// 遮罩边缘
    var axc_masksToBounds: Bool {
        get { return masksToBounds }
        set { masksToBounds = newValue }
    }
}

// MARK: - 决策判断
public extension CALayer {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 操作符
public extension CALayer {
}

// MARK: - 运算符
public extension CALayer {
}
