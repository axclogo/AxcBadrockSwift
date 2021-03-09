//
//  AxcBannerView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/9.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcContentBannerView {
    /// 轮播样式
    enum Style {
        /// 默认样式
        case `default`
    }
}

// MARK: - AxcBannerView
/// Axc内容轮播器
@IBDesignable
public class AxcContentBannerView: AxcBaseView {
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    var axc_style: AxcContentBannerView.Style = .default { didSet { reloadStyle() } }
    /// 内容边距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(0) { didSet { reloadLayout() } }
    /// Item的边距
    var axc_itemInset: UIEdgeInsets = UIEdgeInsets(5) {
        didSet { defaultLayout.sectionInset = axc_itemInset
            axc_reloadData()
        }
    }
    
    // MARK: 其他属性
    /// 自动滚动间隔时间,默认3s
    var axc_interval: CGFloat = 3
    /// 是否无限循环,默认true
    var axc_infiniteLoop: Bool = true { didSet { axc_reloadData() } }
    /// 是否自动滚动,默认true
    var axc_autoScroll: Bool = true
    /// 滚动方向，默认为水平滚动
    var axc_scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet { defaultLayout.scrollDirection = axc_scrollDirection
            axc_reloadData()
        }
    }
    
    // MARK: 方法
    /// 手动控制滚动到哪一个Index
    func axc_scrollTo(index: Int, animate: Bool) {
        if axc_autoScroll { axc_stop() }    // 暂停计时器
        guard totalItemsCount != 0 else { return }
        let scrollIdx = (totalItemsCount.axc_floatValue * 0.5 + index.axc_floatValue).axc_intValue
        scrollTo(index: scrollIdx, animate: animate)
        if axc_autoScroll { axc_start() }    // 开启计时器
    }
    /// 可以解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法
    func axc_adjustWhenVCWillAppear() {
        let targetIndex = currentIdx
        if targetIndex < totalItemsCount {
            collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: false)
        }
    }
    /// 开始轮播
    func axc_start() {
        axc_stop()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(running), userInfo: nil, repeats: true)
    }
    /// 停止轮播
    func axc_stop() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 设置布局
    func axc_setLayout(_ layout: UICollectionViewFlowLayout, _ animate: Bool = false) {
        self.defaultLayout = layout
        collectionView.setCollectionViewLayout(layout, animated: animate)
    }
    
    /// 刷新数据
    func axc_reloadData() {
        axc_stop() // 先停止
        let count = axc_contentBannerNumberBlock(self)
        totalItemsCount = axc_infiniteLoop ? count * 100 : count // 是否无限循环
        if count > 1 { // 由于 !=1 包含count == 0等情况
            collectionView.isScrollEnabled = true
            let _axc_autoScroll = axc_autoScroll
            axc_autoScroll = _axc_autoScroll
        }else{
            collectionView.isScrollEnabled = false
            axc_stop()
        }
        collectionView.setCollectionViewLayout(collectionView.collectionViewLayout, animated: false)
        collectionView.reloadData()
    }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 返回需要滚动的内容数量
    var axc_contentBannerNumberBlock: ((_ bannerView: AxcContentBannerView) -> Int)
        = { _ in return 1 }
    /// 返回需要滚动的内容视图
    var axc_contentBannerViewBlock: ((_ bannerView: AxcContentBannerView, _ index: Int) -> UIView)?
    
    // MARK: func回调
    // MARK: - 私有
    private var totalItemsCount: Int = 0
    /// 计时器
    private var timer: Timer?
    /// 滚动动画
    private var position: UICollectionView.ScrollPosition {
        return (axc_scrollDirection == .horizontal) ? .centeredHorizontally : .centeredVertically
    }
    /// 当前索引
    private var currentIdx: Int {
        guard !collectionView.axc_size.axc_isZero else { return 0 }
        var index = 0
        let itemSize = defaultLayout.itemSize
        if axc_scrollDirection == .horizontal {
            index = ((collectionView.contentOffset.x + itemSize.width * 0.5) / itemSize.width).axc_intValue
        }else{
            index = ((collectionView.contentOffset.y + itemSize.height * 0.5) / itemSize.height).axc_intValue
        }
        return max(0, index) // 不得低于0
    }
    /// 轮播跑起来
    @objc private func running() {
        guard totalItemsCount != 0 else { return }
        let targetIndex = self.currentIdx + 1
        scrollTo(index: targetIndex, animate: true)
    }
    /// 控制滚动到哪一个Index
    private func scrollTo(index: Int, animate: Bool) {
        if index >= totalItemsCount {
            if axc_infiniteLoop { // 开启无限
                let targetIndex = index.axc_cgFloatValue * 0.5
                collectionView.scrollToItem(at: IndexPath.init(item: targetIndex.axc_intValue, section: 0),
                                            at: position, animated: false)
            }
        }else{
            collectionView.scrollToItem(at: IndexPath.init(item: index, section: 0),
                                        at: position, animated: animate)
        }
    }
    private func pageControlIndexWithCurrentCellIndex(index: Int) -> Int{
        return index % axc_contentBannerNumberBlock(self)
    }
    // MARK: 复用
    // MARK: - 子类实现
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    public override func config() {
        super.config()
        axc_setLayout(defaultLayout)
        
    }
    /// 设置UI
    public override func makeUI() {
        super.makeUI()
        backgroundColor = AxcBadrock.shared.backgroundColor
        
        reloadLayout()
    }
    /// 刷新布局
    public override func reloadLayout() {
        super.reloadLayout()
        collectionView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
        
        reloadStyle()
    }
    /// 刷新样式
    func reloadStyle() {
        
    }
    
    // MARK: 超类&抽象类
    public override func layoutSubviews() {
        super.layoutSubviews()
        if collectionView.contentOffset.x == 0 && totalItemsCount > 0 {
            var targetIndex = 0
            if axc_infiniteLoop {
                targetIndex = (totalItemsCount.axc_floatValue * 0.5).axc_intValue
            }else{
                targetIndex = 0
            }
            collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: false)
        }
    }
    /// 解决当父View释放时，当前视图因为被计时器强引用而不能释放的问题
    public override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil { axc_stop() }   // 为空则为移除视图 停止计时器
        super.willMove(toSuperview: newSuperview)
    }
    
    // MARK: - 懒加载
    // MARK: 私有控件
    private lazy var defaultLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        layout.sectionInset = axc_itemInset
        layout.scrollDirection = axc_scrollDirection
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(delegate: self, dataSource: self,
                                              registers: [(class: AxcContentBannerCell.self, useNib: false)])
        collectionView.isPagingEnabled = true // 分页
        collectionView.scrollsToTop = false
        addSubview(collectionView)
        return collectionView
    }()
}

