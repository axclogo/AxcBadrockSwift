//
//  AxcBaseVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseVC
/// 基类ViewController
@IBDesignable
open class AxcBaseVC: UIViewController, AxcBaseClassConfigProtocol, AxcBaseClassMakeUIProtocol {
    // MARK: - 初始化
    public init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }
    public convenience init(useNavBar: Bool = true) {
        self.init() // 初始化相关参数
        axc_useNavBar = useNavBar
        config()
    }
    required convenience public init?(coder: NSCoder) {
        self.init()
        config()
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 是否使用导航条 默认使用
    open var axc_useNavBar: Bool = true {
        didSet { navigationController?.setNavigationBarHidden(!axc_useNavBar, animated: true) }
    }
    /// 状态栏是否为黑色 默认true
    open var axc_stateBarIsBlock: Bool = true {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    /// 获取 AxcBaseNavController
    open var axc_navController: AxcBaseNavController? {
        guard let nav = navigationController as? AxcBaseNavController else { return nil }
        return nav
    }
    /// 是否为横屏
    open var axc_isScreenHorizontal: Bool {
        let orientation = Axc_device.orientation
        return ((orientation == .landscapeLeft)||(orientation == .landscapeRight))
    }
    /// 是否屏幕朝上
    open var axc_isScreenUp: Bool {
        let orientation = Axc_device.orientation
        return orientation == .faceUp
    }
    /// 设置支持的屏幕转向 nav会读取调用
    open var axc_screenOrientation: UIInterfaceOrientationMask = .all
    
    // MARK: TableView列表
    /// 设置一个tableView
    /// - Parameters:
    ///   - style: 样式
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    /// - Returns: tableView
    open func axc_makeTableView(style: UITableView.Style = .plain,
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
    open func axc_makeCollectionView(layout: UICollectionViewFlowLayout? = nil,
                                delegate: UICollectionViewDelegate? = nil,
                                dataSource: UICollectionViewDataSource? = nil,
                                registers: [AxcRegistersCollectionCellTuples] = []) -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, layout: layout,
                                              delegate: delegate, dataSource: dataSource, registers: registers)
        return collectionView
    }
    
    // MARK: view包装
    /// 添加视图
    open func axc_addSubView(_ view: UIView) {
        if let _view = view as? AxcBaseView {
            _view.axc_vc = self;
        }
        self.view.addSubview(view)
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
    open func axc_addBackNavBarItem(title: String? = nil, image: UIImage? = nil, size: CGSize? = nil,
                               contentLayout: AxcButtonStyle = .img,
                               actionBlock: AxcActionBlock? = nil) {
        var _image = themeBackArrowImage    // 判断图片
        if let itemImage = image { _image = itemImage }
        var _actionBlock: AxcActionBlock = { [weak self] (sender) in    // 判断回调
            guard let weakSelf = self else { return }
            weakSelf.axc_navBarBack(sender)
        }
        if let block = actionBlock { _actionBlock = block }
        axc_addNavBarItem(title: title, image: _image, size: size, contentLayout: contentLayout, direction: .left, actionBlock: _actionBlock)
    }
    
    /// 返回按钮被触发时
    /// - Parameter sender: 触发对象
    open func axc_navBarBack(_ sender: Any? ) {
        axc_popViewController()
    }
    
    /// 添加一个标题Navitem
    /// - Parameters:
    ///   - title: 标题
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    open func axc_addTitleNavBarItem(title: String, direction: AxcDirection = .left,
                                actionBlock: @escaping AxcActionBlock){
        axc_addNavBarItem(title: title, contentLayout: .text, direction: direction, actionBlock: actionBlock)
    }
    /// 添加一个图片
    /// - Parameters:Navitem
    ///   - image: 图片
    ///   - direction: 方位
    ///   - actionBlock: 触发事件
    open func axc_addImageNavBarItem(image: UIImage, direction: AxcDirection = .left,
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
    open func axc_addNavBarItem(title: String? = nil, image: UIImage? = nil,
                           size: CGSize? = nil,
                           contentLayout: AxcButtonStyle = .imgLeft_textRight,
                           direction: AxcDirection = .left, animate: Bool = true,
                           actionBlock: @escaping AxcActionBlock) {
        navigationItem.axc_addBarItem(title: title, image: image, size: size,
                                      contentLayout: contentLayout,
                                      direction: direction, animate: animate,
                                      actionBlock: actionBlock)
    }
    
    // MARK: 预设控件设置相关
    /// 添加底部自定义工具栏
    open func axc_addCustomToolBar() {
        view.addSubview(axc_toolBarView)
        axc_toolBarView.axc.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(Axc_toolBarHeight)
        }
    }
    /// 添加顶部自定义导航栏
    open func axc_addCustomNavBar() {
        view.addSubview(axc_navBar)
        axc_navBar.axc.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(Axc_statusHeight + Axc_navBarHeight)
        }
    }
    
    // MARK: 推出视图
    /// pullUp拉起一个单选
    /// - Parameters:
    ///   - title: 标题
    ///   - dataList: 数据源
    ///   - selectedBlock: 选中回调block
    ///   - animation: 动画
    ///   - completion: 完成动画
    /// - Returns: AxcPickerView
    @discardableResult
    open func axc_presentPickerView(_ title: String? = nil,
                               dataList: [Any],
                               selectedBlock: @escaping (_ pickerView: AxcPickerView,
                                                         _ index: Int) -> Void,
                               animation: Bool = true,
                               completion: AxcEmptyBlock? = nil) -> AxcPickerView {
        let pickerView = AxcPickerView(title, dataList: dataList, selectedBlock: selectedBlock)
        let alentVC = axc_presentSheetView(pickerView, animation: animation, completion: completion)
        pickerView.axc_leftButton.axc_addEvent { (_) in alentVC.axc_dismissViewController() }
        pickerView.axc_rightButton.axc_addEvent { (_) in
            selectedBlock(pickerView,pickerView.axc_selectedIdx)
            alentVC.axc_dismissViewController()
        }
        return pickerView
    }
    /// presentSheet一个View
    /// - Parameters:
    ///   - view: 要推出的视图
    ///   - size: 视图大小
    ///   - showDirection: 支持按位与运算，支持单选
    ///     多选状态下，支持拉伸约束，单选仅支持size大小变化
    ///   - animation: 动画
    ///   - completion: 完成回调
    /// - Returns: AxcSheetVC
    @discardableResult
    open func axc_presentSheetView(_ view: UIView,
                              size: CGSize? = nil,
                              showDirection: AxcDirection = .bottom,
                              animation: Bool = true,
                              completion: AxcEmptyBlock? = nil) -> AxcAlentVC {
        let alentVC = AxcAlentVC(view: view, size: size, showDirection: showDirection)
        axc_presentViewController(alentVC, animation: animation, completion: completion)
        return alentVC
    }
    
    /// 返回一个vc，无论是present还是push
    open func axc_backViewController(animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        dismiss(animated: animation, completion: completion)
        axc_popViewController(animation: animation, completion: completion)
    }
    /// 拉起一个vc，present
    open func axc_presentViewController(_ vc: UIViewController, animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        vc.modalPresentationStyle = .fullScreen // 全屏拉起
        present(vc, animated: animation, completion: completion)
    }
    /// 返回一个present的vc
    open func axc_dismissViewController(animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        dismiss(animated: animation, completion: completion)
    }
    
    /// 推出一个VC
    /// - Parameters:
    ///   - vc: vc
    ///   - animation: 动画
    ///   - completion: 结束后回调
    open func axc_pushViewController(_ vc: UIViewController, animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        navigationController?.axc_pushViewController(vc, animation: animation, completion: completion )
    }
    /// 返回本VC
    /// - Parameters:
    ///   - animation: 动画
    ///   - completion: 结束后回调
    open func axc_popViewController(animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        navigationController?.axc_popViewController(animated: animation, completion: completion)
    }
    
    // MARK: 系统弹窗
    /// 弹出一个提示Alent
    /// - Parameters:
    ///   - msg: 消息
    ///   - style: 样式
    ///   - actionBlock: 触发Block
    open func axc_popAlentPrompt(_ msg: String, style: UIAlertController.Style = .alert, actionBlock: AxcActionBlock? = nil) {
        axc_popAlent(title: AxcBadrockLanguage("提示"), msg: msg, actionTitles: [AxcBadrockLanguage("确定")],
                    style: style, actionBlock: actionBlock)
    }
    
    /// 弹出一个警告Alent
    /// - Parameters:
    ///   - msg: 消息
    ///   - style: 样式
    ///   - actionBlock: 触发Block
    open func axc_popAlentWarning(_ msg: String, style: UIAlertController.Style = .alert, actionBlock: AxcActionBlock? = nil) {
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
    open func axc_popAlent(title: String, msg: String? = nil,
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
    
    // MARK: - 子类实现
    /// 配置 执行于makeUI()之前
    open func config() { }
    /// 设置UI布局
    open func makeUI() { }
    
    // MARK: - 父类重写
    /// 视图加载完成
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        if #available(iOS 11, *) { } else { // 低于11版本
            automaticallyAdjustsScrollViewInsets = false
        }
        makeUI()
    }
    /// 设置标题
    open override var title: String? {
        didSet { _axc_navBar?.axc_title = title }
    }
    /// 开始点击视图控制器
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(false)
    }
    
    // MARK: 生命周期
    /// 即将出现
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!axc_useNavBar, animated: true)
    }
    /// 已经出现
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    /// 即将消失
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    /// 已经消失
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    /// 状态栏颜色
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return axc_stateBarIsBlock ? .default : .lightContent
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    /// 预设底部的工具栏
    open lazy var axc_toolBarView: AxcBaseView = {
        let toolBarView = AxcBaseView()
        toolBarView.backgroundColor = AxcBadrock.shared.backgroundColor
        toolBarView.axc_setBorderLineDirection(.top)
        toolBarView.axc_setBorderLineColor(AxcBadrock.shared.lineColor)
        toolBarView.axc_setBorderLineWidth(0.5)
        toolBarView.axc_shadowOpacity = AxcBadrock.shared.shadowOpacity
        toolBarView.axc_shadowColor = AxcBadrock.shared.shadowColor
        toolBarView.axc_shadowOffset = CGSize((1, -1))
        return toolBarView
    }()
    
    // 不执行懒加载的对象指针
    private var _axc_navBar: AxcNavBar?
    /// 预设的自定义顶部导航条控件
    open lazy var axc_navBar: AxcNavBar = {
        let barView = AxcNavBar()
        barView.axc_shadowOpacity = AxcBadrock.shared.shadowOpacity
        barView.axc_shadowColor = AxcBadrock.shared.shadowColor
        barView.axc_shadowOffset = CGSize((1, 1))
        axc_stateBarIsBlock = false
        // 使navBar的颜色与状态栏颜色自动适配
        barView.axc_didSetBackgroundColorBlock = { [weak self] (_,color) in
            guard let weakSelf = self else { return }
            guard let isLight = color?.axc_isLight else { return }
            weakSelf.axc_stateBarIsBlock = isLight // 检查导航栏颜色是否为亮色或淡色
        }
        _axc_navBar = barView
        return barView
    }()
    
    deinit { AxcLog("视图控制器VC已销毁：\(self)", level: .trace) }
}
