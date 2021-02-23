//
//  AxcListEmptyView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

public extension AxcListEmptyView {
    enum Style {
        case general    // 一般样式
    }
}

@IBDesignable
public class AxcListEmptyView: AxcBaseView {
    public override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        addSubview(emptyImageView)
        addSubview(textLabel)
        addSubview(refreshBtn)
        
        reloadLayout()
    }
    
    // MARK: - Api
    /// 设置样式
    var style: AxcListEmptyView.Style = .general {
        didSet {
            switch style {
            case .general:   // 一般样式
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
    }
    
    
    // MARK: - 复用
    public override func reloadLayout() {
        let _style = style
        style = _style
    }
    
    
    // MARK: - 懒加载
    /// 刷新按钮
    lazy var refreshBtn: AxcButton = {
        let btn = AxcButton()
        btn.axc_cornerRadius = 5
        btn.axc_setGradient()  // 渐变
        btn.titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        btn.titleLabel.text = AxcBadrockLanguage("重新加载")
        btn.axc_style = .text   // 纯文字
        return btn
    }()
    /// 文字提示
    lazy var textLabel: AxcLabel = {
        let label = AxcLabel()
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
