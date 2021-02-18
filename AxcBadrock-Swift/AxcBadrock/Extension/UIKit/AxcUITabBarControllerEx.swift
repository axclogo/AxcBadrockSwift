//
//  AxcUITabBarControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - 类方法/属性
public extension UITabBarController {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
/// item结构体
struct AxcTabItem {
    var className:String            /** < 类名 */
    var title:String                /**< 上标题 */
    var itemTitle:String            /**< item标题 */
    var normalImg:UIImage?          /**< 图片 */
    var selectedImg:UIImage?        /**< 选中图片 */
    /// 实例化
    public init(className: String = "AxcBaseViewController",
                title: String = "",
                itemTitle: String = "",
                normalImg: UIImage? = nil,
                selectedImg:UIImage? = nil) { 占位图
        self.className = className
        self.title = title
        self.itemTitle = itemTitle
        self.normalImg = normalImg
        self.selectedImg = selectedImg
    }
}
public extension UITabBarController {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 【对象特性扩展区】
public extension UITabBarController {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension UITabBarController {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension UITabBarController {
}

// MARK: - 运算符
public extension UITabBarController {
}
