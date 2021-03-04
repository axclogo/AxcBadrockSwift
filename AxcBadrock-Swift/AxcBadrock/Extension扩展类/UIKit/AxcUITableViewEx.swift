//
//  AxcUITableViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 类方法/属性
public extension UITableView {
    /// 快速实例化
    /// - Parameters:
    ///   - frame: frame
    ///   - style: 样式
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    convenience init(frame: CGRect = CGRect.zero,
                     style: UITableView.Style = .plain,
                     delegate: UITableViewDelegate? = nil,
                     dataSource: UITableViewDataSource? = nil,
                     registers: [AxcRegistersTableCellTuples] = []) {
        self.init(frame: frame, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        backgroundColor = UIColor.clear
        tableFooterView = UIView()
        estimatedRowHeight = 0;
        estimatedSectionHeaderHeight = 0;
        estimatedSectionFooterHeight = 0;
        separatorStyle = .none;   //让tableview不显示分割线
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never // 就算超出了安全边距，系统不会对你的scrollView做任何事情，即不作任何调整
        }
        if registers.count > 0 { // 有设置注册cell
            registerCells(registers)
        }else{  // 不设置默认注册系统
            let className = "UITableViewCell"
            register(AxcStringFromClass(className), forCellReuseIdentifier: className)
        }
    }
}

// MARK: - 属性 & Api
public extension UITableView {
    /// 设置头视图
    /// - Parameters:
    ///   - view: 视图
    ///   - height: 高度
    ///   - edge: 边距
    func axc_setTableHeaderView(_ view: UIView, height: CGFloat, edge: UIEdgeInsets = .zero) {
        let headerView = UIView(CGRect((0,0,axc_width,height)))
        headerView.addSubview(view)
        view.axc.makeConstraints { (make) in make.edges.equalTo(edge) }
        tableHeaderView = headerView
    }
    /// 设置尾视图
    /// - Parameters:
    ///   - view: 视图
    ///   - height: 高度
    ///   - edge: 边距
    func axc_setTableFooterView(_ view: UIView, height: CGFloat, edge: UIEdgeInsets = .zero) {
        let footerView = UIView(CGRect((0,0,axc_width,height)))
        footerView.addSubview(view)
        view.axc.makeConstraints { (make) in make.edges.equalTo(edge) }
        tableFooterView = footerView
    }
    
    /// 移除TableFooterView
    func axc_removeTableFooterView() {
        tableFooterView = nil
    }
    /// 刷新，重新赋值TableFooterView
    func axc_refreshTableFooterView() {
        let _tableFooterView = tableFooterView
        tableFooterView = _tableFooterView
    }

    /// 移除TableHeaderView
    func axc_removeTableHeaderView() {
        tableHeaderView = nil
    }
    /// 刷新，重新赋值TableHeaderView
    func axc_refreshTableHeaderView() {
        let _tableHeaderView = tableHeaderView
        tableHeaderView = _tableHeaderView
    }
    /// 注册一个cell
    func registerCell(_ tuples: AxcRegistersTableCellTuples ) {
        let type = "\(tuples.0)"
        if tuples.1 {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil), forCellReuseIdentifier: type)
        }else{
            register(tuples.0, forCellReuseIdentifier: type)
        }
    }
    /// 注册一组cell
    func registerCells(_ cells: [AxcRegistersTableCellTuples]) {
        for cell in cells { registerCell(cell) }
    }
}

// MARK: - 决策判断
public extension UITableView {
}