// MARK: - 代理&数据源
extension AxcContentBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let count = axc_contentBannerNumberBlock(self)
        guard count > 0 else { return }
        let itemIdx = currentIdx
        // 分页组件
    }
    // 结束滑动
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(collectionView)
    }
    // 结束拖动
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if axc_autoScroll { axc_start() } // 开启计时器
    }
    // 开始拖动
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if axc_autoScroll { axc_stop() } // 暂停计时器
    }
    // 滑动中
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let count = axc_contentBannerNumberBlock(self)
        guard count > 0 else { return }
        let itemIdx = currentIdx
        // 分页组件
//        let index
    }
    // 大小
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return collectionView.axc_size }
        let width = collectionView.axc_width - layout.sectionInset.axc_horizontal
        let height = collectionView.axc_height - layout.sectionInset.axc_verticality
        return CGSize((width,height))
    }
    // 数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    // cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let original_cell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxcContentBannerCell.axc_className, for: indexPath)
        as? AxcContentBannerCell
        else { return original_cell }
        if indexPath.row < axc_contentBannerNumberBlock(self) {
            if let view = axc_contentBannerViewBlock?(self, indexPath.row) {
                cell.configContentView(view)
            }
        }else{
            if let view = axc_contentBannerViewBlock?(self, 0) {
                cell.configContentView(view)
            }
        }
        return cell
    }
}

// MARK: - 匿名类
private class AxcContentBannerCell: AxcBaseCollectionCell {
    /// 配置内容视图展示
    func configContentView(_ view: UIView) {
        contentView.axc_removeAllSubviews() // 移除所有
        contentView.addSubview(view)
        view.axc.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
