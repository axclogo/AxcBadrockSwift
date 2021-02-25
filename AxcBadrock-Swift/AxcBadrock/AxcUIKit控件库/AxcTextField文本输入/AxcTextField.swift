//
//  AxcTextField.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/22.
//

import UIKit

public extension AxcTextField{
    enum Style {
        case general        // 一般样式
        case leftTitle      // 左标题样式
        case search         // 搜索样式
        case actionPrefix   // 可触发前缀
        case verifyCode     // 验证码
        case password       // 密码
    }
}

public class AxcTextField: AxcBaseView {
    public override func config() {
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = AxcBadrock.shared.textColor
        textField.clearButtonMode = .whileEditing // 删除按钮
        backgroundColor = AxcBadrock.shared.backgroundColor
        axc_cornerRadius = 5
        axc_borderWidth = 0.5
        axc_borderColor = AxcBadrock.shared.lineColor
    }
    public override func makeUI() {
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(textField)
        
        reloadLayout()
    }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    // MARK: - Api
    /// 内容布局样式
    var axc_style: AxcTextField.Style = .general {
        didSet {
            // 获取文字按钮的宽度
            func getBtnTextWidth(_ btn: AxcButton) -> CGFloat{
                var btnSpacing = btn.titleLabel.axc_estimatedWidth() + btn.axc_contentInset.axc_horizontal;
                btnSpacing += (btn.titleLabel.axc_contentInset.axc_horizontal)
                return btnSpacing
            }
            // 获取图片按钮的宽度
            func getBtnImgWidth(_ btn: AxcButton) -> CGFloat{
                return btn.axc_imgSize + btn.axc_contentInset.axc_horizontal;
            }
            // 重置按钮状态
            func resetBtnState(_ btn: AxcButton){
                btn.axc_contentInset = UIEdgeInsets(axc_lrSpacing)
                btn.axc_style = .img
                btn.axc_setBorderLineHidden()
                btn.titleLabel.axc_contentAlignment = .center
            }
            // 预先还原所有按钮状态
            textField.isSecureTextEntry = false
            textField.axc_leftSpacing(0)
            textField.axc_rightSpacing(0)
            resetBtnState(leftButton)
            axc_setViewWidth(.left, width: axc_lrSpacing*2)
            resetBtnState(rightButton)
            axc_setViewWidth(.right, width: axc_lrSpacing*2)

            switch axc_style {
            case .general:  // 一般
                break
                
            case .leftTitle:    // 左标题
                leftButton.axc_style = .text                                // 布局样式
                axc_setViewWidth(.left, width: getBtnTextWidth(leftButton)) // 约束宽度
                
            case .search:       // 搜索样式
                leftButton.axc_style = .img                                 // 布局样式
                leftButton.axc_imgSize = axc_height/3                       // 图片大小
                axc_setViewWidth(.left, width: getBtnImgWidth(leftButton))  // 约束宽度
                // UI
                leftButton.imageView.image = AxcBadrockBundle.magnifyingGlassImage
                
            case .actionPrefix:    // 触发前缀
                leftButton.axc_style = .textLeft_imgRight       // 布局样式
                leftButton.axc_imgSize = 10                     // 图片大小
                leftButton.axc_contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: axc_lrSpacing)
                var textWidth = getBtnTextWidth(leftButton)
                textWidth += leftButton.axc_imgSize
                axc_setViewWidth(.left, width: textWidth)       // 约束宽度
                // UI
                leftButton.imageView.image = AxcBadrockBundle.arrowBottomImage
                leftButton.titleLabel.axc_contentAlignment = .left
                leftButton.axc_setBorderLineDirection(.right)
                leftButton.axc_setBorderLineWidth(0.5)
                leftButton.axc_setBorderLineEdge(.right, edge: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
                
            case .verifyCode:    // 验证码
                rightButton.axc_style = .text                                   // 布局样式
                leftButton.axc_contentInset = UIEdgeInsets.zero
                axc_setViewWidth(.right, width: getBtnTextWidth(rightButton))   // 约束宽度
                // UI
                rightButton.titleLabel.textColor = AxcBadrock.shared.themeColor
                rightButton.axc_setBorderLineDirection(.left)
                rightButton.axc_setBorderLineWidth(0.5)
                rightButton.axc_setBorderLineEdge(.left, edge: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
                rightButton.axc_addEvent { (_sender) in
                    guard let sender = _sender as? AxcButton else { return }
                    let title = sender.titleLabel.text       // 记录原先的文字
                    let color = sender.titleLabel.textColor  // 记录原先颜色
                    sender.titleLabel.textColor = AxcBadrock.shared.unTextColor
                    sender.isUserInteractionEnabled = false // 禁止触发
                    sender.axc_startCountdown(duration: 10, format: AxcBadrockLanguage("重新获取(%d)") ) { (_sende) in
                        guard let sende = _sende as? AxcButton else { return }
                        sende.titleLabel.text = title        // 还原原先的文字
                        sende.titleLabel.textColor = color   // 还原原先颜色
                        sende.isUserInteractionEnabled = true // 恢复触发
                    }
                }
                
            case .password:    // 密码
                rightButton.axc_style = .img                                    // 布局样式
                rightButton.axc_imgSize = axc_height/3                          // 图片大小
                axc_setViewWidth(.right, width: getBtnImgWidth(rightButton))    // 约束宽度
                // UI
                textField.isSecureTextEntry = true
                rightButton.imageView.image = AxcBadrockBundle.eyesCloseImage
                rightButton.axc_addEvent { [weak self] (_) in
                    guard let weakSelf = self else { return }
                    weakSelf.textField.isSecureTextEntry = !weakSelf.textField.isSecureTextEntry
                    weakSelf.rightButton.imageView.image = weakSelf.textField.isSecureTextEntry ? AxcBadrockBundle.eyesCloseImage : AxcBadrockBundle.eyesOpenImage
                }
            }
        }
    }
    
    
    /// 设置内容边距
    var axc_contentEdge: UIEdgeInsets = .zero { didSet { reloadLayout() } }
    
    /// 设置左右视图的间距 默认5
    var axc_lrSpacing: CGFloat = 5{ didSet { reloadLayout() } }
    
    /// 设置左右视图的宽度
    /// - Parameters:
    ///   - direction: 方位
    ///   - width: 宽度
    func axc_setViewWidth(_ direction: AxcDirection, width: CGFloat) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let isLeft = direction == .left
        (isLeft ? leftButton : rightButton).axc.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }

