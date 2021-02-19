//
//  AxcBadrockProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

// UIKit公用开放功能性协议

// MARK: - UIView协议
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

// MARK: 背景图
/// 通过layer层设置背景图
public protocol AxcBackgroundImageProtocol {}
public extension AxcBackgroundImageProtocol where Self : UIView {
    /// 设置背景图
    func axc_backgroundImage(_ image: UIImage) {
        layer.contents = image.cgImage
    }
}

// MARK: 渐变色
/// view底层渐变色接口
public protocol AxcGradientLayerProtocol {}
public extension AxcGradientLayerProtocol where Self : UIView {
    /// 获取渐变色Layer
    var axc_gradientLayer: CAGradientLayer? {
        guard let gradientLayer = layer as? CAGradientLayer else { return nil }
        return gradientLayer
    }
    /// 设置背景色渐变
    /// - Parameters:
    ///   - colors: 渐变色组 默认主题渐变
    ///   - startDirection: 开始点位，支持按位或运算
    ///   - endDirection: 结束点位，支持按位或运算
    ///   - locations: 比率
    ///   - type: type
    func axc_gradient(colors: [UIColor]? = nil,
                      startDirection: AxcDirection  = .left,
                      endDirection: AxcDirection    = .right,
                      locations: [CGFloat]? = nil,
                      type: CAGradientLayerType = .axial ) {
        backgroundColor = UIColor.clear // 清除背景色
        let _colors = colors ?? AxcBadrock.shared.themeGradientColors
        axc_gradientLayer?.colors = _colors.map(\.cgColor)
        axc_gradientLayer?.locations = locations?.map { NSNumber(value: Double($0)) }
        axc_gradientLayer?.startPoint = CAGradientLayer.axc_point(with: startDirection)
        axc_gradientLayer?.endPoint = CAGradientLayer.axc_point(with: endDirection)
        axc_gradientLayer?.type = type
    }
}

// MARK: 徽标
/// view添加徽标接口
public protocol AxcBadgeProtocol {}
private var kaxc_badgeLabel = "kaxc_badgeLabel"
public extension AxcBadgeProtocol where Self : UIView {
    /// 徽标label控件对象
    var axc_badgeLabel: AxcBadgeLabel {
        set { AxcRuntime.setAssociatedObj(self, &kaxc_badgeLabel, newValue) }
        get {   // runtime 懒加载
            guard let badgeLabel = AxcRuntime.getAssociatedObj(self, &kaxc_badgeLabel) as? AxcBadgeLabel else {
                let badge = AxcBadgeLabel()
                addSubview(badge) // 添加
                AxcRuntime.setAssociatedObj(self, &kaxc_badgeLabel, badge)
                return badge
            }
            bringSubviewToFront(badgeLabel) // 每次get放置到最前
            return badgeLabel
        }
    }
    /// 设置徽标方位
    /// - Parameter direction: 方位，支持按位或运算 默认右上
    func axc_badgeDirection(_ direction: AxcDirection = [.top, .right]) {
        addSubview(axc_badgeLabel)  // 确保能添加
        axc_badgeLabel.axc.remakeConstraints { (make) in
            // Y 轴
            if direction.contains(.top) { make.top.equalToSuperview() }         // 上
            if direction.contains(.center) { make.centerY.equalToSuperview() }  // 中
            if direction.contains(.bottom) { make.bottom.equalToSuperview() }   // 下
            if direction.contains(.top) && direction.contains(.bottom) {        // 上+下=中
                make.centerY.equalToSuperview()
            }
            // X 轴
            if direction.contains(.left) { make.left.equalToSuperview() }        // 左
            if direction.contains(.center) { make.centerX.equalToSuperview() }  // 中
            if direction.contains(.right) { make.right.equalToSuperview() }    // 右
            if direction.contains(.left) && direction.contains(.right) {        // 左+右=中
                make.centerX.equalToSuperview()
            }
            make.size.equalTo( axc_badgeLabel.axc_size )
        }
    }
    /// 设置徽标的值
    func axc_badgeValue(_ value: String = "0" ) {
        axc_badgeLabel.text = value
    }
    /// 设置徽标的富文本值
    func axc_badgeValue(_ attributedStr: NSAttributedString? = nil ) {
        axc_badgeLabel.attributedText = attributedStr
    }
    /// 设置徽标的背景色
    func axc_badgeColor(_ color: UIColor? = nil ) {
        let _color = color ?? AxcBadrock.shared.markedColor
        axc_badgeLabel.backgroundColor = _color
    }
    /// 设置徽标的渐变背景色
    func axc_badgeGradientColor(colors: [UIColor]? = nil,
                                startDirection: AxcDirection = .left, endDirection: AxcDirection = .right,
                                locations: [CGFloat]? = nil, type: CAGradientLayerType = .axial ){
        axc_badgeLabel.axc_gradient(colors: colors,
                                    startDirection: startDirection, endDirection: endDirection,
                                    locations: locations, type: type)
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
        get {   // runtime 懒加载
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
        get {   // runtime 懒加载
            guard let longPressGesture = AxcRuntime.getAssociatedObj(self, &kaxc_longPressGesture) as? UILongPressGestureRecognizer else {
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
