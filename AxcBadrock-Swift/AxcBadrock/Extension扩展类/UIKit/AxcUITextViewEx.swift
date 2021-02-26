//
//  AxcUITextViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

// MARK: - 属性 & Api
public extension UITextView {
    /// 清除内容
    func axc_clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    /// 移除边界
    func axc_removeInset() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    /// 将大小与内容适配
    func axc_wrapContent() {
        axc_removeInset()
        contentOffset = .zero
        sizeToFit()
    }
}

// MARK: - 决策判断
public extension UITextView {
}
