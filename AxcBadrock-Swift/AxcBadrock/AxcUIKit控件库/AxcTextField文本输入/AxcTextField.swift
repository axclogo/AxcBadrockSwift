//
//  AxcTextField.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/22.
//

import UIKit

public extension AxcTextField{
    enum Style {
        case general            // 一般样式
        case actionPrefix       // 可触发前缀
        case verifyCode         // 验证码
    }
}

public class AxcTextField: AxcBaseView {
    public override func config() {
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = AxcBadrock.shared.themeColor
        textField.clearButtonMode = .whileEditing // 删除按钮
        backgroundColor = AxcBadrock.shared.backgroundColor
        axc_cornerRadius = 5
        axc_borderColor = AxcBadrock.shared.lineColor
        axc_borderWidth = 0.5
    }
    public override func makeUI() {
        addSubview(leftView)
        addSubview(rightView)
        addSubview(textField)
        
        reloadLayout()
    }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    // MARK: - Api
    /// 设置内容边距
    var axc_contentEdge: UIEdgeInsets = .zero {
        didSet { reloadLayout() }
    }
    /// 设置左右视图的宽度
    /// - Parameters:
    ///   - direction: 方位
    ///   - width: 宽度
    func axc_setView(_ direction: AxcDirection, width: CGFloat) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let isLeft = direction == .left
        (isLeft ? leftView : rightView).axc.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }

    // MARK: 移接 Api
    var axc_text: String? {
        set { textField.text = newValue }
        get { return textField.text }
    }
    var axc_attributedText: NSAttributedString? {
        set { textField.attributedText = newValue }
        get { return textField.attributedText }
    }
    var axc_textColor: UIColor? {
        set { textField.textColor = newValue }
        get { return textField.textColor }
    }
    var axc_font: UIFont? {
        set { textField.font = newValue }
        get { return textField.font }
    }
    var axc_textAlignment: NSTextAlignment {
        set { textField.textAlignment = newValue }
        get { return textField.textAlignment }
    }
    var axc_borderStyle: UITextField.BorderStyle {
        set { textField.borderStyle = newValue }
        get { return textField.borderStyle }
    }
    func axc_setPlaceholder(_ placeholder: String, color: UIColor, font: UIFont) {
        textField.axc_setPlaceholder(placeholder, color: color, font: font)
    }
    
    // MARK: - 复用
    public override func reloadLayout() {
        leftView.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(10)
        }
        rightView.axc.remakeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(10)
        }
        textField.axc.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(leftView.axc.right)
            make.right.equalTo(rightView.axc.right)
        }
    }

    // MARK: - 懒加载
    /// 左视图
    lazy var leftView: AxcBaseView = {
        let view = AxcBaseView()
        return view
    }()
    /// 右视图
    lazy var rightView: AxcBaseView = {
        let view = AxcBaseView()
        return view
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
}
