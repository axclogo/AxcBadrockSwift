//
//  AxcNSAttributedStringEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit


// MARK: - 数据转换
public extension NSAttributedString {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension NSAttributedString {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
public extension NSAttributedString {
    /// 为这段富文本新增一种属性
    func axc_applying(attributes: [Key: Any], range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        let copy = NSMutableAttributedString(attributedString: self)
        var attRange = NSRange(0..<length)
        if let r = range { attRange = r }
        copy.addAttributes(attributes, range: attRange)
        return copy
    }
}

// MARK: - 链式调用富文本的各项属性
public extension NSAttributedString {
    /// 设置字体
    func axc_font(_ font: UIFont, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.font:font],range: range)
    }
    /// 设置段落样式
    func axc_paragraphStyle(_ paragraphStyle: NSParagraphStyle, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.paragraphStyle:paragraphStyle],range: range)
    }
    /// 字色
    func axc_textColor(_ color: UIColor, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.foregroundColor:color],range: range)
    }
    /// 背景色
    func axc_backgroundColor(_ color: UIColor, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.backgroundColor:color],range: range)
    }
    /// 连体字符 - 该属性所对应的值是一个 NSNumber 对象(整数)。连体字符是指某些连在一起的字符，它们采用单个的图元符号。
    /// 0 表示没有连体字符。1 表示使用默认的连体字符。2表示使用所有连体符号。默认值为 1（注意，iOS 不支持值为 2）。
    func axc_ligature(_ ligature: Bool, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.ligature:ligature.axc_number!],range: range)
    }
    /// 包含浮点值，修改默认的字距。0表示禁用字距调整。
    func axc_kern(_ kern: Float, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.kern:kern.axc_number!],range: range)
    }
    /// 包含浮点值，金额修改默认跟踪。0表示禁用跟踪。
    @available(iOS 14.0, *)
    func axc_tracking(_ tracking: Float, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.tracking:tracking.axc_number!],range: range)
    }
    /// 删除线 默认0:没有划线
    func axc_strikethroughStyle(_ strikethroughStyle: Bool, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.strikethroughStyle:strikethroughStyle.axc_number!],range: range)
    }
    /// 删除线颜色
    func axc_strikethroughColor(_ strikethroughColor: UIColor, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.strikethroughColor:strikethroughColor],range: range)
    }
    /// 下划线 默认0:没有划线
    func axc_underlineStyle(_ underlineStyle: Bool, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.underlineStyle:underlineStyle.axc_number!],range: range)
    }
    /// 下划线颜色
    func axc_underlineColor(_ underlineColor: UIColor, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.underlineColor:underlineColor],range: range)
    }
    /// 笔画宽度(粗细)，取值为整数，负值填充效果，正值中空效果
    func axc_strokeWidth(_ strokeWidth: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.strokeWidth:strokeWidth.axc_number!],range: range)
    }
    /// 填充部分颜色，不是字体颜色
    func axc_strokeColor(_ strokeColor: UIColor, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.strokeColor:strokeColor],range: range)
    }
    /// 设置阴影
    func axc_shadow(_ shadow: NSShadow, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.shadow:shadow],range: range)
    }
    /// 文字效果
    func axc_textEffect(_ textEffect: String, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.textEffect:textEffect],range: range)
    }
    /// 附件数据
    func axc_attachment(_ attachment: NSTextAttachment, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.attachment:attachment],range: range)
    }
    /// 设置链接url，点击后调用浏览器打开指定URL地址
    func axc_link(_ link: URL, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.link:link],range: range)
    }
    /// 设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
    func axc_baselineOffset(_ baselineOffset: Float, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.baselineOffset:baselineOffset.axc_number!],range: range)
    }
    /// 设置字体倾斜
    func axc_obliqueness(_ obliqueness: Float, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.obliqueness:obliqueness.axc_number!],range: range)
    }
    /// 要应用于符号的扩展因子的对数，默认0:不扩展
    func axc_expansion(_ expansion: Float, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.expansion:expansion.axc_number!],range: range)
    }
    /// 设置文字书写方向，从左向右书写或者从右向左书写
    ///
    ///     LRE: NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding,
    ///     RLE: NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding,
    ///     LRO: NSWritingDirectionLeftToRight | NSWritingDirectionOverride,
    ///     RLO: NSWritingDirectionRightToLeft | NSWritingDirectionOverride,
    func axc_writingDirection(_ writingDirection: Int, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.writingDirection:writingDirection.axc_number!],range: range)
    }
    /// 文字排版方向，true表示竖排，false表示横排
    func axc_verticalGlyphForm(_ verticalGlyphForm: Bool, range: NSRange? = nil) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        return axc_applying(attributes: [.verticalGlyphForm:verticalGlyphForm.axc_number!],range: range)
    }
}

// MARK: - 决策判断
public extension NSAttributedString {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension NSAttributedString {
}

// MARK: - 运算符
public extension NSAttributedString {
    /// 拼接NSAttributedString
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    /// 相加生成一个新的NSAttributedString
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
}
