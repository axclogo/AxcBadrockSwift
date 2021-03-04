//
//  AxcScrollTabView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/3.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcScrollTabView {
    
}

// MARK: - AxcScrollTabView
/// Axc滑动标签单选器
@IBDesignable
public class AxcScrollTabView: AxcBaseView {
    // MARK: - 初始化
    convenience init(_ dataList: [AxcTitleImageTuples],
                     selectedBlock: @escaping ((_ tabView: AxcScrollTabView,
                                                _ index: Int) -> Void)) {
        self.init()
        axc_tabList = dataList
        createSelecteds()
        axc_tabActionBlock = selectedBlock
    }
    // MARK: - Api
    // MARK: UI属性
    
    // MARK: 其他属性
    /// tab标签列表
    var axc_tabList: [AxcTitleImageTuples] = [] { didSet { createSelecteds() } }
    
    // MARK: 方法
    
    // MARK: - 回调
    // MARK: Block回调
    /// 选中回调
    var axc_tabActionBlock: ((_ tabView: AxcScrollTabView,
                              _ index: Int) -> Void)
        = { (tabView,index) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(tabView)\nIndex:\(index)", level: .action)
        }
    
    // MARK: - 私有
    private var selectedArray: [Bool] = []
    private func createSelecteds() {
        for idx in 0..<axc_tabList.count { selectedArray.append(!idx.axc_boolValue) }
    }
    // MARK: 复用
    
    // MARK: - 子类实现
    
    // MARK: - 父类重写
    // MARK: 视图父类
    public override func config() {
        
    }
    public override func makeUI() {
        
    }
    public override func reloadLayout() {
        
    }
    
    // MARK: 超类&抽象类
    
    // MARK: - 懒加载
    // MARK: 预设控件
    
    // MARK: 基础控件
    
    // MARK: 私有控件
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, layout: layout,
//                                              delegate: self, dataSource: self,
//                                              registers: [(class: AxcBaseCollectionCell.self, useNib: false )])
//
//        return collectionView
//    }()
}

// MARK: - 代理&数据源
//extension AxcScrollTabView: UICollectionViewDelegate, UICollectionViewDataSource {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    } 
//}
