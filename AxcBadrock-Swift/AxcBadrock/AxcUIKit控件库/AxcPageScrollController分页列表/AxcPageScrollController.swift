//
//  AxcPageScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

// MARK: - 代理回调方法
/// 代理回调方法
@objc public protocol AxcPageScrollControllerDelegate {
    // MARK: 横向滑动
    /// page页面滑动的偏移
    /// - Parameters:
    ///   - pageScrollView: pageScrollView
    ///   - scrollView: 横向滑动的scrollview
    @objc optional func axc_pageViewPageScroll(pageScrollView: AxcPageScrollController, scrollView: UIScrollView)
    
    /// page页面滑动的偏移百分比
    /// - Parameters:
    ///   - pageScrollView: pageScrollView
    ///   - idxOffset: 偏移量 0 \ 1.333 ...
    @objc optional func axc_pageViewPageScrollIndex(pageScrollView: AxcPageScrollController, idxOffset: CGFloat)
    
    // MARK: 纵向滑动
    /// mainTableView开始滑动
    /// - Parameter scrollView: mainTableView
    @objc optional func axc_pageViewMainScrollWillBeginDragging(scrollView: UIScrollView)
    
    /// mainTableView滑动，用于实现导航栏渐变、头图缩放等
    /// - Parameters:
    ///   - pageScrollView: pageScrollView
    ///   - scrollView: mainTableView
    ///   - isMainCanScroll: 是否到达临界点，YES表示到达临界点，mainTableView不再滑动，NO表示我到达临界点，mainTableView仍可滑动
    @objc optional func axc_pageViewMainScrollDidScroll(pageScrollView: AxcPageScrollController, scrollView: UIScrollView, isMainCanScroll: Bool)
    
    /// mainTableView结束滑动
    /// - Parameters:
    ///   - scrollView: mainTableView
    ///   - willDecelerate: 是否将要减速
    @objc optional func axc_pageViewMainScrollDidEndDragging(scrollView: UIScrollView,willDecelerate: Bool)
    
    /// mainTableView结束滑动
    /// - Parameter scrollView: mainTableView
    @objc optional func axc_pageViewMainScrollDidEndDecelerating(scrollView: UIScrollView)
}

@IBDesignable
public class AxcPageScrollController: AxcBaseVC {
    // MARK: - 初始化
    convenience init(_ vcs: [AxcPageItemVC],
                     delegate: AxcPageScrollControllerDelegate) {
        self.init()
        axc_setPages(vcs)
        axc_delegate = delegate
        reloadData()
    }
    
