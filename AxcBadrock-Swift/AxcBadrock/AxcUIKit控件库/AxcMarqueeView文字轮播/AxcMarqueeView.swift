//
//  AxcMarqueeView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit
// MARK: - 协议代理
@objc protocol AxcMarqueeViewDelegate {
    
}
@objc protocol AxcMarqueeViewDataSource {
    /// 设置需要轮播的内容个数
    /// - Parameter marqueeView: AxcMarqueeView
    func axc_numberWith(marqueeView: AxcMarqueeView) -> Int
    
    /// 设置需要返回的内容视图
    /// - Parameter marqueeView: AxcMarqueeView
    func axc_contentViewWith(marqueeView: AxcMarqueeView) -> UIView
    
}
// MARK: - 样式扩展带参枚举

@IBDesignable
public class AxcMarqueeView: AxcBaseView,
                             AxcLeftRightBtnProtocol {
    // MARK: - 初始化
    
    
    // MARK: - Api
    // MARK: UI属性
    // MARK: 其他属性
    /// 左按钮宽度
    var axc_leftBtnWidth: CGFloat = 0 { didSet { reloadLayout() } }
    /// 右按钮宽度
    var axc_rightBtnWidth: CGFloat = 0 { didSet { reloadLayout() } }

    
    // MARK: 方法
    func axc_start() {
        
    }
    // MARK: 回调
    
    
    // MARK: 私有
    private var contentViews: [AxcBaseView] = []

    
    // MARK: - 父类重写
    // MARK: 视图父类
    public override func makeUI() {
        addSubview(axc_leftButton)
        addSubview(axc_rightButton)
    }
    public override func reloadLayout() {
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
        return view
    }()
    // MARK: 协议控件
    public func axc_settingBtn(direction: AxcDirection) -> AxcButton {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.axc_titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.axc_titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.axc_contentInset = UIEdgeInsets.zero
        return button
    }
    
}
// MARK: - 代理&数据源
