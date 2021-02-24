//
//  AxcSheetVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

public class AxcSheetVC: AxcBaseVC {
    /// 实例化一个AxcSheetVC
    /// - Parameters:
    ///   - view: 需要弹出的视图
    ///   - size: 视图大小
    ///   - style: 弹出样式
    ///   - showDirection: 显示位置
    ///   - inDirection: 入场方向
    ///   - outDirection: 出场方向
    init(view: UIView, size: CGSize? = nil,
         showDirection: AxcDirection = .bottom) {
        super.init()
        axc_contentView = view
        var contentSize = view.axc_size
        if let _size = size { contentSize = _size }
        axc_showDirection = showDirection
        axc_setContentSize(contentSize)
        config()
    }
    required init?(coder: NSCoder) { super.init()
        config()
    }
    
    // MARK: - 父类重写
    public override var modalPresentationStyle: UIModalPresentationStyle {
        set { super.modalPresentationStyle = newValue }
        get { return .overFullScreen }
    }
    public override func config() {
        transitioningDelegate = self    // 配置代理
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.maskBackgroundColor
        view.addSubview(backControl)
        backControl.axc.makeConstraints { (make) in make.edges.equalTo(0) }
        
        if let contentView = axc_contentView {
            view.addSubview(contentView) // 进行约束
        }
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - 事件触发
    
    // MARK: - Api
    /// 内容视图
    var axc_contentView: UIView?
    /// 显示方向
    var axc_showDirection: AxcDirection = .bottom
    /// 是否添加点击背景dismiss 默认要
    var axc_tapBackgroundDismissEnable = true
    /// present动画时间 默认 0.6
    var axc_presentDuration = Axc_duration * 2
    /// dismiss动画时间 默认 0.6
    var axc_dismissDuration = Axc_duration * 2
    /// 动画弹性系数 默认0.9
    var axc_usingSpringWithDamping: CGFloat = 0.9
    /// 内容的边距
    func axc_setContentSize(_ size: CGSize) {
        if let contentView = axc_contentView {
            view.addSubview(contentView) // 进行约束
            contentView.axc.makeConstraints { (make) in
                make.size.equalTo(size).lowPriority()           // 低优先，默认大小
                make.center.equalToSuperview().lowPriority()    // 低优先，默认居中
                // 使用高优先覆盖约束
                if axc_showDirection.contains(.top)     { make.top.equalToSuperview().heightPriority() }
                if axc_showDirection.contains(.left)    { make.left.equalToSuperview().heightPriority() }
                if axc_showDirection.contains(.bottom)  { make.bottom.equalToSuperview().heightPriority() }
                if axc_showDirection.contains(.right)   { make.right.equalToSuperview().heightPriority() }
            }
        }
    }
    /// 显示出来
    func axc_show() { AxcAppWindow()?.rootViewController?.present(self, animated: true, completion: nil) }
    
    // MARK: - 懒加载
    lazy var alentAnimation: AxcSheetVCAnimation = {
        let animation = AxcSheetVCAnimation()
        return animation
    }()
    private lazy var backControl: AxcBaseControl = {
        let control = AxcBaseControl()
        control.backgroundColor = UIColor.clear
        control.axc_addEvent { [weak self] (_) in
            guard let weakSelf = self else { return }
            if weakSelf.axc_tapBackgroundDismissEnable {    // 需要点击背景返回
                weakSelf.axc_dismissViewController()
            }
        }
        return control
    }()
}

extension AxcSheetVC: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alentAnimation.axc_isPresent = true
        return alentAnimation
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alentAnimation.axc_isPresent = false
        return alentAnimation
    }

}
