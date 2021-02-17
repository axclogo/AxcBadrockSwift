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
public protocol AxcNibLoadable {}
public extension AxcNibLoadable where Self : UIView {
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
public protocol AxcActionSelectorToBlock {}
public typealias AxcActionBlock = (Any?) -> Void
/// actionBlock的键
private var kaxc_actionBlock = "kaxc_actionBlock"
public extension AxcActionSelectorToBlock {
    /// 触发的Block
//    var axc_actionBlock: AxcActionBlock? {
//        set { AxcRuntime.setAssociatedObj(self, &kaxc_actionBlock, newValue, .OBJC_ASSOCIATION_COPY) }
//        get { guard let block = AxcRuntime.getAssociatedObj(self, &kaxc_actionBlock) as? AxcActionBlock else { return nil }
//            return block }
//    }
    func axc_setActionBlock(_ block: @escaping AxcActionBlock ) {
//        axc_actionBlock = block
    }
}

// MARK: 长按复制协议
/// 长按复制协议
public protocol AxcLongPressCopy {}
private var kaxc_openLongPressCopy  = "kaxc_openLongPressCopy"
private var kaxc_longPressGesture   = "kaxc_longPressGesture"
public extension AxcLongPressCopy where Self : UIView {
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
    
    private var _longPressGesture: UILongPressGestureRecognizer {
        set {
            AxcRuntime.setAssociatedObj(self, &kaxc_longPressGesture, newValue)
        }
        get {
            guard let longPressGesture = AxcRuntime.getAssociatedObj(self, &kaxc_longPressGesture) as? UILongPressGestureRecognizer else {
                // Runtime懒加载
                let lazyLong = UILongPressGestureRecognizer { [weak self] (sender) in
                    guard let weakSelf = self else { return }
                    if sender == weakSelf._longPressGesture {
                        weakSelf.becomeFirstResponder()
                        let item = UIMenuItem(title: AxcBadrockLanguage("复制"), action: #selector(weakSelf.longPressGestureAction))
                        let menuController = UIMenuController.shared
                        menuController.menuItems = [item]
                        guard let superView = weakSelf.superview else { return }
                        menuController.showMenu(from: superView , rect: weakSelf.frame)
                    }
                }
                self._longPressGesture = lazyLong
            }
            return longPressGesture
        }
    }
    
    @objc private func longPressGestureAction() {
        
    }
    
    private func addLongPressGesture() {
        isUserInteractionEnabled = true
        removeLongPressGesture()    // 确保不重复添加
        
    }
    
    private func removeLongPressGesture() {
        
    }
    
}
