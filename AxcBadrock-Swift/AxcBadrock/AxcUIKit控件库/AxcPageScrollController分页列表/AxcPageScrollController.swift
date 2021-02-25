//
//  AxcPageScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

/// 数据源方法
public protocol AxcPageScrollControllerDataSource {
    /// 返回一个头部视图
//    func axc_headerView(pageScrollView: AxcPageScrollController) -> UIView
//    /// 返回分页视图高度 默认 screen-header-title
//    func axc_contentViewHeight(pageScrollView: AxcPageScrollController) -> CGFloat?
//    /// 返回listView
//    func axc_listView(pageScrollView: AxcPageScrollController) -> [AxcPageListViewDelegate]

}

@IBDesignable
public class AxcPageScrollController: AxcBaseVC {
    // MARK: - 初始化
    convenience init(_ vcs: [AxcPageItemVC]
//                     delegate: AxcPageScrollControllerDelegate,
//                     dataSource: AxcPageScrollControllerDataSource
    ) {
        self.init()
        axc_setPages(vcs)
//        axc_delegate = delegate
//        axc_dataSource = dataSource
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
//    weak var axc_delegate: AxcPageScrollControllerDelegate?
    /// 数据源
//    weak var axc_dataSource: AxcPageScrollControllerDataSource?

    // 吸顶临界点高度（默认值： 状态栏+导航栏）
    var ceilPointHeight: CGFloat = 0
    func reloadData() {
        mainTableView.reloadData()
    }
    // MARK: - 相关设置
    ///  设置Header
    func axc_setHeader(_ view: UIView? = nil, height: CGFloat) {
        if let headerView = view {
            let contentView = UIView()
            contentView.axc_height = height
            contentView.addSubview(headerView)
            headerView.axc.remakeConstraints { (make) in make.edges.equalTo(0) }
            mainTableView.tableHeaderView = headerView
        }
        let headerView = mainTableView.tableHeaderView
        headerView?.axc_height = height
        mainTableView.tableHeaderView = headerView
    }
    /// 设置Title
    func axc_setTitle(_ view: UIView? = nil, height: CGFloat) {
        pageView.axc_setTitle(view, height: height)
    }
    /// 设置页面组
    func axc_setPages(_ vcList: [AxcPageItemVC]) {
        pageView.axc_setPages( vcList )
        vcList.forEach{ // 设置关联性滑动
            $0.axc_didScrollBlock = { [weak self] (scorllView) in
                guard let weakSelf = self else { return }
                weakSelf.listScrollViewDidScroll(scrollView: scorllView)
            }
        }
    }
    
    // MARK: - 私有
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
        mainTableView.isScrollEnabled = false
    }
    // 滑动结束开启
    private func horizonScrollViewDidEndedScroll() {
        mainTableView.isScrollEnabled = true
    }
    
    // MARK: - 懒加载
    lazy var pageView: AxcPageScrollView = {
        let view = AxcPageScrollView()
        view.backgroundColor = UIColor.black
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
                    let criticalPoint = self.mainTableView.rect(forSection: 0).origin.y  //- self.ceilPointHeight
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
//        self.axc_delegate?.axc_mainTableViewDidScroll?(scrollView: scrollView, isMainCanScroll: self.isMainCanScroll)
    }
}

// MARK: - 页面横向滑动代理
extension AxcPageScrollController: AxcPageScrollViewDelegate {
    public func axc_PageScrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        horizonScrollViewWillBeginScroll()
    }
    public func axc_PageScrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        horizonScrollViewDidEndedScroll()
    }
    public func axc_PageScrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        horizonScrollViewDidEndedScroll()
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
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainScrollViewDidScroll(scrollView: scrollView)
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
            pageView.axc.remakeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
}
