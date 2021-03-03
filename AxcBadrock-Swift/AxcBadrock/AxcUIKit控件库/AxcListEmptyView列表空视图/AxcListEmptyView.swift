//
//  AxcListEmptyView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcListEmptyView {
    /// 占位样式
    enum Style {
        // 默认样式
        case `default`
    }
}

// MARK: - AxcListEmptyView
/// 空列表占位视图
@IBDesignable
public class AxcListEmptyView: AxcBaseView {
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    var axc_style: AxcListEmptyView.Style = .default { didSet { reloadLayout() } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 点击刷新回调
    var axc_refreshBtnActionBlock: ((_ listEmptyView: AxcListEmptyView ) -> Void)
        = { (view) in
        let className = AxcClassFromString(self)
        AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(view)", level: .action)
    }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    public override func config() {
        
    }
    /// 设置UI
    public override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        addSubview(emptyImageView)
        addSubview(textLabel)
        addSubview(refreshBtn)
        
        reloadLayout()
    }
    /// 刷新布局
    public override func reloadLayout() {
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle() {
        switch axc_style {
        case .default:   // 默认样式
            emptyImageView.axc.remakeConstraints { (make) in
                make.top.equalTo(100)
                make.width.equalToSuperview().dividedBy(2)
                make.height.equalTo(emptyImageView.axc.width)
                make.centerX.equalToSuperview()
            }
            textLabel.axc.remakeConstraints { (make) in
                make.top.equalTo(emptyImageView.axc.bottom).offset(10)
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.height.equalTo(30)
            }
            refreshBtn.axc.remakeConstraints { (make) in
                make.top.equalTo(textLabel.axc.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 120, height: 40))
            }
        }
    }
    
    // MARK: - 懒加载
    // MARK: 基础控件
    /// 刷新按钮
    lazy var refreshBtn: AxcButton = {
        let btn = AxcButton()
        btn.axc_cornerRadius = 5
        btn.axc_setGradient()  // 渐变
        btn.axc_titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        btn.axc_titleLabel.text = AxcBadrockLanguage("重新加载")
        btn.axc_style = .text   // 纯文字
        btn.axc_addEvent { [weak self] (_) in   // 触发事件
            guard let weakSelf = self else { return }
            weakSelf.axc_refreshBtnActionBlock(weakSelf)
        }
        return btn
    }()
    /// 文字提示
    lazy var textLabel: AxcBaseLabel = {
        let label = AxcBaseLabel()
        label.axc_contentAlignment = .top   // 上对齐
        label.text = AxcBadrockLanguage("暂时没有数据哦")
        return label
    }()
    /// 空数据图片
    lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AxcBadrockBundle.emptyDataImage.axc_tintColor(AxcBadrock.shared.themeColor)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
}
