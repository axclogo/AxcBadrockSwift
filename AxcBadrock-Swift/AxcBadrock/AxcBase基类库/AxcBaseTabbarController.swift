//
//  AxcBaseTabbarController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit


class AxcBaseTabbarController: UITabBarController, AxcBaseClassConfigProtocol, AxcBaseClassMakeUIProtocol {
    // MARK: - 初始化
    init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        tabBar.isTranslucent = false
        makeUI()
    }
    
    // MARK: - 子类实现方法
    /// 配置 执行于makeUI()之前
    func config() { }
    /// 设置UI布局
    func makeUI() { }
    
}
