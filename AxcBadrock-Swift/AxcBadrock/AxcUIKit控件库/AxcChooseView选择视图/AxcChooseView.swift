//
//  AxcChooseView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/2.
//

import UIKit

@IBDesignable
public class AxcChooseView: AxcBaseView {
    // MARK: - 初始化
    convenience init(_ title: String? = nil) {
        self.init()
        axc_title = title
    }
    // MARK: - 父类重写
    public override func config() {
        axc_width = Axc_screenWidth
        axc_height = Axc_screenHeight / 3 //默认屏高的1/3
    }
    public override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        addSubview(axc_titleView)
        axc_titleView.addSubview(axc_leftButton)
        axc_titleView.addSubview(axc_rightButton)
        axc_titleView.addSubview(axc_titleLabel)
    }
    public override func reloadLayout() {
        axc_titleView.axc.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(axc_titleViewHeight)
        }
        axc_leftButton.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(axc_actionButtonWidth)
        }
        axc_rightButton.axc.remakeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(axc_actionButtonWidth)
        }
        axc_titleLabel.axc.remakeConstraints { (make) in
            make.left.equalTo(axc_leftButton.axc.right)
            make.right.equalTo(axc_rightButton.axc.left)
            make.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Api
    /// 设置标题
    var axc_title: String? {
        set { axc_titleLabel.text = newValue }
        get { return axc_titleLabel.text }
    }
    
    /// 设置更新titleView的高度 默认30
    var axc_titleViewHeight: CGFloat = 30 { didSet { reloadLayout() } }
    
    /// 设置更新左右按钮的宽度 默认30
    var axc_actionButtonWidth: CGFloat = 40 { didSet { reloadLayout() } }
    
    // MARK: - 子类实现
    /// 左右按钮响应事件
    func btnAction(_ direction: AxcDirection, sender: AxcButton) { }
    
    // MARK: - 懒加载
    lazy var axc_leftButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.titleLabel.text = AxcBadrockLanguage("取消")
        button.axc_style = .text
        button.axc_contentInset = UIEdgeInsets.zero
        axc_rightButton.axc_addEvent { [weak self] (sender) in
            guard let weakSelf = self else { return }
            guard let _sender = sender as? AxcButton else { return }
            weakSelf.btnAction(.left, sender: _sender)
        }
        return button
    }()
    lazy var axc_rightButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.titleLabel.text = AxcBadrockLanguage("确定")
        button.axc_style = .text
        button.axc_contentInset = UIEdgeInsets.zero
        button.axc_addEvent { [weak self] (sender) in
            guard let weakSelf = self else { return }
            guard let _sender = sender as? AxcButton else { return }
            weakSelf.btnAction(.right, sender: _sender)
        }
        return button
    }()
    lazy var axc_titleLabel: AxcLabel = {
        let label = AxcLabel()
        label.textColor = AxcBadrock.shared.themeFillContentColor
        label.axc_contentInset = UIEdgeInsets.zero
        return label
    }()
    lazy var axc_titleView: AxcBaseView = {
        let view = AxcBaseView()
        view.axc_setGradient()
        return view
    }()
}
