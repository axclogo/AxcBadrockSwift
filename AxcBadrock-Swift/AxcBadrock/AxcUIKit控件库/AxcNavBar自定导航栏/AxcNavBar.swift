//
//  AxcNavBar.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

public typealias AxcNavBarItemSizeBlock = (_ navBar: AxcNavBar, _ direction: AxcDirection, _ index: Int) -> CGFloat
public typealias AxcNavBarSectionInsetBlock = (_ navBar: AxcNavBar, _ direction: AxcDirection ) -> UIEdgeInsets
public typealias AxcNavBarSelectedBlock = (_ navBar: AxcNavBar, _ direction: AxcDirection, _ index: Int) -> Void

public extension AxcNavBar {
    enum Style {
        case title      // 标题
        case search     // 搜索
        case button     // 按钮
        case searchButton     // 搜索按钮
    }
}

@IBDesignable
public class AxcNavBar: AxcBaseView {
    // MARK: - 创建UI
    public override func makeUI() {
        // 默认渐变背景
        axc_setGradient()
        // 设置边框线色
        axc_setBorderLineDirection()
        axc_setBorderLineWidth(0.5)
        addSubview(contentView)
        contentView.addSubview(leftCollectionView)
        contentView.addSubview(rightCollectionView)
        contentView.addSubview(titleView)
        
        reloadLayout()
    }
    // MARK: - Api
    /// 设置标题
    var axc_title: String? {
        didSet { titleLabel.text = axc_title; reloadStyleLayout() }
    }
    /// 设置样式
    var axc_style: AxcNavBar.Style = .title {
        didSet {
            titleView.subviews.forEach{ $0.isHidden = true } // 全部隐藏
            switch axc_style {
            case .title:
                // 标题label
                titleLabel.isHidden = false
                if !titleView.subviews.contains(titleLabel) {
                    titleView.addSubview(titleLabel)
                }
                let textWidth = titleLabel.axc_estimatedWidth()
                titleLabel.axc.remakeConstraints { (make) in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(textWidth).priority(2) // 估算宽度
                    make.right.lessThanOrEqualTo(rightCollectionView.axc.left).offset(-5).priority(4)
                    make.left.greaterThanOrEqualTo(leftCollectionView.axc.right).offset(5).priority(4)
                    make.centerX.equalTo(self.axc.centerX).priority(3)
                }
            default:
                break
            }
        }
    }
    
    /// 添加一个返回按钮
    /// - Parameter image: 返回按钮图片
    func axc_addBackItem(_ image: UIImage? = nil) {
        var backImage = AxcBadrockBundle.arrowLeftImage.axc_tintColor(AxcBadrock.shared.themeColor)
        if let _image = image { backImage = _image }
        axc_addAxcButtonItem(image: backImage, contentLayout: .img, direction: .left)
    }
    
