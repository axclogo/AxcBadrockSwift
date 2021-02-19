//
//  AxcUITabBarControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - 属性 & Api
/// item结构体
public struct AxcTabItem {
    var className:          String = "AxcBaseViewController"        // 页面类名
    var navClassName:       String = "AxcBaseNavigationController"  // 页面对应的导航控制器类名
    var title:              String = ""                             // 上标题
    var itemTitle:          String = ""                             // item标题
    // 未选中
    var normalImg:          UIImage                 = AxcBadrockBundle.placeholderImage // 正常图片
    var normalImgSize:      CGSize                  = CGSize((25,25))                   // 正常图片大小
    var normalImgMode:      UIImage.RenderingMode   = .alwaysOriginal                   // 正常图片模式
    var normalImgColor:     UIColor?                                                    // 图片颜色
    // 选中
    var selectedImg:        UIImage                 = AxcBadrockBundle.placeholderImage // 选中图片
    var selectedImgSize:    CGSize                  = CGSize((25,25))                   // 选中图片大小
    var selectedImgMode:    UIImage.RenderingMode   = .alwaysOriginal                   // 选中图片模式
    var selectedImgColor:   UIColor?                                                    // 图片颜色
    /// 实例化
    public init(className:          String? = nil,
                navClassName:       String? = nil,
                title:              String? = nil,
                itemTitle:          String? = nil,
                
                normalImg:          UIImage?                = nil,
                normalImgSize:      CGSize?                 = nil,
                normalImgMode:      UIImage.RenderingMode?  = nil,
                normalImgColor:     UIColor?                = nil,
                
                selectedImg:        UIImage?                = nil,
                selectedImgSize:    CGSize?                 = nil,
                selectedImgMode:    UIImage.RenderingMode?  = nil,
                selectedImgColor:   UIColor?                = nil ) {
        if let _className = className           { self.className    = _className }
        if let _navClassName = navClassName     { self.navClassName = _navClassName }
        if let _title = title                   { self.title        = _title }
        if let _itemTitle = itemTitle           { self.itemTitle    = _itemTitle }
        // 未选中
        if let _normalImg = normalImg           { self.normalImg        = _normalImg }
        if let _normalImgSize = normalImgSize   { self.normalImgSize    = _normalImgSize }
        if let _normalImgMode = normalImgMode   { self.normalImgMode    = _normalImgMode }
        if let _normalImgColor = normalImgColor { self.normalImgColor   = _normalImgColor }
        //  选中图片
        if let _selectedImg = selectedImg           { self.selectedImg      = _selectedImg }
        if let _selectedImgSize = selectedImgSize   { self.selectedImgSize  = _selectedImgSize }
        if let _selectedImgMode = selectedImgMode   { self.selectedImgMode  = _selectedImgMode }
        if let _selectedImgColor = selectedImgColor { self.selectedImgColor = _selectedImgColor }
    }
    // 链式语法
    /// 设置类名
    mutating func className(_ name: String ) -> AxcTabItem { self.className = name; return self }
    /// 页面对应的导航控制器类名
    mutating func navClassName(_ name: String ) -> AxcTabItem { self.navClassName = name; return self }
    /// vc上标题
    mutating func title(_ title: String ) -> AxcTabItem { self.title = title; return self }
    /// item标题
    mutating func itemTitle(_ itemTitle: String ) -> AxcTabItem { self.itemTitle = itemTitle; return self }
    // 未选中
    /// 正常图片
    mutating func normalImg(_ normalImg: UIImage ) -> AxcTabItem { self.normalImg = normalImg; return self }
    /// 正常图片大小
    mutating func normalImgSize(_ normalImgSize: CGSize ) -> AxcTabItem { self.normalImgSize = normalImgSize; return self }
    /// 正常图片模式
    mutating func normalImgMode(_ normalImgMode: UIImage.RenderingMode ) -> AxcTabItem { self.normalImgMode = normalImgMode; return self }
    /// 正常图片
    mutating func normalImgColor(_ normalImgColor: UIColor ) -> AxcTabItem { self.normalImgColor = normalImgColor; return self }
    //  选中图片
    /// 选中图片
    mutating func selectedImg(_ selectedImg: UIImage ) -> AxcTabItem { self.selectedImg = selectedImg; return self }
    /// 选中图片大小
    mutating func selectedImgSize(_ selectedImgSize: CGSize ) -> AxcTabItem { self.selectedImgSize = selectedImgSize; return self }
    /// 选中图片模式
    mutating func selectedImgMode(_ selectedImgMode: UIImage.RenderingMode ) -> AxcTabItem { self.selectedImgMode = selectedImgMode; return self }
    /// 选中图片
    mutating func selectedImgColor(_ selectedImgColor: UIColor ) -> AxcTabItem { self.selectedImgColor = selectedImgColor; return self }
}

