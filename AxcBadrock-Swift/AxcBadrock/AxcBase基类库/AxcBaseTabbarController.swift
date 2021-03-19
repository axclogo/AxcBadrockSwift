//
//  AxcBaseTabbarController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseTabbarController
/// 基类TabbarController
@IBDesignable
public class AxcBaseTabbarController: UITabBarController,
                                      AxcBaseClassConfigProtocol,
                                      AxcBaseClassMakeUIProtocol {
    // MARK: - 初始化
    public init() { super.init(nibName: nil, bundle: nil)
        config()
    }
    required convenience init?(coder: NSCoder) { self.init() }
    
    // MARK: - 子类实现
    /// 配置 执行于makeUI()之前
    public func config() { }
    /// 设置UI布局
    public func makeUI() { }
    
    // MARK: - 父类重写
    /// 视图加载完成
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        tabBar.isTranslucent = false
        makeUI()
    }
    
    // MARK: - 销毁
    deinit { AxcLog("\(AxcClassFromString(self))选项卡： \(self) 已销毁", level: .trace) }
}
