//
//  AxcContentScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/8.
//

import UIKit

public class AxcContentScrollView: AxcBaseControl,
                                   AxcLeftRightBtnProtocol {
    // MARK: - 初始化
    
    
    // MARK: - Api
    // MARK: UI属性
    /// 起始点，结束点默认对应关系，
    var axc_startPoint: AxcDirection = .right
    /// 两个内容之间的间距
    var axc_contentSpacing: CGFloat = 20.0
    
    /// 内容边距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets.zero
    /// 左按钮宽度
    var axc_leftBtnWidth: CGFloat = 0 { didSet { reloadLayout() } }
    /// 右按钮宽度
    var axc_rightBtnWidth: CGFloat = 0 { didSet { reloadLayout() } }
    
    
    // MARK: 其他属性

    
    
    // MARK: 方法
    func axc_start() {
//        contentViews.
    }
    // MARK: 回调
    /// 返回需要滚动的内容数量
    var axc_contentOfNumberBlock: ((_ contentScrollView: AxcContentScrollView) -> Int)
        = { _ in return 1 }
    
    // MARK: 私有
    private var contentViews: [UIView] = []

    
    // MARK: - 父类重写
    // MARK: 视图父类
    public override func makeUI() {
        
    }
    public override func reloadLayout() {
        axc_contentView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
        axc_leftButton.axc.remakeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(axc_leftBtnWidth)
        }
        axc_rightButton.axc.remakeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(axc_rightBtnWidth)
        }
    }

    // MARK: - 懒加载
    // MARK: 基础控件
    /// 外部约束视图
    lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        addSubview(view)
        return view
    }()
    // MARK: 协议控件
    public func axc_settingBtn(direction: AxcDirection) -> AxcButton {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.axc_titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.axc_titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.axc_contentInset = UIEdgeInsets.zero
        axc_contentView.addSubview(axc_rightButton)
        return button
    }
    
}
