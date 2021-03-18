//
//  AxcUIButtonEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/18.
//

import UIKit

// MARK: - 类方法/属性
public extension UIButton {
    /// 初始化
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    convenience init(title: String? = nil, image: UIImage? = nil) {
        self.init()
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
    }
}

// MARK: - 属性 & Api
private var kaxc_style = "kaxc_style"
public extension UIButton {
    /// 内容边距
    var axc_contentInset: UIEdgeInsets {
        set { contentEdgeInsets = newValue }
        get { return contentEdgeInsets }
    }
    /// 按钮样式
    var axc_style: AxcButtonStyle {
        set {
            AxcRuntime.setObj(self, &kaxc_style, newValue)
            reloadStyle()
        }
        get {
            guard let style = AxcRuntime.getObj(self, &kaxc_style) as? AxcButtonStyle else {
                let style = AxcButtonStyle.imgLeft_textRight
                self.axc_style = style
                return style
            }
            return style
        }
    }
    
    #warning("此api不够完善，禁用")
    /// 按钮样式布局
    private func reloadStyle() {
        guard let axc_imageView = imageView else { return }
        guard let axc_titleLabel = titleLabel else { return }
        // 设置展示样式
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let titleSize = currentAttributedTitle?.size() ?? CGSize.zero
        let spacing: CGFloat = 0
        
        axc_imageView.isHidden = false
        axc_titleLabel.isHidden = false
        switch axc_style {
        case .imgTop_textBottom:    // 图上文下
            titleEdgeInsets = UIEdgeInsets(top: (imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: -imageRect.width/2, bottom: spacing / 2 + titleSize.height, right: -imageRect.width/2)
        
        case .textTop_imgBottom:    // 文上图下
            titleEdgeInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: spacing / 2 + titleSize.height, left: -imageRect.width/2, bottom: 0, right: -imageRect.width/2)
        
        case .imgLeft_textRight:    // 图左文右
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        
        case .textLeft_imgRight:    // 文左图右
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.width * 2), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        
        case .img:  // 全图片
            break
        
        case .text: // 全文字
        break
        }
    }
    
}

// MARK: - 【对象特性扩展区】
public extension UIButton {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension UIButton {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension UIButton {
}

// MARK: - 运算符
public extension UIButton {
}