public extension UITabBarController {
    /// 创建tab栏
    /// - Parameter item: item
    func axc_addTabItem(_ item: AxcTabItem) {
        guard let _vcClass = AxcClassFromString(item.className)     as? UIViewController.Type else { return }
        guard let _navClass = AxcClassFromString(item.navClassName) as? UINavigationController.Type else { return }
        let vc = _vcClass.init()
        let currentIdx = (viewControllers?.count ?? 0) + 1
        let title = "[ \(currentIdx) ]"
        if item.title.count == 0 { vc.title = title }
        vc.view.backgroundColor = UIColor.systemGroupedBackground
        let navVC = _navClass.init(rootViewController: vc)  // 包装nav
        // item
        var itemTitle = item.itemTitle
        if item.itemTitle.count == 0 { itemTitle = title }
        var tabNormalImg = (item.normalImg.size == item.normalImgSize) ? item.normalImg : item.normalImg.axc_scale(size: item.normalImgSize)
        if let normalImgColor = item.normalImgColor {   // 如果有设置颜色
            tabNormalImg = tabNormalImg?.axc_tintColor( normalImgColor )
        }
        tabNormalImg = tabNormalImg?.withRenderingMode( item.normalImgMode )
        var tabSelectedImg = (item.selectedImg.size == item.selectedImgSize) ? item.selectedImg : item.selectedImg.axc_scale(size: item.selectedImgSize)
        if let selectedImgColor = item.selectedImgColor {   // 如果有设置颜色
            tabSelectedImg = tabSelectedImg?.axc_tintColor( selectedImgColor )
        }
        tabSelectedImg = tabSelectedImg?.withRenderingMode( item.selectedImgMode )
        let _tabbarItem = UITabBarItem(title: itemTitle, image: tabNormalImg, selectedImage: tabSelectedImg)
        navVC.tabBarItem = _tabbarItem;
        addChild(navVC)
    }
}

// MARK: - item操作相关
private var k_items = "k_items"
public extension UITabBarController {
    /// 私有保存items
    private var _items: [UITabBarItem] {
        set { AxcRuntime.setAssociatedObj(self, &k_items, newValue) }
        get {
            guard let items = AxcRuntime.getAssociatedObj(self, &k_items) as? [UITabBarItem] else {
                var itemArray = [UITabBarItem]()
                viewControllers?.forEach{ itemArray.append($0.tabBarItem) }
                AxcRuntime.setAssociatedObj(self, &k_items, itemArray)
                return itemArray
            }
            return items
        }
    }
    /// 通过index获取item
    func axc_item(_ idx: Int) -> UITabBarItem? {
        guard idx < _items.count  else { AxcLog("设置UITabBarItem的索引越界！index: %@",idx , level: .fatal); return nil }
        return _items[idx]
    }
    
    // MARK: 文字状态
    /// 设置item的文字未选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemNormalTextColor(_ color: UIColor ) {
        UITabBarItem.appearance().axc_normalTextColor(color)
    }
    /// 设置item的文字选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemSelectedTextColor(_ color: UIColor ) {
        UITabBarItem.appearance().axc_selectedTextColor(color)
    }
    
    // MARK: 图片状态
    /// 设置item的图片未选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemNormalImageColor(_ color: UIColor ) {
        tabBar.unselectedItemTintColor = color
    }
    /// 设置item的图片选中颜色
    /// - Parameters:
    ///   - color: 颜色
    func axc_itemSelectedImageColor(_ color: UIColor, _ idx: Int? = nil ) {
        tabBar.tintColor = color
    }
    
    // MARK: 徽标状态
    /// 设置item的徽标值
    /// - Parameters:
    ///   - text: 值
    ///   - idx: 索引
    func axc_itemBadge(text: String, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.badgeValue = text
    }
    /// 设置item的徽标偏移量
    /// - Parameters:
    ///   - offset: 偏移量
    ///   - idx: 索引
    func axc_itemBadge(offset: CGSize, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.titlePositionAdjustment = UIOffset(horizontal: offset.width, vertical: offset.height)
    }
    /// 设置item的徽标颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - idx: 索引
    func axc_itemBadge(color: UIColor, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.badgeColor = color
    }
    /// 设置item的徽标偏移量
    /// - Parameters:
    ///   - offset: 偏移量
    ///   - idx: 索引
    func axc_itemBadge(textAttributes: [NSAttributedString.Key : Any], state: UIControl.State, _ idx: Int ) {
        guard let item = axc_item(idx) else { return }
        item.setBadgeTextAttributes(textAttributes, for: state)
    }
    
}

// MARK: - 决策判断
public extension UITabBarController {
    
}
