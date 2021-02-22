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
    // MARK: - 属性
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
        var leftWidth: CGFloat = 0
        for idx in 0..<leftBarItems.count {
            let itemSize = collectionView(leftCollectionView, layout: leftItemLayout, sizeForItemAt: IndexPath(row: idx))
            leftWidth += itemSize.width
        }
        leftCollectionView.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(leftWidth)
        }
        // 右collection 计算宽度
        var rightWidth: CGFloat = 0
        for idx in 0..<rightBarItems.count {
            let itemSize = collectionView(leftCollectionView, layout: leftItemLayout, sizeForItemAt: IndexPath(row: idx))
            rightWidth += itemSize.width
        }
        rightCollectionView.axc.remakeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(rightWidth)
        }
    }

    // MARK: 回调
    /// 设置item大小回调，默认Axc_navigationItemSize
    var axc_itemSizeBlock: AxcNavBarItemSizeBlock = { (_,_,_) in
        return Axc_navigationItemSize.width
    }
    /// 设置间距 默认
    var axc_sectionInseteBlock: AxcNavBarSectionInsetBlock = { (_,_) in
        return UIEdgeInsets(
    }
    /// 点击事件回调
    var axc_selectedBlock: AxcNavBarSelectedBlock = { (bar,direction,index) in
        AxcLog("未设置AxcNavBar的点击回调\nAxcNavBar: \(bar)\nAxcDirection: \(direction)\nIndex: \(index)", level: .info)
    }
    
    
    // MARK: - 懒加载
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

private class AxcNavBarItemCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var itemView: UIView? = nil {
        didSet {    // 重新约束布局
            guard let view = itemView else { return }
            contentView.axc_removeAllSubviews()
            contentView.addSubview(view)
            view.axc.remakeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
    
}
