//
//  AxcTableItemCell.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/4.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcTableItemCell {
    /// 样式
    enum Style {
        case `default`
    }
}

// MARK: - AxcTableItemCell
/// Axc高度自适应Item选择
@IBDesignable
public class AxcTableItemCell: AxcBaseTableCell {
    // MARK: - Api
    // MARK: UI属性
    // MARK: 其他属性
    var axc_tagList: [AxcTitleImageTuples] = [] { didSet { axc_reloadData() } }
    
    
    // MARK: 方法
    func axc_reloadData() {
        collectionView.reloadData()
    }
    // MARK: - 回调
    // MARK: Block回调
    // MARK: func回调
    // MARK: - 私有
    // MARK: 复用
    // MARK: - 子类实现
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    public override func config() {
        
    }
    /// 设置UI
    public override func makeUI() {
        
    }
    /// 刷新布局
    public override func reloadLayout() {
        
    }
    // MARK: 超类&抽象类
    // MARK: - 懒加载
    // MARK: 预设控件
    // MARK: 基础控件
    // MARK: 协议控件
    // MARK: 私有控件
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, layout: layout,
                                              delegate: self, dataSource: self,
                                              registers: [(class: AxcTableItemTagCell.self, useNib: false )])
        return collectionView
    }()
}

// MARK: - 代理&数据源
extension AxcTableItemCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // 数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return axc_tagList.count
    }
    // cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let original_cell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxcTableItemTagCell.axc_className , for: indexPath) as? AxcTableItemTagCell
        else { return original_cell }
        return cell
    }
    
    
}

public class AxcTableItemTagCell: AxcBaseCollectionCell {
    public override func makeUI() {
        axc_button.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
