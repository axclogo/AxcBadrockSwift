//
//  AxcUIAlertControllerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit
import AudioToolbox

// MARK: - 类方法/属性
public extension UIAlertController {
    /// 快速创建一个弹窗
    /// - Parameters:
    ///   - title: 标题
    ///   - actionTitles: 触发按钮
    ///   - message: 消息
    ///   - style: 样式
    ///   - cancelTitle: 取消按钮标题
    ///   - tintColor: 渲染颜色
    ///   - actionBlock: 触发block 返回的sender。axc_intTag能知道点击的是哪个
    convenience init(title: String,
                     actionTitles: [String],
                     message: String? = nil,
                     style: UIAlertController.Style = .alert,
                     cancelTitle: String? = nil,
                     tintColor: UIColor? = nil,
                     actionBlock: AxcActionBlock? = nil ) {
        self.init(title: title, message: message, preferredStyle: style)
        if let color = tintColor { view.tintColor = color } // 颜色
        var tag = 0
        actionTitles.forEach{   // 遍历添加
            var action = axc_addAction(title: $0, style: .default, handler: actionBlock)
            action.axc_intTag = tag
            tag += 1
        }
        var _cancelTitle: String = AxcBadrockLanguage("取消") // 取消按钮
        if let title = cancelTitle { _cancelTitle = title }
        axc_addAction(title: _cancelTitle, style: .cancel)
    }
}

// MARK: - 属性 & Api
public extension UIAlertController {
    /// 通过windowPresent出来
    /// - Parameters:
    ///   - animated: 动画
    ///   - vibrate: 震动
    ///   - completion: 完成后的回调
    func axc_show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
        AxcAppWindow()?.rootViewController?.present(self, animated: animated, completion: completion)
        if vibrate {
            #if canImport(AudioToolbox)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            #endif
        }
    }
    
    /// 添加一个按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 样式
    ///   - isEnabled: 是否启用
    ///   - handler: 事件
    /// - Returns: action
    @discardableResult
    func axc_addAction( title: String,
                        style: UIAlertAction.Style = .default,
                        isEnabled: Bool = true,
                        handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }
    /// 添加一个文本框
    /// - Parameters:
    ///   - text: 文本
    ///   - placeholder: 占位
    ///   - attributedPlaceholder: 富文本占位
    ///   - target: 响应者
    ///   - event: 事件
    ///   - actionBlock: 触发回调
    func axc_addTextField( text: String? = nil,
                           placeholder: String? = nil,
                           attributedPlaceholder: NSAttributedString? = nil,
                           target: Any? = nil,
                           event: UIControl.Event = .editingChanged,
                           actionBlock: AxcActionBlock? = nil ) {
        addTextField { textField in
            textField.text = text
            textField.placeholder = placeholder
            textField.attributedPlaceholder = attributedPlaceholder
            if let target = target, let block = actionBlock {
                textField.axc_addTarget(target: target, event: event, actionBlock: block)
            }
        }
    }
}