    /// 添加一个AxcButton按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - contentLayout: 布局
    ///   - direction: 方位
    func axc_addAxcButtonItem(title: String? = nil, image: UIImage? = nil,
                              contentLayout: AxcButton.Layout = .imgLeft_textRight ,
                              direction: AxcDirection = .left) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let btn = AxcButton(title: title, image: image)
        btn.contentLayout = contentLayout
        btn.contentInset = UIEdgeInsets.zero
        btn.isUserInteractionEnabled = false    // 触发交给回调
        axc_addItem(btn)
    }
    /// 添加一个按钮
    func axc_addItem(_ barItem: UIView, direction: AxcDirection = .left) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left {
            leftBarItems.append(barItem)
            leftCollectionView.reloadData()
        }else{
            rightBarItems.append(barItem)
            rightCollectionView.reloadData()
        }
        reloadLayout()
    }
    /// 移除一个按钮
    func axc_removeItem(_ idx: Int, direction: AxcDirection = .left) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left {
            leftBarItems.axc_remove(idx)
            leftCollectionView.reloadData()
        }else{
            rightBarItems.axc_remove(idx)
            rightCollectionView.reloadData()
        }
        reloadLayout()
    }
    /// 移除所有按钮
    func axc_removeAllItem(direction: AxcDirection = .left) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        if direction == .left {
            leftBarItems.removeAll()
            leftCollectionView.reloadData()
        }else{
            rightBarItems.removeAll()
            rightCollectionView.reloadData()
        }
        reloadLayout()
    }
    
    /// 更新bar的布局
    func reloadLayout() {
        // 内容视图
        contentView.axc.remakeConstraints { (make) in
            make.top.equalTo(Axc_statusHeight)
            make.left.bottom.right.equalToSuperview()
        }
        // 左collection 计算宽度
        var leftWidth: CGFloat = collectionView(leftCollectionView, layout: leftItemLayout, insetForSectionAt: 0).left
        for idx in 0..<leftBarItems.count {
            let itemSize = collectionView(leftCollectionView, layout: leftItemLayout, sizeForItemAt: IndexPath(row: idx))
            leftWidth += itemSize.width
        }
        leftCollectionView.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(leftWidth)
        }
        // 右collection 计算宽度
        var rightWidth: CGFloat = collectionView(rightCollectionView, layout: leftItemLayout, insetForSectionAt: 0).right
        for idx in 0..<rightBarItems.count {
            let itemSize = collectionView(leftCollectionView, layout: leftItemLayout, sizeForItemAt: IndexPath(row: idx))
            rightWidth += itemSize.width
        }
        rightCollectionView.axc.remakeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(rightWidth)
        }
        // 标题视图
        titleView.axc.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(leftCollectionView.axc.right)
            make.right.equalTo(rightCollectionView.axc.left)
        }
        reloadStyleLayout()
    }
    // 刷新样式布局
    func reloadStyleLayout() {
        let _axc_style = axc_style
        axc_style = _axc_style
    }

    // MARK: - 回调
    /// 设置item大小回调，默认Axc_navigationItemSize
    var axc_itemSizeBlock: AxcNavBarItemSizeBlock = { (_,_,_) in
        return Axc_navigationItemSize.width
    }
    /// 设置间距 默认 UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    var axc_sectionInseteBlock: AxcNavBarSectionInsetBlock = { (_,direction) in
        if direction == .left {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
    }
    /// 点击事件回调
    var axc_selectedBlock: AxcNavBarSelectedBlock = { (bar,direction,index) in
        AxcLog("未设置AxcNavBar的点击回调\nAxcNavBar: \(bar)\nAxcDirection: \(direction)\nIndex: \(index)", level: .info)
    }
    
    // MARK: - 懒加载
    // MARK: 样式控件
    lazy var titleLabel: AxcLabel = {
        let label = AxcLabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = AxcBadrock.shared.textColor
        return label
    }()
    private var _titleButton: AxcButton?  // 类似oc的下划线，不会调用懒加载的使用方式
    lazy var titleButton: AxcButton = {
        let button = AxcButton()
        _titleButton = button
        return button
    }()
    private var _titleTextField: AxcTextField?  // 类似oc的下划线，不会调用懒加载的使用方式
    lazy var titleTextField: AxcTextField = {
        let textField = AxcTextField()
        _titleTextField = textField
        return textField
    }()
    
    // MARK: 基础控件
    var rightBarItems: [UIView] = []
    /// 右列表
    lazy var rightCollectionView: UICollectionView = {
        let collectionView = UICollectionView(layout: rightItemLayout,
                                              delegate: self, dataSource: self,
                                              registers: [(class: AxcNavBarItemCell.self, useNib: false)])
        collectionView.isScrollEnabled = false // 禁止滑动
        collectionView.tag = Axc_TagStar + 1
        return collectionView
    }()
    /// 右布局
    lazy private var rightItemLayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.axc_intTag = Axc_TagStar + 1
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    var leftBarItems: [UIView] = []
    /// 左列表
    lazy var leftCollectionView: UICollectionView = {
        let collectionView = UICollectionView(layout: leftItemLayout,
                                              delegate: self, dataSource: self,
                                              registers: [(class: AxcNavBarItemCell.self, useNib: false)])
        collectionView.isScrollEnabled = false // 禁止滑动
        collectionView.tag = Axc_TagStar + 0
        return collectionView
    }()
    /// 左布局
    lazy private var leftItemLayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.axc_intTag = Axc_TagStar + 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    /// 标题视图
    lazy var titleView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    /// 内容承载视图
    lazy var contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
}

// MARK: - 代理&数据源
extension AxcNavBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 点击事件
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isLeft = collectionView.tag - Axc_TagStar == 0
        let direction: AxcDirection = isLeft ? .left : .right
        var index = indexPath.row
        if !isLeft { index = transformRightIndex(indexPath) }
        axc_selectedBlock(self, direction, index) // 回调Block
    }
    // 数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag - Axc_TagStar == 0 { // 左item
            return leftBarItems.count
        }else{  // 右item
            return rightBarItems.count
        }
    }
    // cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let original_cell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxcClassFromString(AxcNavBarItemCell.self), for: indexPath) as? AxcNavBarItemCell
        else { return original_cell }
        if collectionView.tag - Axc_TagStar == 0 { // 左item
            cell.itemView = leftBarItems[indexPath.row]
        }else{  // 右item
            cell.itemView = rightBarItems[indexPath.row]
        }
        return cell
    }
    // item大小
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLeft = collectionView.tag - Axc_TagStar == 0
        let direction: AxcDirection = isLeft ? .left : .right
        var index = indexPath.row
        if !isLeft { index = transformRightIndex(indexPath) }
        let width = axc_itemSizeBlock(self, direction, index)
        return CGSize((width,collectionView.axc_height))
    }
    // 组边距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let isLeft = collectionView.tag - Axc_TagStar == 0
        let direction: AxcDirection = isLeft ? .left : .right
        return axc_sectionInseteBlock(self, direction)
    }
    // 转换右边的按钮索引
    func transformRightIndex(_ indexPath: IndexPath) -> Int {
        var index = indexPath.row
        if rightBarItems.count > 0 { // 右边取反
            index = rightBarItems.count - indexPath.row - 1
        }
        return index
    }
}

// MARK: - cell
private class AxcNavBarItemCell: UICollectionViewCell {
    var itemView: UIView? = nil {
        didSet {    // 重新约束布局
            guard let view = itemView else { return }
            axc_removeAllSubviews()
            addSubview(view)
            view.axc.remakeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
}
