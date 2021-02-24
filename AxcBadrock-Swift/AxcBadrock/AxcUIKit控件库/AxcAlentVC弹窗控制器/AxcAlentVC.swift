//
//  AxcAlentVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

public extension AxcAlentVC {
    enum Style {
        case sheet
        case alent
    }
    #warning("未完成，需要更多动画")
    enum AnimationStyle {
        case pullUp     // 下方拉起
        case dropDown   // 上方掉下
        case pullLeft   // 从左拉入
        case pullRight  // 从右
        case fade       // 渐入渐出
    }
}

public class AxcAlentVC: AxcBaseVC {
    // MARK: - 初始化
    /// 实例化一个AxcAlentVC
    /// - Parameters:
    ///   - view: 需要弹出的视图
    ///   - style: 弹出样式
    ///   - animationStyle: 弹出动画
    init(view: UIView, style: AxcAlentVC.Style = .sheet, animationStyle: AxcAlentVC.AnimationStyle = .pullUp) { super.init()
        axc_contentView = view
        axc_preferredStyle = style
        axc_animationStyle = animationStyle
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
            let _axc_contentEdge = axc_contentEdge
            axc_contentEdge = _axc_contentEdge
        }
    }

    // MARK: - 事件触发
    
    // MARK: - Api
    /// 内容视图
    var axc_contentView: UIView?
    /// 样式
    var axc_preferredStyle: AxcAlentVC.Style = .sheet
    /// 动画样式
    var axc_animationStyle: AxcAlentVC.AnimationStyle = .pullUp
    /// 是否添加点击背景dismiss 默认要
    var axc_tapBackgroundDismissEnable = true
    /// present动画时间 默认 0.6
    var axc_presentDuration = Axc_duration * 2
    /// dismiss动画时间 默认 0.6
    var axc_dismissDuration = Axc_duration * 2
    /// 动画弹性系数 默认0.9
    var axc_usingSpringWithDamping: CGFloat = 0.9
    /// 内容的边距
    var axc_contentEdge: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {    // 进行约束
            if let contentView = axc_contentView {
                switch axc_preferredStyle {
                case .alent:    // 中间边距
                    contentView.axc.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(axc_contentEdge.left)
                        make.right.equalToSuperview().offset(-axc_contentEdge.right)
                        make.height.equalTo(contentView.axc_height)
                        make.centerX.equalToSuperview()
                    }
                case .sheet:    // 下方约束
                    contentView.axc.makeConstraints { (make) in
                        make.left.equalToSuperview().offset(axc_contentEdge.left)
                        make.right.equalToSuperview().offset(-axc_contentEdge.right)
                        make.bottom.equalToSuperview().offset(-axc_contentEdge.bottom)
                        make.height.equalTo(contentView.axc_height)
                    }
                }
            }
        }
    }
    
    
    /// 显示出来
    func axc_show() {
        AxcAppWindow()?.rootViewController?.present(self, animated: true, completion: nil)
    }
    
    
    // MARK: - 私有
    
    // MARK: - 懒加载
    lazy var alentAnimation: AxcAlentAnimation = {
        let animation = AxcAlentAnimation()
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

extension AxcAlentVC: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alentAnimation.axc_isPresent = true
        return alentAnimation
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alentAnimation.axc_isPresent = false
        return alentAnimation
    }

}
