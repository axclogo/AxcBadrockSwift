//
//  AxcBaseNavigationController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

@objc
/// 导航条代理回调接口
protocol AxcBaseNavControllerDelegate {
    /// 即将push一个VC
    /// - Parameters:
    ///   - vc: 即将push的vc
    ///   - nav: 导航控制器
    ///   - animation: 是否动画
    @objc optional func navigationWillPushVC(_ vc: UIViewController, nav: AxcBaseNavController, animation: Bool)
    /// 即将pop本VC
    /// - Parameters:
    ///   - nav: 导航控制器
    ///   - animation: 是否动画
    @objc optional func navigationWillPopVC(nav: AxcBaseNavController, animation: Bool)
}

class AxcBaseNavController: UINavigationController {
    // MARK: - 父类重写
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        makeUI()
    }
    // 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topVC = topViewController {
            return topVC.preferredStatusBarStyle
        }else{
            return super.preferredStatusBarStyle
        }
    }
    
    // MARK: - 属性
    var axc_delegate: AxcBaseNavControllerDelegate?
    
    // MARK: - 子类实现
    /// 设置UI布局
    func makeUI() { }

    // MARK: - 通知控制器
    // 当push发生时，会通知类为AxcBaseViewController的vc控制器
    override func pushViewController(_ vc: UIViewController, animated: Bool) {
        if let _delegate = axc_delegate {   // 如果代理实现，则调用
            _delegate.navigationWillPushVC?(vc, nav: self, animation: animated)
        }
        if let tabbar = tabBarController {  // 如果视图由tabbar托管，则默认 非tabbar中的vc隐藏tabbar push
            vc.hidesBottomBarWhenPushed = !tabbar.children.contains(vc)
        }
        super.pushViewController(vc, animated: animated)
    }
    // 当pop发生时，会通知类为AxcBaseViewController的vc控制器
    override func popViewController(animated: Bool) -> UIViewController? {
        if let _delegate = axc_delegate {   // 如果代理实现，则调用
            _delegate.navigationWillPopVC?( nav: self, animation: animated)
        }
        return super.popViewController(animated: animated)
    }
    
}
