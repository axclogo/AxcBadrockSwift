//
//  AxcBaseVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

public class AxcBaseVC: UIViewController, AxcBaseClassConfigProtocol, AxcBaseClassMakeUIProtocol, UICollectionViewDelegateFlowLayout {
    // MARK: - 初始化
    init(useNavBar: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        // 初始化相关参数
        axc_useNavBar = useNavBar
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - 父类重写
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        if #available(iOS 11, *) { } else { // 低于11版本
            automaticallyAdjustsScrollViewInsets = false
        }
        makeUI()
    }
    
    // MARK: 生命周期
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!axc_useNavBar, animated: true)
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - 子类实现方法
    /// 设置UI布局
    public func makeUI() { }
    
    // MARK: - 属性
    // MARK: 预设参数
    /// 是否使用导航条 默认使用
    var axc_useNavBar: Bool = true {
        didSet {
            navigationController?.setNavigationBarHidden(!axc_useNavBar, animated: true)
        }
    }
    
    /// 获取 AxcBaseNavController
    var axc_navController: AxcBaseNavController? {
        guard let nav = navigationController as? AxcBaseNavController else { return nil }
        return nav
    }
    /// 预设底部的工具栏
    lazy var axc_toolBarView: AxcBaseView = {
        let toolBarView = AxcBaseView()
        toolBarView.axc_shouldRecognizeSimultaneously = true    // 开启手势穿透
        toolBarView.backgroundColor = AxcBadrock.shared.backgroundColor
        toolBarView.axc_borderLineDirection(.top)
        toolBarView.axc_borderLineColor(AxcBadrock.shared.lineColor)
        toolBarView.axc_borderLineWidth(0.5)
        view.addSubview(toolBarView)
        toolBarView.axc.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(Axc_toolBarHeight)
        }
        return toolBarView
    }()
    
    // MARK: - 预设方法
    // MARK: TableView列表
    /// 设置一个tableView
    /// - Parameters:
    ///   - style: 样式
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    /// - Returns: tableView
    func axc_makeTableView(style: UITableView.Style = .plain,
                           delegate: UITableViewDelegate? = nil,
                           dataSource: UITableViewDataSource? = nil,
                           registers: [AxcRegistersTableCellTuples] = []) -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: style,
                                    delegate: delegate, dataSource: dataSource, registers: registers)
        return tableView
    }
    /// 设置一个collectionView
    /// - Parameters:
    ///   - layout: 布局
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    /// - Returns: cillectionView
    func axc_makeCollectionView(layout: UICollectionViewFlowLayout? = nil,
                                delegate: UICollectionViewDelegate? = nil,
                                dataSource: UICollectionViewDataSource? = nil,
                                registers: [AxcRegistersCollectionCellTuples] = []) -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, layout: layout,
                                              delegate: delegate, dataSource: dataSource, registers: registers)
        return collectionView
    }
    
    // MARK: 导航条按钮
    /// 持有返回图片的Image，不需要每次push重新获取，节约性能
    private var backArrowImage: UIImage = AxcBadrockBundle.arrowLeftImage
    /// 渲染成返回色的返回Image，如果渲染失败，则返回原图
    private var themeBackArrowImage: UIImage {
        guard let _themeBackArrowImage = backArrowImage.axc_tintColor(AxcBadrock.shared.backImageColor) else { return backArrowImage }
        return _themeBackArrowImage
    }
    /// 添加一个返回按钮
    func axc_addBackNavBarItem(title: String? = nil, image: UIImage? = nil, size: CGSize? = nil,
                               contentLayout: AxcButton.Layout = .img,
                               actionBlock: AxcActionBlock? = nil) {
        // 判断图片
        var _image = themeBackArrowImage
        if let itemImage = image { _image = itemImage }
        // 判断回调
        var _actionBlock: AxcActionBlock = { [weak self] (sender) in
            guard let weakSelf = self else { return }
            weakSelf.axc_navBarBack(sender)
        }
        if let block = actionBlock { _actionBlock = block }
        axc_addNavBarItem(title: title, image: _image, size: size, contentLayout: contentLayout, direction: .left, actionBlock: _actionBlock)
    }
    
    /// 返回按钮被触发时
    /// - Parameter sender: 触发对象
    func axc_navBarBack(_ sender: Any? ) {
        axc_popViewController()
    }
    
    /// 添加一个标题Navitem
    /// - Parameters:
    ///   - title: 标题
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_addTitleNavBarItem(title: String, direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_addNavBarItem(title: title, contentLayout: .text, direction: direction, actionBlock: actionBlock)
    }
    /// 添加一个图片
    /// - Parameters:Navitem
    ///   - image: 图片
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    func axc_addImageNavBarItem(image: UIImage, direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_addNavBarItem(image: image, contentLayout: .img, direction: direction, actionBlock: actionBlock)
    }
    /// 添加一个NavItem按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - size: 大小
    ///   - contentLayout: 按钮布局方式
    ///   - direction: 左右
    ///   - animate: 添加动画
    func axc_addNavBarItem(title: String? = nil, image: UIImage? = nil,
                           size: CGSize? = nil,
                           contentLayout: AxcButton.Layout = .imgLeft_textRight,
                           direction: AxcDirection = .left, animate: Bool = true,
                           actionBlock: @escaping AxcActionBlock) {
        navigationItem.axc_addBarItem(title: title, image: image, size: size,
                                      contentLayout: contentLayout,
                                      direction: direction, animate: animate,
                                      actionBlock: actionBlock)
    }
    
    // MARK: 推出和返回
    /// 推出一个VC
    /// - Parameters:
    ///   - vc: vc
    ///   - animation: 动画
    ///   - completion: 结束后回调
    func axc_pushViewController(_ vc: UIViewController, animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        navigationController?.axc_pushViewController(vc, animation: animation, completion: completion )
    }
    /// 返回本VC
    /// - Parameters:
    ///   - animation: 动画
    ///   - completion: 结束后回调
    func axc_popViewController(animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        navigationController?.axc_popViewController(animated: animation, completion: completion)
    }
    
    // MARK: 系统弹窗
    /// 弹出一个提示Alent
    /// - Parameters:
    ///   - msg: 消息
    ///   - style: 样式
    ///   - actionBlock: 触发Block
    func axc_popAlentPrompt(_ msg: String, style: UIAlertController.Style = .alert, actionBlock: AxcActionBlock? = nil) {
        axc_popAlent(title: AxcBadrockLanguage("提示"), msg: msg, actionTitles: [AxcBadrockLanguage("确定")],
                    style: style, actionBlock: actionBlock)
    }
    
    /// 弹出一个警告Alent
    /// - Parameters:
    ///   - msg: 消息
    ///   - style: 样式
    ///   - actionBlock: 触发Block
    func axc_popAlentWarning(_ msg: String, style: UIAlertController.Style = .alert, actionBlock: AxcActionBlock? = nil) {
        axc_popAlent(title: AxcBadrockLanguage("警告"), msg: msg, actionTitles: [AxcBadrockLanguage("确定")],
                    style: style, actionBlock: actionBlock)
    }
    
    /// 弹出一个alent
    /// - Parameters:
    ///   - title: 标题
    ///   - msg: 消息
    ///   - actionTitles: 触发标题组
    ///   - cancelTitle: 取消标题
    ///   - style: 样式
    ///   - actionBlock: action触发，
    ///   如果需要确定idx，则可以调用
    ///     let action = sender as? UIAlertAction;
    ///     let idx =  action.axc_intTag
    func axc_popAlent(title: String, msg: String? = nil,
                      actionTitles: [String], cancelTitle: String? = nil,
                      style: UIAlertController.Style = .alert,
                      tintColor: UIColor? = nil,
                      actionBlock: AxcActionBlock? = nil ) {
        let alentVC = UIAlertController(title: title, msg: msg,
                                        actionTitles: actionTitles, cancelTitle: cancelTitle,
                                        style: style, tintColor: tintColor,
                                        actionBlock: actionBlock)
        present(alentVC, animated: true, completion: nil)
    }
    
}
