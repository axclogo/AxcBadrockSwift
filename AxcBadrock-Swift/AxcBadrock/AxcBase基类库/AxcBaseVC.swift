//
//  AxcBaseVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

class AxcBaseVC: UIViewController, AxcBaseClassConfigProtocol, AxcBaseClassMakeUIProtocol {
    // MARK: - 初始化
    init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - 父类重写
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        makeUI()
    }
    
    // MARK: 生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - 子类实现方法
    /// 配置 执行于makeUI()之前
    func config() { }
    /// 设置UI布局
    func makeUI() { }
    
    // MARK: - 属性
    // MARK: 参数
    /// 获取 AxcBaseNavController
    var axc_navController: AxcBaseNavController? {
        guard let nav = navigationController as? AxcBaseNavController else { return nil }
        return nav
    }
    
    // MARK: - Api Func
    func axc_setNavBarItem(title: String, direction: AxcDirection = .left) {
        if direction != .left || direction != .right { // 只有左右可选
            AxcLog("[\(direction)] 不是一个可选的NavBarItem的方位！", level: .warning)
            return
        }
        if direction == .left { // 左
            
        }else if direction == .right { // 右
            
        }
    }
    
    /// 推出一个VC
    /// - Parameters:
    ///   - vc: vc
    ///   - animation: 动画
    ///   - completion: 结束后回调
    func axc_pushViewController(_ vc: UIViewController, animation: Bool = true, completion: @escaping AxcEmptyBlock) {
        navigationController?.axc_pushViewController(vc, animation: animation, completion: completion )
    }
    /// 返回本VC
    /// - Parameters:
    ///   - animation: 动画
    ///   - completion: 结束后回调
    func axc_popViewController(animation: Bool = true, completion: @escaping AxcEmptyBlock) {
        navigationController?.axc_popViewController(animated: animation, completion: completion)
    }
}
