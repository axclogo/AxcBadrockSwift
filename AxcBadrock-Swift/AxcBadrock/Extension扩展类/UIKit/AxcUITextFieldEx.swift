//
//  AxcUITextFieldEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// MARK: - 属性 & Api
public extension UITextField {
    /// 设置占位文字
    func axc_setPlaceholder(_ placeholder: String, color: UIColor, font: UIFont) {
        attributedPlaceholder = placeholder.axc_attributedStr(color: color, font: font, isHtml: false)
    }
    /// 清空所有文本
    func axc_clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    /// 左边距
    func axc_leftSpacing(_ spacing: CGFloat) {
        axc_addView(direction: .left, spacing: spacing)
    }
    /// 右边距
    func axc_rightSpacing(_ spacing: CGFloat) {
        axc_addView(direction: .right, spacing: spacing)
    }
    
    /// 添加左右图片
    /// - Parameters:
    ///   - direction: 方位
    ///   - image: 图片
    ///   - imageSize: 图片大小
    ///   - spacing: 边距
    func axc_addImage(direction: AxcDirection = .left,
                      image: UIImage?,
                      imageTintColor: UIColor? = nil,
                      imageSize: CGSize? = nil,
                      spacing: CGFloat = 10) {
        var img = image
        var imgSize = CGSize.zero
        if let _imageSize = imageSize { // 是否需要缩放处理
            imgSize = _imageSize
            img = img?.axc_scale(size: _imageSize)
        }
        if let _imageTintColor = imageTintColor { // 是否需要渲染处理
            img = img?.axc_tintColor(_imageTintColor)
        }
        let imageView = UIImageView(image: img)
        axc_addView(direction: direction, view: imageView, viewSize: imgSize, spacing: spacing)
    }
    /// 添加左右视图
    /// - Parameters:
    ///   - direction: 方位
    ///   - view: 视图
    ///   - viewSize: 视图大小
    ///   - spacing: 边距
    func axc_addView(direction: AxcDirection = .left,
                     view: UIView? = nil,
                     viewSize: CGSize? = nil,
                     spacing: CGFloat = 0) {
        guard direction.selectType([.left, .right]) else { return } // 左右可选
        let isLeft = direction == .left
        var size = CGSize.zero
        if let _viewSize = viewSize { size = _viewSize }
        if size != CGSize.zero { // 有大小
            let tfView = AxcBaseView(frame: CGRect(x: 0, y: 0, width: size.width + spacing, height: size.height))
            tfView.isUserInteractionEnabled = false
            if let _view = view {
                _view.frame = CGRect(x: isLeft ? spacing : 0, y: 0, width: size.width, height: size.height)
                tfView.addSubview(_view)
            }
            if isLeft {
                leftView = tfView
                leftViewMode = .always
            }else{
                rightView = tfView
                rightViewMode = .always
            }
        }else{  // 没大小
            if isLeft {
                leftView = nil
                leftViewMode = .never
            }else{
                rightView = nil
                rightViewMode = .never
            }
        }
    }
}

// MARK: - 样式
/// 内容样式
public enum AxcTextFieldContentStyle {
    case number
    case phone
    case email
    case password
    case url
    case generic
}
private var kaxc_style  = "kaxc_style"
public extension UITextField {
    /// 添加样式状态
    var axc_style: AxcTextFieldContentStyle {
        get {
            guard let style = AxcRuntime.getObj(self, &kaxc_style) as? AxcTextFieldContentStyle else {
                let _style = AxcTextFieldContentStyle.generic
                AxcRuntime.setObj(self, &kaxc_style, _style)
                return _style
            }
            return style
        }
        set {
            autocorrectionType = .no        // 关闭自动校正
            autocapitalizationType = .none // 自动大写
            clearButtonMode = .whileEditing // 删除按钮
            switch newValue {
            case .number:
                keyboardType = .numbersAndPunctuation
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入数字")
            case .phone:
                keyboardType = .phonePad
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入手机号")
            case .email:
                keyboardType = .emailAddress
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入邮箱")
            case .password:
                keyboardType = .asciiCapable
                isSecureTextEntry = true
                placeholder = AxcBadrockLanguage("请输入密码")
            case .url:
                keyboardType = .URL
                isSecureTextEntry = false
                placeholder = AxcBadrockLanguage("请输入地址")
            case .generic:
                isSecureTextEntry = false
            }
            AxcRuntime.setObj(self, &kaxc_style, newValue)
        }
    }
}

// MARK: - Xib属性扩展
public extension UITextField {
    /// 左视图的渲染颜色
    @IBInspectable var axc_leftImageTintColor: UIColor? {
        get { guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView, let tintColor = newValue else { return }
            iconView.axc_tintColor(tintColor)
        }
    }
    /// 右视图的渲染颜色
    @IBInspectable var axc_rightImageTintColor: UIColor? {
        get { guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set { guard let iconView = rightView as? UIImageView , let tintColor = newValue else { return }
            iconView.axc_tintColor(tintColor)
        }
    }
}

// MARK: - 响应回调
extension UITextField {
    /// 添加响应者
    /// - Parameters:
    ///   - target: 响应者
    ///   - event: 响应类型
    ///   - actionBlock: actionBlock
    /// - Returns: UITextField
    @discardableResult
    public func axc_addTarget(target: Any? = nil,
                              event: UIControl.Event = .editingChanged,
                              actionBlock: @escaping AxcActionBlock ) -> UITextField {
        axc_setActionBlock(actionBlock)
        addTarget(target, action: #selector(eventAction), for: event)
        return self
    }
    // 转block方法
    @objc private func eventAction(_ sender: Any?) {
        guard let block = axc_getActionBlock() else { return }
        block(sender)
    }
}

// MARK: - 决策判断
public extension UITextField {
    /// 字符是否为空
    var axc_isEmpty: Bool { return text?.isEmpty == true }
}
