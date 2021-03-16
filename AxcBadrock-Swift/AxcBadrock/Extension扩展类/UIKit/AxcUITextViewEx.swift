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

// MARK: - 通知监听
private var kaxc_textChangeBlock = "kaxc_textChangeBlock"
private var ktextDidChange = UITextView.textDidChangeNotification
public extension UITextView {
    typealias AxcUITextViewBlock = (UITextView) -> Void
    /// 文本发生变化的回调
    var axc_textChangeBlock: AxcUITextViewBlock? {
        set {
            AxcRuntime.setObj(self, &kaxc_textChangeBlock, newValue)
            axc_removeNotification(ktextDidChange) // 先移除
            axc_addNotification(ktextDidChange, selector: #selector(textChange)) // 后添加
        }
        get {
            guard let block = AxcRuntime.getObj(self, &kaxc_textChangeBlock) as? AxcUITextViewBlock else { return nil }
            return block
        }
    }
    /// 文本发生变化的触发
    @objc private func textChange() {
        axc_textChangeBlock?(self)
    }
    
    
    /// 视图即将被移除
    func axc_removeSelf() { // 保证移除
        axc_removeNotification(ktextDidChange)
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil { axc_removeSelf() } // 视图移除
    }
}

// MARK: - 决策判断
public extension UITextView {
}
