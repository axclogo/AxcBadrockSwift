//
//  AxcBaseTabbarController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

/// item结构体
//struct AxcTabItem {
//    var className:String            /** < 类名 */
//    var title:String                /**< 上标题 */
//    var itemTitle:String            /**< item标题 */
//    var normalImg:UIImage?          /**< 图片 */
//    var selectedImg:UIImage?        /**< 选中图片 */
//    /// 实例化
//    public init(className: String, title: String, itemTitle:String,normalImg:UIImage?,selectedImg:UIImage?) {
//        self.className = className;
//        self.title = title;
//        self.itemTitle = itemTitle;
//        self.normalImg = normalImg;
//        self.selectedImg = selectedImg;
//    }
//}

//class AxcBaseTabbarController: UITabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        config()
//    }
//    func config() {
//        view.backgroundColor = UIColor.white
//    }
//    //MARK: - 开放参数
//    /// TabBar VC数组集合
//    public var itemVCs = [AxcTabItem](){
//        didSet{ itemVCs.forEach { createTab(item: $0) } }
//    }
//    /// 创建tab
//    public func createTab(item:AxcTabItem){
//        let _class = AxcClassFromString(item.className) as! UIViewController.Type
//        let vc = _class.init()
//        vc.title = item.title
//        let navVC = UINavigationController(rootViewController: vc)  // 包装nav
//        let _tabbarItem = UITabBarItem(title: item.itemTitle, image: item.normalImg, selectedImage: item.selectedImg)
//        navVC.tabBarItem = _tabbarItem;
//        addChild(navVC)
//    }
//
//    //MARK: 文字配置
//    /// TabBar普通状态文字颜色
//    public var textNormalColor :UIColor = UIColor(){
//        didSet{ tabbarItem.setTitleTextAttributes([.foregroundColor : textNormalColor],for:.normal)}
//    }
//    /// TabBar选中文字颜色
//    public var textSelectedColor :UIColor = UIColor(){
//        didSet{ tabbarItem.setTitleTextAttributes([.foregroundColor : textSelectedColor],for:.selected) }
//    }
//
//    //MARK: 图片配置
//    /// TabBar普通状态图片颜色
//    public var imgNormalColor :UIColor = UIColor(){
//        didSet{ tabBar.unselectedItemTintColor = imgNormalColor }
//    }
//    /// TabBar选中图片颜色
//    public var imgSelectedColor :UIColor = UIColor(){
//        didSet{ tabBar.tintColor = imgSelectedColor }
//    }
//
//    //MARK: TabBar配置
//    /// TabBar背景颜色
//    public var tabBarBackgroundColor :UIColor?{
//        didSet{
//            if tabBarBackgroundColor != nil {
//                tabBar.backgroundImage = UIImage()
//                tabBar.backgroundColor = tabBarBackgroundColor
//            }else{
//                tabBar.backgroundImage = nil
//                tabBar.backgroundColor = nil
//            }
//        }
//    }
//    /// 获取index的item
//    public func getItem(idx:Int) -> UITabBarItem?{
//        var items = [UITabBarItem]()
//        viewControllers?.forEach{ items.append($0.tabBarItem) }
//        guard idx < items.count  else { return nil}
//        return items[idx]
//    }
//    /// 设置item徽标内容
//    public func setBadge(text:String,idx:Int){
//        guard let item = getItem(idx: idx) else { return }
//        item.badgeValue = text
//    }
//    /// 设置item徽标颜色
//    public func setBadge(color:UIColor,idx:Int){
//        guard let item = getItem(idx: idx) else { return }
//        item.badgeColor = color
//    }
//    //MARK: - 私有
//    private let tabbarItem = UITabBarItem.appearance()
//
//
//}