    // MARK: 移接 Api
    @IBInspectable var axc_text: String? {
        set { textField.text = newValue }
        get { return textField.text }
    }
    @IBInspectable var axc_attributedText: NSAttributedString? {
        set { textField.attributedText = newValue }
        get { return textField.attributedText }
    }
    @IBInspectable var axc_textColor: UIColor? {
        set { textField.textColor = newValue }
        get { return textField.textColor }
    }
    @IBInspectable var axc_font: UIFont? {
        set { textField.font = newValue }
        get { return textField.font }
    }
    @IBInspectable var axc_textAlignment: NSTextAlignment {
        set { textField.textAlignment = newValue }
        get { return textField.textAlignment }
    }
    @IBInspectable var axc_borderStyle: UITextField.BorderStyle {
        set { textField.borderStyle = newValue }
        get { return textField.borderStyle }
    }
    func axc_setPlaceholder(_ placeholder: String, color: UIColor, font: UIFont) {
        textField.axc_setPlaceholder(placeholder, color: color, font: font)
    }
    
    // MARK: - 复用
    public override func reloadLayout() {
        leftButton.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_contentEdge.top)
            make.left.equalTo(axc_contentEdge.left)
            make.bottom.equalTo(-axc_contentEdge.bottom)
            make.width.equalTo(5)
        }
        rightButton.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_contentEdge.top)
            make.right.equalTo(-axc_contentEdge.right)
            make.bottom.equalTo(-axc_contentEdge.bottom)
            make.width.equalTo(5)
        }
        textField.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_contentEdge.top)
            make.bottom.equalTo(-axc_contentEdge.bottom)
            make.left.equalTo(leftButton.axc.right).offset(5)
            make.right.equalTo(rightButton.axc.left).offset(5)
        }
    }

    // MARK: - 懒加载
    // MARK: 基础控件
    /// 左视图
    lazy var leftButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.unTextColor
        return button
    }()
    /// 右视图
    lazy var rightButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.unTextColor
        return button
    }()
    lazy var textField: UITextField = {
        return UITextField()
    }()
}
