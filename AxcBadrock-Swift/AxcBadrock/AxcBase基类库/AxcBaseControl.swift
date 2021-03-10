//
//  AxcBaseControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseControl
/// 基类Control视图
@IBDesignable
public class AxcBaseControl: UIControl,
                             AxcBaseClassConfigProtocol,
                             AxcBaseClassMakeXibProtocol,
                             AxcGradientLayerProtocol {
    // MARK: - 初始化
    public override init(frame: CGRect) { super.init(frame: frame)
        config()
        makeUI()
    }
    public required init?(coder: NSCoder) { super.init(coder: coder)
        config()
        makeUI()
    }
    public override func awakeFromNib() { super.awakeFromNib()
        config()
        makeUI()
    }
    
    // MARK: - Api
    // MARK: UI
    /// 是否开启震动反馈 默认关闭
    var axc_isTouchVibrationFeedback = false

    /// 是否开启点击遮罩反馈 默认关闭
    var axc_isTouchMaskFeedback = false
    
    /// 设置按下时候的颜色，建议设置透明度，默认黑色0.3
    var axc_touchColor: UIColor = UIColor.black.axc_alpha(0.3) { didSet { axc_touchView.backgroundColor = axc_touchColor } }
    
    // MARK: - 子类实现
    /// 配置参数
    public func config() { }
    /// 创建UI
    public func makeUI() { }
    /// 刷新布局
    public func reloadLayout() { }
    /// Xib显示前会执行
    public func makeXmlInterfaceBuilder() { }
    
    // MARK: - 父类重写
    /// 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    /// Xib显示前会执行
    public override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    
    // MARK: 超类&抽象类
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        addTouchFeedback()
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        removeTouchFeedback()
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        removeTouchFeedback()
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        touches.forEach{
            let point = $0.location(in: self)
            axc_touchView.isHidden = !axc_isContains(to: point)
        }
    }
    // MARK: 复用
    private func addTouchFeedback() {
        if axc_isTouchMaskFeedback {    // 开启遮罩反馈
            bringSubviewToFront(axc_touchView) // 前置
            axc_touchView.axc_animateFade(isIn: true, 0.2)
        }
        if axc_isTouchVibrationFeedback { // 震动反馈
            AxcVibrationManager.axc_playVibration(.threeDimensionalTouch_pop)
        }
    }
    private func removeTouchFeedback() {
        if axc_isTouchMaskFeedback {  // 开启遮罩反馈
            if !axc_touchView.isHidden {
                axc_touchView.axc_animateFade(isIn: false, 0.2)
            }
        }
    }
    
    // MARK: - 懒加载
    /// 触发视图
    lazy var axc_touchView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = axc_touchColor
        view.isHidden = true
        addSubview(view)
        view.axc.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }()

    // MARK: - 销毁
    deinit { AxcLog("\(AxcClassFromString(self))视图： \(self) 已销毁", level: .trace) }
}
