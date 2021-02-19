//
//  AxcBaseTabbarController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit


class AxcBaseTabbarController: UITabBarController, AxcBaseClassMakeUIProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
    }
    
    // MARK: - 子类实现方法
    /// 设置UI布局
    func makeUI() { }
    
}
