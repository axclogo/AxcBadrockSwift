//
//  AxcBaseNavigationController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

class AxcBaseNavigationController: UINavigationController {
    // MARK: - 父类重载
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let topVC = topViewController
        return topVC!.preferredStatusBarStyle
    }
    
    // MARK: 通知控制器
    // 当push发生时，会通知类为AxcBaseViewController的vc控制器
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let vc = topViewController as? AxcBaseViewController { // 通知相关控制器
            vc.navigationWillPush(animated: animated)
        }
        super.pushViewController(viewController, animated: animated)
    }
    // 当pop发生时，会通知类为AxcBaseViewController的vc控制器
    override func popViewController(animated: Bool) -> UIViewController? {
        if let vc = topViewController as? AxcBaseViewController { // 通知相关控制器
            vc.navigationWillPop(animated: animated)
        }
        return super.popViewController(animated: animated)
    }
}
