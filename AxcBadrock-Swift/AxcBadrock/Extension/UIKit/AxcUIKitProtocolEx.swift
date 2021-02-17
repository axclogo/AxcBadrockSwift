//
//  AxcUIKitProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - UIKit公用协议
// MARK: Nib加载协议
/// Nib加载协议，遵循协议后，可以通过Class.axc_loadNib来进行加载
public protocol AxcNibLoadableProtocol {}
public extension AxcNibLoadableProtocol where Self : UIView {
    /// 通过Nib加载
    static func axc_loadNib(_ nibname: String? = nil, frame: CGRect? = nil) -> Self? {
        let loadName = nibname == nil ? "\(self)" : nibname!
        guard let nibObj = Axc_bundle.loadNibNamed(loadName, owner: nil, options: nil)?.first as? Self else { return nil }
        if let rect = frame { nibObj.frame = rect }
        return nibObj
    }
}

// MARK: ActionBlock协议
/// 添加触发Block协议
public protocol AxcActionBlockProtocol {}
public typealias AxcActionBlock = (Any?) -> Void
/// actionBlock的键
private var kaxc_actionBlock = "kaxc_actionBlock"
public extension AxcActionBlockProtocol {
    func axc_setActionBlock(_ block: @escaping AxcActionBlock ) {
        AxcRuntime.setAssociatedObj(self, &kaxc_actionBlock, block, .OBJC_ASSOCIATION_COPY)
    }
    func axc_getActionBlock() -> AxcActionBlock? {
        guard let block = AxcRuntime.getAssociatedObj(self, &kaxc_actionBlock) as? AxcActionBlock else { return nil }
        return block
    }
}

// MARK: 长按复制协议
/// 长按复制协议
public protocol AxcLongPressCopyProtocol {
    /// 遵循协议的类需要返回在点击复制后，复制的文本
    func axc_pasteboardStr(sender: Any? ) -> String?
}
private var kaxc_openLongPressCopy  = "kaxc_openLongPressCopy"
private var kaxc_longPressGesture   = "kaxc_longPressGesture"
public extension AxcLongPressCopyProtocol where Self : UIView {
    /// 是否开启长按复制功能
    var axc_openLongPressCopy: Bool {
        set {
            newValue ? addLongPressGesture() : removeLongPressGesture()
            AxcRuntime.setAssociatedObj(self, &kaxc_openLongPressCopy, newValue )
        }
        get {
            guard let open = AxcRuntime.getAssociatedObj(self, &kaxc_openLongPressCopy) as? Bool else {
                self.axc_openLongPressCopy = false  // 默认设置成false
                return false
            }
            return open
        }
    }
    // 长按手势的set&get
    private var _longPressGesture: UILongPressGestureRecognizer {
        set { AxcRuntime.setAssociatedObj(self, &kaxc_longPressGesture, newValue) }
        get {
            guard let longPressGesture = AxcRuntime.getAssociatedObj(self, &kaxc_longPressGesture) as? UILongPressGestureRecognizer else {
                // Runtime懒加载
                let lazyLong = UILongPressGestureRecognizer()
                self._longPressGesture = lazyLong   // set
                return lazyLong
            }
            return longPressGesture
        }
    }
    // 添加长按手势
    private func addLongPressGesture() {
        isUserInteractionEnabled = true
        removeLongPressGesture()    // 确保不重复添加
        axc_addGesture(_longPressGesture)
        _longPressGesture.axc_actionBlock =  { [weak self] (sender) in
            guard let weakSelf = self else { return }
            if sender == weakSelf._longPressGesture {
                if sender.state == .ended {
                    let alentController = UIAlertController(title: AxcBadrockLanguage("复制文本"),
                                                            actionTitles: [ AxcBadrockLanguage("复制") ]) { [weak self] (action) in
                        guard let weakSelf = self else { return }   // 通过协议接口回调拿到需要复制的文本
                        UIPasteboard.general.string = weakSelf.axc_pasteboardStr(sender: action)
                    }
                    alentController.axc_show()
                }
            }
        }
     
    }
    // 移除长按手势
    private func removeLongPressGesture() { // 移除
        removeGestureRecognizer(_longPressGesture)
    }
    
}

// MARK: tag标签协议
public protocol AxcTagsProtocol {}
private var kaxc_intTag     = "kaxc_intTag"
private var kaxc_floatTag   = "kaxc_floatTag"
private var kaxc_cgFloatTag = "kaxc_cgFloatTag"
private var kaxc_strTag     = "kaxc_strTag"
public  extension AxcTagsProtocol {
    /// 长整型Tag
    var axc_intTag: Int {
        get {
            guard let tag = AxcRuntime.getAssociatedObj(self, &kaxc_intTag) as? Int else {
                let _tag = 0
                AxcRuntime.setAssociatedObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setAssociatedObj(self, &kaxc_intTag, newValue) }
    }
    /// 浮点型Tag
    var axc_floatTag: Float {
        get {
            guard let tag = AxcRuntime.getAssociatedObj(self, &kaxc_floatTag) as? Float else {
                let _tag: Float = 0
                AxcRuntime.setAssociatedObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setAssociatedObj(self, &kaxc_floatTag, newValue) }
    }
    /// 浮点型Tag
    var axc_cgFloatTag: CGFloat {
        get {
            guard let tag = AxcRuntime.getAssociatedObj(self, &kaxc_cgFloatTag) as? CGFloat else {
                let _tag: CGFloat = 0
                AxcRuntime.setAssociatedObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setAssociatedObj(self, &kaxc_cgFloatTag, newValue) }
    }
    /// 字符串型Tag
    var axc_strTag: String {
        get {
            guard let tag = AxcRuntime.getAssociatedObj(self, &kaxc_strTag) as? String else {
                let _tag = ""
                AxcRuntime.setAssociatedObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setAssociatedObj(self, &kaxc_strTag, newValue) }
    }
}
