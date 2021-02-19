//
//  AxcUILabel.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import UIKit

// MARK: - 数据转换
public extension UILabel {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension UILabel {
    /// 实例化文字和字体样式
    /// - Parameters:
    ///   - text: 字符串
    ///   - style: 字体样式
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init()
        font = UIFont.preferredFont(forTextStyle: style)
        self.text = text
    }
    /// 实例化字体样式
    /// - Parameters:
    ///   - font: font
    ///   - color: color
    ///   - alignment: alignment
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }
}

// MARK: - 属性 & Api
extension UILabel: AxcLongPressCopyProtocol {
    // MARK: 协议
    /// 获取允许复制到剪贴板的字符串
    public func axc_pasteboardStr(sender: Any? ) -> String? {
        return self.text
    }
    
    // MARK: 扩展
    /// label的高度适应
    public var axc_requiredHeight: CGFloat {
        return axc_required()
    }
    /// label的宽度适应
    public var axc_requiredwidth: CGFloat {
        return axc_required( false )
    }
    /// label的高度或者宽度适应
    public func axc_required(_ isHeight: Bool = true) -> CGFloat {
        var rect = CGRect(x: 0, y: 0, width: axc_width, height: axc_height)
        if isHeight { rect.axc_height = Axc_floatMax }
        else { rect.axc_width = Axc_floatMax }
        let label = UILabel(frame: rect)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return isHeight ? label.axc_height : label.axc_width
    }
    
    /// 估算大小
    public func axc_estimatedSize(width : CGFloat = CGFloat.axc_max,
                                  height: CGFloat = CGFloat.axc_max ) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    /// 估算height
    public func axc_estimatedHeight() -> CGFloat {
        return axc_estimatedSize(width: axc_width).height
    }
    /// 估算width
    public func axc_estimatedWidth() -> CGFloat {
        return axc_estimatedSize(height: axc_height).width
    }
}

// MARK: - 决策判断
public extension UILabel {
    /// 字符是否为空
    var axc_isEmpty: Bool { return text?.isEmpty == true }
}
