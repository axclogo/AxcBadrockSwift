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
public typealias AxcNavBarScrollClearBlock = (_ navBar: AxcNavBar, _ alpha: CGFloat ) -> Void

public extension AxcNavBar {
    enum Style {
        case title                  // 标题
        case button                 // 按钮
        case searchButton           // 搜索按钮
        case textField              // 文本输入
        case actionPrefixTextField  // 带前缀按钮的文本输入
    }
}

@IBDesignable
public class AxcNavBar: AxcBaseView {
    // MARK: - 创建UI
    public override func makeUI() {
        addSubview(backgroundView)
        backgroundView.axc.makeConstraints { (make) in make.edges.equalToSuperview() }
        // 默认渐变背景
        backgroundView.axc_setGradient()
        // 设置边框线色
        backgroundView.axc_setBorderLineDirection(.bottom)
        backgroundView.axc_setBorderLineWidth(0.5)
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
            titleView.axc_hiddenAllSubviews() // 全部隐藏
            switch axc_style {
            case .title: // 标题label
                titleLabel.isHidden = false
                if !titleView.subviews.contains(titleLabel) { titleView.addSubview(titleLabel) }
                titleLabel.axc.remakeConstraints { (make) in
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-5)
                    make.centerX.equalTo(self.axc.centerX)
                    make.left.greaterThanOrEqualToSuperview().offset(5)
                    make.right.lessThanOrEqualToSuperview().offset(-5)
                }
            case .button:   // 标题按钮
                titleButton.isHidden = false
                if !titleView.subviews.contains(titleButton) { titleView.addSubview(titleButton) }
                titleButton.axc.remakeConstraints { (make) in
                    make.left.right.equalTo(0)
                    make.top.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-5)
                }
            case .searchButton: // 标题搜索按钮
                titleButton.isHidden = false
                if !titleView.subviews.contains(titleButton) { titleView.addSubview(titleButton) }
                titleButton.axc.remakeConstraints { (make) in
                    make.left.right.equalTo(0)
                    make.top.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-5)
                }
                titleButton.axc_imgSize = 15
                titleButton.titleLabel.text = AxcBadrockLanguage("点击触发")
                titleButton.imageView.image = AxcBadrockBundle.magnifyingGlassImage.axc_tintColor(AxcBadrock.shared.unTextColor)
            case .textField:    // 标题文本输入
                titleTextField.isHidden = false
                if !titleView.subviews.contains(titleTextField) { titleView.addSubview(titleTextField) }
                titleTextField.axc.remakeConstraints { (make) in
                    make.left.right.equalTo(0)
                    make.top.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-5)
                }
            case .actionPrefixTextField:    // 带前缀按钮的文本输入
                titleTextField.isHidden = false
                if !titleView.subviews.contains(titleTextField) { titleView.addSubview(titleTextField) }
                titleTextField.axc.remakeConstraints { (make) in
                    make.left.right.equalTo(0)
                    make.top.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-5)
                }
                titleTextField.leftButton.titleLabel.text = AxcBadrockLanguage("点击触发")
                titleTextField.axc_style = .actionPrefix
            }
        }
    }
    /// 设置内容间距
    var axc_contentEdge: UIEdgeInsets = UIEdgeInsets.zero {
        didSet { reloadLayout() }
    }
    /// 设置标题内容视图间距
    var axc_titleContentEdge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet { reloadLayout() }
    }
    
    /// 设置随滑动透明效果
    /// - Parameters:
    ///   - scrollView: 滑动视图，一般只支持垂直滑动类型
    ///   - criticalHeight: 临界高度
    func axc_setScrollClear(_ scrollView: UIScrollView, criticalHeight: CGFloat) {
        let offset = scrollView.contentOffset.y
        var alpha: CGFloat = 1
        if offset < criticalHeight { // 越过临界值
            alpha = (criticalHeight - offset) / criticalHeight
        }else{ alpha = 0 }
        backgroundView.alpha = alpha
        axc_scrollClearBlock(self, alpha)
    }
    
    /// 添加一个返回按钮
    /// - Parameter image: 返回按钮图片
    func axc_addBackItem(_ image: UIImage? = nil) {
        var backImage = AxcBadrockBundle.arrowLeftImage.axc_tintColor(AxcBadrock.shared.themeFillContentColor)
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
                              contentLayout: AxcButton.Style = .imgLeft_textRight ,
                              direction: AxcDirection = .left) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let btn = AxcButton(title: title, image: image)
        btn.axc_style = contentLayout
        btn.axc_contentInset = UIEdgeInsets.zero
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
    
    // MARK: 回调
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
        AxcLog("[可选]未设置AxcNavBar的点击回调\nAxcNavBar: \(bar)\nAxcDirection: \(direction)\nIndex: \(index)", level: .info)
    }
    /// 滑动透明度改变事件回调
    var axc_scrollClearBlock: AxcNavBarScrollClearBlock = { (bar,alpha) in
        AxcLog("[可选]未设置AxcNavBar的点击回调\nAxcNavBar: \(bar)\nAlpha: \(alpha)", level: .info)
    }
    
    // MARK: - 私有
    private var _leftWidth: CGFloat = 0
    private var _rightWidth: CGFloat = 0
    /// 更新bar的布局
    public override func reloadLayout() {
        // 内容视图
        contentView.axc.remakeConstraints { (make) in
            make.top.equalTo(Axc_statusHeight + axc_contentEdge.top)
            make.left.equalTo(axc_contentEdge.left)
            make.bottom.equalTo(-axc_contentEdge.bottom)
            make.right.equalTo(-axc_contentEdge.right)
        }
        // 左collection 计算宽度
        _leftWidth = collectionView(leftCollectionView, layout: leftItemLayout, insetForSectionAt: 0).left
        for idx in 0..<leftBarItems.count {
            let itemSize = collectionView(leftCollectionView, layout: leftItemLayout, sizeForItemAt: IndexPath(row: idx))
            _leftWidth += itemSize.width
        }
        leftCollectionView.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(_leftWidth)
        }
        // 右collection 计算宽度
        _rightWidth = collectionView(rightCollectionView, layout: leftItemLayout, insetForSectionAt: 0).right
        for idx in 0..<rightBarItems.count {
            let itemSize = collectionView(leftCollectionView, layout: leftItemLayout, sizeForItemAt: IndexPath(row: idx))
            _rightWidth += itemSize.width
        }
        rightCollectionView.axc.remakeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(_rightWidth)
        }
        // 标题视图
        titleView.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_titleContentEdge.top)
            make.bottom.equalTo(-axc_titleContentEdge.bottom)
            make.left.equalTo(leftCollectionView.axc.right).offset(axc_titleContentEdge.left)
            make.right.equalTo(rightCollectionView.axc.left).offset(-axc_titleContentEdge.right)
        }
        reloadStyleLayout()
    }
    
    // 刷新样式布局
    func reloadStyleLayout() {
        let _axc_style = axc_style
        axc_style = _axc_style
    }

    // MARK: - 懒加载
    // MARK: 样式控件
    lazy var titleLabel: AxcLabel = {
        let label = AxcLabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = AxcBadrock.shared.themeFillContentColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    lazy var titleButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = AxcBadrock.shared.backgroundColor
        button.axc_cornerRadius = 5
        button.axc_borderWidth = 0.5
        button.axc_borderColor = AxcBadrock.shared.lineColor
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.unTextColor
        button.titleLabel.axc_contentAlignment = .left
        return button
    }()
    lazy var titleTextField: AxcTextField = {
        let textField = AxcTextField()
        textField.backgroundColor = AxcBadrock.shared.backgroundColor
        textField.axc_cornerRadius = 5
        textField.axc_borderWidth = 0.5
        textField.axc_borderColor = AxcBadrock.shared.lineColor
        textField.axc_setPlaceholder(AxcBadrockLanguage("输入文本"), color: AxcBadrock.shared.unTextColor, font: UIFont.systemFont(ofSize: 12))
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
    /// 底层用于滑动变化的
    lazy var backgroundView: AxcBaseView = {
        let view = AxcBaseView()
        return view
    }()
}

// MARK: - 代理&数据源
extension AxcNavBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 点击事件
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isLeft = collectionView.tag - Axc_TagStar == 0
        let direction: AxcDirection = isLeft ? .left : .right
        axc_selectedBlock(self, direction, indexPath.row) // 回调Block
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
            cell.itemView = leftBarItems.axc_objAtIdx(indexPath.row)
        }else{  // 右item
            cell.itemView = rightBarItems.axc_objAtIdx(indexPath.row)
        }
        return cell
    }
    // item大小
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLeft = collectionView.tag - Axc_TagStar == 0
        let direction: AxcDirection = isLeft ? .left : .right
        let index = indexPath.row
        let width = axc_itemSizeBlock(self, direction, index)
        return CGSize((width,collectionView.axc_height))
    }
    // 组边距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let isLeft = collectionView.tag - Axc_TagStar == 0
        let direction: AxcDirection = isLeft ? .left : .right
        return axc_sectionInseteBlock(self, direction)
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
