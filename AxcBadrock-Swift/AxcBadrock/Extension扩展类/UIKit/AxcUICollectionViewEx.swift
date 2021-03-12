//
//  AxcUICollectionViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 类方法/属性
public extension UICollectionView {
    /// 设置一个collectionView
    /// - Parameters:
    ///   - frame: frame
    ///   - layout: 布局
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    convenience init(frame: CGRect = CGRect.zero,
                     layout: UICollectionViewFlowLayout? = nil,
                     delegate: UICollectionViewDelegate? = nil,
                     dataSource: UICollectionViewDataSource? = nil,
                     registers: [AxcRegistersCollectionCellTuples] = []) {
        var flowLayout = UICollectionViewFlowLayout()
        if let _layout = layout { flowLayout = _layout }
        self.init(frame: frame, collectionViewLayout: flowLayout)
        self.delegate = delegate
        self.dataSource = dataSource
        backgroundColor = UIColor.clear
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delaysContentTouches = false    // 关闭按钮延时
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never // 就算超出了安全边距，系统不会对你的scrollView做任何事情，即不作任何调整
        }
        if registers.count > 0 { // 有设置注册cell
            axc_registerCells(registers)
        }else{  // 不设置默认注册系统
            let className = "UICollectionViewCell"
            register(AxcStringFromClass(className), forCellWithReuseIdentifier: className)
        }
    }
}

// MARK: - 属性 & Api
public extension UICollectionView {
    /// 注册一个cell
    func axc_registerCell(_ tuples: AxcRegistersCollectionCellTuples ) {
        let type = "\(tuples.0)"
        if tuples.1 {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil), forCellWithReuseIdentifier: type)
        }else{
            register(tuples.0, forCellWithReuseIdentifier: type)
        }
    }
    /// 注册一组cell
    func axc_registerCells(_ cells: [AxcRegistersCollectionCellTuples]) {
        for cell in cells { axc_registerCell(cell) }
    }
    
    /// 生成注册的Cell
    /// - Parameters:
    ///   - cell: cellClass
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func axc_dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        let identifier = cell.axc_className
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            AxcLog("获取注册的Cell失败！\nIdentifier:\(identifier)", level: .fatal)
            return T()
        }
        return cell
    }
}

// MARK: - 组动画协议
extension UICollectionView: AxcSubviewsAnimationProtocol {
    /// 返回所有需要动画的视图
    public func axc_animationViews(_ style: AxcAnimationManager.Style) -> [UIView] {
        return visibleCells
    }
}

// MARK: - 决策判断
public extension UICollectionView {
}
