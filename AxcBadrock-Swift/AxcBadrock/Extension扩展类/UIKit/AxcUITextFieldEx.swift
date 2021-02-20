//
//  AxcUITextFieldEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// MARK: - 属性 & Api
public extension UITextField {
    /// 清空所有文本
    func axc_clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    /// 左边距
    func axc_leftSpacing(_ spacing: CGFloat) {
        axc_addIcon(isLeft: true, spacing: spacing)
    }
    /// 右边距
    func axc_rightSpacing(_ spacing: CGFloat) {
        axc_addIcon(isLeft: false, spacing: spacing)
    }
    
    /// 添加左右图片
    /// - Parameters:
    ///   - isLeft: 是否为左视图
    ///   - image: 图片
    ///   - imageSize: 图片大小
    ///   - spacing: 边距
    func axc_addIcon(isLeft: Bool = true,
                     image: UIImage? = nil,
                     imageSize: CGSize = CGSize.zero,
                     spacing: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width + spacing, height: imageSize.height))
        if let img = image {
            let imageView = UIImageView(image: img)
            imageView.frame = CGRect(x: isLeft ? spacing : 0, y: 0, width: imageSize.width, height: imageSize.height)
            imageView.contentMode = .center
            iconView.addSubview(imageView)
        }
        if isLeft {
            leftView = iconView
            leftViewMode = .always
        }else{
            rightView = iconView
            rightViewMode = .always
        }
    }
}

// MARK: - 样式
public enum AxcTextFieldStyle {
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
    var axc_style: AxcTextFieldStyle {
        get {
            guard let style = AxcRuntime.getObj(self, &kaxc_style) as? AxcTextFieldStyle else {
                let _style = AxcTextFieldStyle.generic
                AxcRuntime.setObj(self, &kaxc_style, _style)
                return _style
            }
            return style
        }
        set {
            autocorrectionType = .no        // 关闭自动校正
            autocapitalizationType = .none // 自动大写
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
extension UITextField: AxcActionBlockProtocol {
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
