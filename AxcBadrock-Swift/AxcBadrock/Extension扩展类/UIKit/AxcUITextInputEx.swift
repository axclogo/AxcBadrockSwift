//
//  AxcUITextInputEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/16.
//

import UIKit

public extension UITextInput {
    /// 设置输入的最大长度
    /// - Parameters:
    ///   - length: 最大长度
    ///   - textChangeBlock: 文字变化回调
    ///   - reachMaxLengthBlock: 超出长度的回调
    func axc_setMaxLength(_ length: Int, textChangeBlock: AxcActionBlock? = nil, reachMaxLengthBlock: AxcStringBlock? = nil) {
        if let textField = self as? UITextField{
            textField.axc_textChangeBlock = { tf in
                guard let text = tf.text else { return }
                if text.count > length {
                    reachMaxLengthBlock?(text)
                    tf.text = text[axc_safe: 0..<length] // 截取前几位
                }
                textChangeBlock?(tf) // 文字变化回调
            }
        }else if let textView = self as? UITextView {
            textView.axc_textChangeBlock = { tv in
                guard let text = tv.text else { return }
                if text.count > length {
                    reachMaxLengthBlock?(text)
                    tv.text = text[axc_safe: 0..<length] // 截取前几位
                }
                textChangeBlock?(tv) // 文字变化回调
            }
        }
    }
}
