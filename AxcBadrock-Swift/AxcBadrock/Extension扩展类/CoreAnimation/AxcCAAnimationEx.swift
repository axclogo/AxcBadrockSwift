//
//  AxcCAAnimationEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 动画链式语法
// MARK: Runtime绑定回调
public typealias AxcCAAnimationStartBlock = (_ animation: CAAnimation ) -> Void
private var kaxc_startBlock = "kaxc_startBlock"
public typealias AxcCAAnimationEndBlock = (_ animation: CAAnimation, _ finish: Bool) -> Void
private var kaxc_endBlock = "kaxc_endBlock"
private var kaxc_didEndBlock = "kaxc_didEndBlock"
public extension CAAnimation {
    /// 动画开始执行的回调
    private var axc_startBlock: AxcCAAnimationStartBlock? {
        set {
            if delegate == nil { delegate = self }
            AxcRuntime.setObj(self, &kaxc_startBlock, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            guard let block = AxcRuntime.getObj(self, &kaxc_startBlock) as? AxcCAAnimationStartBlock else { return nil }
            return block
        }
    }
    /// 设置动画开始执行的回调
    @discardableResult
    func axc_setStartBlock(_ block: AxcCAAnimationStartBlock?) -> Self {
        axc_startBlock = block
        return self
    }
    /// 动画执行完成的回调
    private var axc_endBlock: AxcCAAnimationEndBlock? {
        set {
            if delegate == nil { delegate = self }
            AxcRuntime.setObj(self, &kaxc_endBlock, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            guard let block = AxcRuntime.getObj(self, &kaxc_endBlock) as? AxcCAAnimationEndBlock else { return nil }
            return block
        }
    }
    /// 设置动画开始执行的回调
    @discardableResult
    func axc_setEndBlock(_ block: AxcCAAnimationEndBlock?) -> Self {
        axc_endBlock = block
        return self
    }
    /// 动画已经执行完成的回调
    private var axc_didEndBlock: AxcCAAnimationEndBlock? {
        set {
            if delegate == nil { delegate = self }
            AxcRuntime.setObj(self, &kaxc_didEndBlock, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            guard let block = AxcRuntime.getObj(self, &kaxc_didEndBlock) as? AxcCAAnimationEndBlock else { return nil }
            return block
        }
    }
    /// 动画已经执行完成的回调
    @discardableResult
    func didEndBlock(_ block: AxcCAAnimationEndBlock?) -> Self {
        axc_didEndBlock = block
        return self
    }
}

// MARK: 动画代理
extension CAAnimation: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        axc_startBlock?(anim)
    }
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        axc_endBlock?(anim, flag)
        axc_didEndBlock?(anim, flag)
    }
}

// MARK: 属性附加
public extension CAAnimation {
    /// 设置开始时间
    @discardableResult
    func axc_setBeginTime(_ beginTime: CGFloat) -> Self {
        self.beginTime = beginTime.axc_doubleValue
        return self
    }
    /// 设置持续时间
    @discardableResult
    func axc_setDuration(_ duration: CFTimeInterval? ) -> Self {
        let _duration = duration ?? Axc_duration.axc_doubleValue
        self.duration = _duration
        return self
    }
    /// 设置持续时间
    @discardableResult
    func axc_setDuration(_ duration: CGFloat? ) -> Self {
        let _duration = duration?.axc_doubleValue ?? Axc_duration.axc_doubleValue
        self.duration = _duration
        return self
    }
    /// 设置速度
    @discardableResult
    func axc_setSpeed(_ speed: CGFloat) -> Self {
        self.speed = speed.axc_floatValue
        return self
    }
    /// 设置时间偏移量
    @discardableResult
    func axc_setTimeOffset(_ timeOffset: CGFloat) -> Self {
        self.timeOffset = timeOffset.axc_doubleValue
        return self
    }
    /// 设置重复次数
    @discardableResult
    func axc_setRepeatCount(_ repeatCount: CGFloat) -> Self {
        self.repeatCount = repeatCount.axc_floatValue
        return self
    }
    /// 设置永远重复
    @discardableResult
    func axc_setRepeat() -> Self {
        return axc_setRepeatCount( Axc_floatInfinity )
    }
    /// 设置重复时间
    @discardableResult
    func axc_setRepeatDuration(_ repeatDuration: CGFloat) -> Self {
        self.repeatDuration = repeatDuration.axc_doubleValue
        return self
    }
    /// 设置自动反向播放
    @discardableResult
    func axc_setAutoreverses(_ autoreverses: Bool) -> Self {
        self.autoreverses = autoreverses
        return self
    }
    /// 设置填充模式
    @discardableResult
    func axc_setFillMode(_ fillMode: CAMediaTimingFillMode) -> Self {
        self.fillMode = fillMode
        return self
    }
    /// 设置代理
    @discardableResult
    func axc_setDelegate(_ delegate: CAAnimationDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    /// 设置完成后删除动画
    @discardableResult
    func axc_setRemovedOnCompletion(_ removedOnCompletion: Bool) -> Self {
        self.isRemovedOnCompletion = removedOnCompletion
        return self
    }
    /// 设置时间曲线
    @discardableResult
    func axc_setTimingFunction(timingFunction: CAMediaTimingFunction) -> Self {
        self.timingFunction = timingFunction
        return self
    }
    /// 设置预设时间曲线
    @discardableResult
    func axc_setTimingFunction(_ name: CAMediaTimingFunctionName) -> Self {
        self.timingFunction = CAMediaTimingFunction(name: name)
        return self
    }
    
}
