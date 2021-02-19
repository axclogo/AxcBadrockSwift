//
//  AxcBaseVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

class AxcBaseViewController: UIViewController, AxcBaseClassMakeUIProtocol {
    // MARK: - 父类重载
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    // MARK: - 子类实现方法
    /// 设置UI布局
    func makeUI() { }
    
    // MARK: - 子类可收到通知方法
    /// 导航即将push
    func navigationWillPush(animated: Bool) { }
    /// 导航即将pop
    func navigationWillPop(animated: Bool) { }
    
}
