//
//  AxcSegmentedControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/23.
//

import UIKit

public typealias AxcSegmentedItemStyleBlock = (_ segmentedControl: AxcSegmentedControl, _ button: AxcButton, _ index: Int) -> AxcButton.Style
public typealias AxcSegmentedSelectedBlock = (_ segmentedControl: AxcSegmentedControl, _ index: Int) -> Void

public typealias AxcSegmentedTitleTuples = (title: String?, image: UIImage?)

public extension AxcSegmentedControl {
    enum Style {
        case general    // 普通一般
        case indicator  // 指示器
    }
}

@IBDesignable
public class AxcSegmentedControl: AxcBaseView {
    // MARK: - 初始化
    convenience init(_ dataList: [AxcSegmentedTitleTuples],
                     selectedBlock: @escaping AxcSegmentedSelectedBlock) {
        self.init()
        axc_titleList = dataList
        createSelecteds()
        axc_segmentedSelectedBlock = selectedBlock
    }
    // MARK: - 父类重写
    public override func config() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        axc_cornerRadius = 5
        axc_borderWidth = 0.5
        axc_borderColor = AxcBadrock.shared.lineColor
    }
    public override func makeUI() {
        addSubview(collectionView)
        collectionView.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        reloadLayout()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        reloadData(layout)
    }
    // MARK: - Api
    // MARK: UI
    var axc_style: AxcSegmentedControl.Style = .general {
        didSet {
            axc_indicator.isHidden = true
            switch axc_style {
            case .general:      // 普通一般
                break
            case .indicator:    // 指示器样式
                axc_indicator.isHidden = false
            }
        }
    }
    /// 数据源
    var axc_titleList: [AxcSegmentedTitleTuples] = [] { didSet { createSelecteds() } }
    /// 设置内容间距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            layout.sectionInset = axc_contentInset
            reloadData(layout)
        }
    }
    /// 设置item最小间距
    var axc_minSpacing: CGFloat = 0 {
        didSet {
            layout.minimumLineSpacing = axc_minSpacing
            reloadData(layout)
        }
    }
    /// 选中背景色
    var axc_selectedBackgroundColor: UIColor = AxcBadrock.shared.themeColor {
        didSet { reloadData() }
    }
    /// 未选中背景色
    var axc_nomalBackgroundColor: UIColor = UIColor.clear {
        didSet { reloadData() }
    }
    /// 选中字色
    var axc_selectedTextColor: UIColor = AxcBadrock.shared.themeFillContentColor {
        didSet { reloadData() }
    }
    /// 未选中字色
    var axc_nomalTextColor: UIColor = AxcBadrock.shared.themeColor {
        didSet { reloadData() }
    }
    /// 刷新数据
    func reloadData(_ layout: UICollectionViewFlowLayout? = nil) {
        if let _layout = layout {
            collectionView.setCollectionViewLayout(_layout, animated: true)
        }
        collectionView.reloadData()
    }
    /// 选中索引
    var axc_selectedIdx: Int = 0 {
        didSet {
            guard selectedArray.count > axc_selectedIdx else { return }
            for idx in 0..<selectedArray.count { selectedArray[idx] = false }
            selectedArray[axc_selectedIdx] = true
            reloadData()
        }
    }
    /// 刷新UI
    public override func reloadLayout() {
        let _axc_contentInset = axc_contentInset
        axc_contentInset = _axc_contentInset
        let _axc_minSpacing = axc_minSpacing
        axc_minSpacing = _axc_minSpacing
    }
    // MARK: 指示器
    /// 指示器距离底部距离
    var axc_indicatorBottomSpacing: CGFloat = 0
    /// 指示器宽度 默认item的1/3
    var axc_indicatorWidth: CGFloat? = nil {
        didSet {
            guard let width = axc_indicatorWidth else { return }
            axc_indicator.axc_width = width
        }
    }
    /// 指示器高度 默认 2
    var axc_indicatorHeight: CGFloat = 2 {
        didSet { axc_indicator.axc_height = axc_indicatorHeight }
    }
    /// 指示器圆角默认1
    var axc_indicatorCornerRadius: CGFloat = 1 {
        didSet { axc_indicator.axc_cornerRadius = axc_indicatorCornerRadius }
    }
    /// 设置指示器滑动的百分比
    var axc_indicatorRatio: CGFloat? = nil {
        didSet {
            guard let indicatorRatio = axc_indicatorRatio else { return }
            axc_indicator.axc_x = axc_width * indicatorRatio
        }
    }
    
    
    // MARK: - 回调
    /// 样式设置
    var axc_segmentedItemStyleBlock: AxcSegmentedItemStyleBlock = { (_,btn,_) in
        return .text
    }
    /// 回调
    var axc_segmentedSelectedBlock: AxcSegmentedSelectedBlock = { (segmented,index) in
        AxcLog("未设置AxcSegmentedControl的点击回调\nAxcSegmentedControl: \(segmented)\nIndex: \(index)", level: .info)
    }
    
    // MARK: - 私有
    private var selectedArray: [Bool] = []
    private func createSelecteds() {
        for idx in 0..<axc_titleList.count { selectedArray.append(!idx.axc_boolValue) }
    }
    // MARK: - 懒加载
    lazy var axc_indicator: AxcButton = {
        let button = AxcButton()
        button.isUserInteractionEnabled = false
        button.axc_style = .img
        button.axc_cornerRadius = axc_indicatorCornerRadius
        button.axc_contentInset = UIEdgeInsets.zero
        return button
    }()
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(layout: layout, delegate: self, dataSource: self,
                                              registers: [(class: AxcSegmentedItem.self, useNib: false )])
        collectionView.isScrollEnabled = false
        return collectionView
    }()
}

// MARK: - 代理&数据源
extension AxcSegmentedControl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 回调
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        axc_selectedIdx = indexPath.row
        axc_segmentedSelectedBlock(self, indexPath.row)
    }
    // item大小
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = axc_titleList.count.axc_cgFloatValue
        let width = (collectionView.axc_width - layout.sectionInset.axc_horizontal - (layout.minimumLineSpacing * (count-1))) / count
        let height = (collectionView.axc_height - layout.sectionInset.axc_verticality)
        return CGSize(( width , height ))
    }
    // 数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return axc_titleList.count
    }
    // cell样式
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let original_cell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxcClassFromString(AxcSegmentedItem.self), for: indexPath) as? AxcSegmentedItem
        else { return original_cell }
        let tuples = axc_titleList[indexPath.row]
        if let title = tuples.0 {
            cell.axc_button.titleLabel.text = title
        }
        if let image = tuples.1 {
            cell.axc_button.imageView.image = image
        }
        if let isSelected = selectedArray.axc_objAtIdx(indexPath.row) {
            cell.axc_button.backgroundColor = isSelected ? axc_selectedBackgroundColor : axc_nomalBackgroundColor
            cell.axc_button.titleLabel.textColor = isSelected ? axc_selectedTextColor : axc_nomalTextColor
        }
        cell.axc_button.axc_style = axc_segmentedItemStyleBlock(self, cell.axc_button, indexPath.row)
        return cell
    }
}

// MARK: - cell
private class AxcSegmentedItem: AxcBaseCollectionCell {
    public override func makeUI() {
        backgroundColor = UIColor.clear
        axc_button.isUserInteractionEnabled = false // 禁止响应
        axc_button.axc.makeConstraints { (make) in make.edges.equalTo(0) }
    }
}