    // MARK: - 父类重写
    public override func makeUI() {
        // 设置主tableView
        view.addSubview(mainTableView)
        mainTableView.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    
    // MARK: - Api
    /// 代理
    weak var axc_delegate: AxcPageScrollControllerDelegate?
    /// 刷新
    func reloadData() {
        mainTableView.reloadData()
    }
    // MARK: 相关设置
    ///  设置Header
    func axc_setHeader(_ view: UIView? = nil, height: CGFloat) {
        if let headerView = view {
            let contentView = UIView()
            contentView.axc_height = height
            contentView.addSubview(headerView)
            headerView.axc.remakeConstraints { (make) in make.edges.equalTo(0) }
            mainTableView.tableHeaderView = contentView
        }
        let headerView = mainTableView.tableHeaderView
        headerView?.axc_height = height
        mainTableView.tableHeaderView = headerView
    }
    /// 设置预设title
    func axc_setSegmentedControlTitle(_ titles: [AxcSegmentedTitleTuples], height: CGFloat) {
        isUsePresetTitle = true // 判定使用预设
        segmentedTitleControl.axc_titleList = titles
        pageView.axc_setTitle(segmentedTitleControl, height: height)
    }
    /// 设置自定义Title
    func axc_setTitle(_ view: UIView? = nil, height: CGFloat) {
        pageView.axc_setTitle(view, height: height)
    }
    /// 设置页面组
    func axc_setPages(_ vcList: [AxcPageItemVC]) {
        self.vcList = vcList
        pageView.axc_setPages( vcList )
        vcList.forEach{ // 设置关联性滑动
            addChild($0)    // 加入组
            $0.axc_didScrollBlock = { [weak self] (scorllView) in
                guard let weakSelf = self else { return }
                weakSelf.listScrollViewDidScroll(scrollView: scorllView)
            }
        }
    }
    /// 是否要支持纵横滑动 默认true
    var axc_horizonVerticalScroll = true
    
    
    // MARK: - 私有
    // 是否使用的预设title
    private var isUsePresetTitle : Bool = false
    // 视图组
    private var vcList: [AxcPageItemVC] = []
    // 是否滑到临界点
    private var isCriticalPoint : Bool = false
    // mainTableView 是否可以滑动
    private var isMainCanScroll : Bool = true
    // listScrollView 是否可以滑动
    private var isListCanScroll : Bool = false
    // 当前滑动的listView
    private var currentListView = UIScrollView()
    // 横向滑动触发关闭
    private func horizonScrollViewWillBeginScroll() {
        if !axc_horizonVerticalScroll { mainTableView.isScrollEnabled = false }
    }
    // 滑动结束开启
    private func horizonScrollViewDidEndedScroll() {
        if !axc_horizonVerticalScroll { mainTableView.isScrollEnabled = true }
    }
    
    // MARK: - 懒加载
    lazy var segmentedTitleControl: AxcSegmentedControl = {
        let segmentedControl = AxcSegmentedControl()
        segmentedControl.axc_cornerRadius = 0
        segmentedControl.axc_borderWidth = 0
        segmentedControl.axc_borderColor = nil
        // 关联滑动
        segmentedControl.axc_segmentedActionBlock = { [weak self] (segmented,index) in
            guard let weakSelf = self else { return }
            weakSelf.pageView.axc_selectedIdx(index, animated: false)
        }
        return segmentedControl
    }()
    lazy var pageView: AxcPageScrollView = {
        let view = AxcPageScrollView()
        view.backgroundColor = UIColor.clear
        view.axc_delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()
    lazy var mainTableView: AxcPageTableView = {
        let tableView = AxcPageTableView(delegate: self, dataSource: self,
                                         registers: [(class: AxcPageScrollCell.self, useNib: false )])
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = nil
        return tableView
    }()
    
}

// 需要实现手势穿透
class AxcPageTableView: UITableView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension AxcPageScrollController {
    // 次要子列表
    func listScrollViewDidScroll(scrollView: UIScrollView) {
        self.currentListView = scrollView
        let offsetY = scrollView.contentOffset.y // 获取listScrollView 的偏移量
        if offsetY <= 0 {   // listScrollView 下滑至offsetY 小于0，禁止其滑动，让mainTableView 可下滑
            self.isMainCanScroll = true
            self.isListCanScroll = false
            scrollView.contentOffset = .zero
            scrollView.showsVerticalScrollIndicator = false
        }else {
            if self.isListCanScroll {
                scrollView.showsVerticalScrollIndicator = false
                if self.mainTableView.contentOffset.y == 0 { // 如果此时mainTableView 并没有滑动，则禁止listView滑动
                    self.isMainCanScroll = true
                    self.isListCanScroll = false
                    scrollView.contentOffset = .zero
                    scrollView.showsHorizontalScrollIndicator = false
                }else{ // 矫正mainTableView 的位置
                    let criticalPoint = self.mainTableView.rect(forSection: 0).origin.y
                    self.mainTableView.contentOffset = CGPoint(x: 0, y: criticalPoint)
                }
            }else{
                scrollView.contentOffset = CGPoint.zero
            }
        }
    }
    // 主列表开始滑动
    func mainScrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y    // 获取mainScrollview 偏移量
        let criticalPoint = self.mainTableView.rect(forSection: 0).origin.y // 临界点
        self.isCriticalPoint = (offsetY >= criticalPoint) // 根据偏移量判断是否上滑到临界点
        if self.isCriticalPoint {   // 上滑到临界点后，固定其位置
            scrollView.contentOffset = CGPoint(x: 0, y: criticalPoint)
            self.isMainCanScroll = false
            self.isListCanScroll = true
        }else{      // 未到达临界点
            pageView.axc_getPages().forEach { (vc) in
                let listScrollView = vc.axc_listScrollView()
                if self.isMainCanScroll { // mainScrollview 可滑动，需要重置所有listScrollView 的位置
                    listScrollView.contentOffset = .zero
                    listScrollView.showsVerticalScrollIndicator = false
                }else{  // mainScrollview不可滑动
                    if listScrollView.contentOffset.y != 0 {
                        self.mainTableView.contentOffset = CGPoint(x: 0, y: criticalPoint)
                    }
                }
            }
        }
        self.axc_delegate?.axc_pageViewMainScrollDidScroll?(pageScrollView: self, scrollView: scrollView, isMainCanScroll: self.isMainCanScroll)
    }
}

// MARK: - 页面横向滑动代理
extension AxcPageScrollController: AxcPageScrollViewDelegate {
    public func axc_pageScrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        horizonScrollViewWillBeginScroll()
    }
    public func axc_pageScrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        horizonScrollViewDidEndedScroll()
    }
    public func axc_pageScrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        horizonScrollViewDidEndedScroll()
    }
    public func axc_pageScrollViewDidScroll(_ scrollView: UIScrollView) {
        axc_delegate?.axc_pageViewPageScroll?(pageScrollView: self, scrollView: scrollView)
        let idxOffset = scrollView.contentOffset.x / scrollView.axc_width
        axc_delegate?.axc_pageViewPageScrollIndex?(pageScrollView: self, idxOffset: idxOffset)
        if isUsePresetTitle { // 使用了预设title
            segmentedTitleControl.axc_selectedIdx = idxOffset.axc_intValue
        }
    }
}

// MARK: - 代理数据源
extension AxcPageScrollController: UITableViewDelegate, UITableViewDataSource {
    // MARK: tableView代理数据源
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let original_cell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AxcClassFromString(AxcPageScrollCell.self)) as? AxcPageScrollCell
        else { return original_cell }
        cell.pageView = pageView
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.axc_height
    }
    // MARK: 滑动代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainScrollViewDidScroll(scrollView: scrollView)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.axc_delegate?.axc_pageViewMainScrollWillBeginDragging?(scrollView: scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.axc_delegate?.axc_pageViewMainScrollDidEndDragging?(scrollView: scrollView, willDecelerate: decelerate)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.axc_delegate?.axc_pageViewMainScrollDidEndDecelerating?(scrollView: scrollView)
    }
}

private class AxcPageScrollCell: AxcBaseTableCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    // 内容视图
    var pageView: UIView? = nil {
        didSet {
            guard let pageView = pageView else { return }
            if !contentView.subviews.contains(pageView) { contentView.addSubview(pageView) }
            pageView.axc.remakeConstraints { (make) in make.edges.equalTo(0) }
        }
    }
}
