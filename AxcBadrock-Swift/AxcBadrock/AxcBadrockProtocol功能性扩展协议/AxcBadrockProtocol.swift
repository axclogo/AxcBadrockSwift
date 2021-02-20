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
        set { AxcRuntime.setObj(self, &kaxc_badgeLabel, newValue) }
        get {   // runtime 懒加载
            guard let badgeLabel = AxcRuntime.getObj(self, &kaxc_badgeLabel) as? AxcBadgeLabel else {
                let badge = AxcBadgeLabel()
                self.axc_badgeLabel = badge // set
                addSubview(badge)
                return badge
            }
            bringSubviewToFront(badgeLabel) // 每次get放置到最前
            return badgeLabel
        }
    }
    /// 设置徽标方位
    /// - Parameter direction: 方位，支持按位或运算 默认右上
    func axc_badgeDirection(_ direction: AxcDirection = [.top, .right]) {
        axc_badgeLabel.axc_direction = direction
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

// MARK: 边框线
/// view添加边框线
public protocol AxcBorderLineProtocol {}
private var kaxc_borderLineViews = "kaxc_underLineViews"
public extension AxcBorderLineProtocol where Self : UIView {
    /// 边框线视图组
    /// 0 上，1左，2下，3右
    private var axc_borderLineViews: [UIView] {
        set { AxcRuntime.setObj(self, &kaxc_borderLineViews, newValue) }
        get {   // runtime 懒加载
            guard let borderLine = AxcRuntime.getObj(self, &kaxc_borderLineViews) as? [UIView] else {
                var _borderLine: [UIView] = []
                for idx in 0..<4 {
                    let view = UIView()
                    view.backgroundColor = AxcBadrock.shared.lineColor // 线色
                    view.tag = idx + Axc_TagStar
                    view.isHidden = true    // 默认隐藏
                    addSubview(view)
                    switch idx {
                    case 0: view.axc.makeConstraints { (make) in // 上
                        make.top.left.right.equalToSuperview()
                        make.height.equalTo(1)}
                    case 1: view.axc.makeConstraints { (make) in // 左
                        make.top.left.bottom.equalToSuperview()
                        make.width.equalTo(1)}
                    case 2: view.axc.makeConstraints { (make) in // 下
                        make.left.bottom.right.equalToSuperview()
                        make.height.equalTo(1)}
                    case 3: view.axc.makeConstraints { (make) in // 右
                        make.top.bottom.right.equalToSuperview()
                        make.width.equalTo(1)}
                    default: break}
                    _borderLine.append(view)
                }
                self.axc_borderLineViews = _borderLine // set
                return _borderLine
            }
            return borderLine
        }
    }
    /// 设置边框线
    /// - Parameter direction: 方位，默认全部，支持按位或运算
    func axc_borderLineDirection(_ direction: AxcDirection = [.bottom]) {
        for idx in 0..<axc_borderLineViews.count {
            let currentView = axc_borderLineViews[idx]
            currentView.isHidden = true // 先默认隐藏，再根据多选的显示
            if (idx == 0) && (direction.contains(.top))    { currentView.isHidden = false } // 要显示上
            if (idx == 1) && (direction.contains(.left))   { currentView.isHidden = false } // 要显示左
            if (idx == 2) && (direction.contains(.bottom)) { currentView.isHidden = false } // 要显示下
            if (idx == 3) && (direction.contains(.right))  { currentView.isHidden = false } // 要显示右
        }
    }
    /// 设置边框线的线宽
    /// - Parameters:
    ///   - width: 线宽
    ///   - direction: 方位，默认全部，支持按位或运算
    func axc_borderLineWidth(_ width: CGFloat, direction: AxcDirection? = nil) {
        for idx in 0..<axc_borderLineViews.count {
            let currentView = axc_borderLineViews[idx]
            currentView.axc.updateConstraints { (make) in // 更新约束
                if let _direction = direction { // 选择方位进行设置
                    if (idx == 0) && (_direction.contains(.top)) ||
                        (idx == 2) && (_direction.contains(.bottom)) {
                        make.height.equalTo(width)
                    }
                    if (idx == 1) && (_direction.contains(.left)) ||
                        (idx == 3) && (_direction.contains(.right)) {
                        make.width.equalTo(width)
                    }
                }else{ // 默认全部
                    let currentTag = currentView.tag - Axc_TagStar
                    if (currentTag == 0) || (currentTag == 2) {
                        make.height.equalTo(width)
                    }
                    if (currentTag == 1) || (currentTag == 3) {
                        make.width.equalTo(width)
                    }
                }
            }
        }
    }
    /// 设置线色
    /// - Parameters:
    ///   - color: 线色
    ///   - direction: 方位，默认全部，支持按位或运算
    func axc_borderLineColor(_ color: UIColor, direction: AxcDirection? = nil) {
        for idx in 0..<axc_borderLineViews.count {
            let currentView = axc_borderLineViews[idx]
            if let _direction = direction { // 选择方位进行设置
                if (idx == 0) && (_direction.contains(.top))    { currentView.backgroundColor = color } // 要设置上
                if (idx == 1) && (_direction.contains(.left))   { currentView.backgroundColor = color } // 要设置左
                if (idx == 2) && (_direction.contains(.bottom)) { currentView.backgroundColor = color } // 要设置下
                if (idx == 3) && (_direction.contains(.right))  { currentView.backgroundColor = color } // 要设置右
            }else{ // 默认全部
                currentView.backgroundColor = color
            }
        }
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
        AxcRuntime.setObj(self, &kaxc_actionBlock, block, .OBJC_ASSOCIATION_COPY)
    }
    func axc_getActionBlock() -> AxcActionBlock? {
        guard let block = AxcRuntime.getObj(self, &kaxc_actionBlock) as? AxcActionBlock else { return nil }
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
            AxcRuntime.setObj(self, &kaxc_openLongPressCopy, newValue )
        }
        get {   // runtime 懒加载
            guard let open = AxcRuntime.getObj(self, &kaxc_openLongPressCopy) as? Bool else {
                self.axc_openLongPressCopy = false  // 默认设置成false
                return false
            }
            return open
        }
    }
    // 长按手势的set&get
    private var _longPressGesture: UILongPressGestureRecognizer {
        set { AxcRuntime.setObj(self, &kaxc_longPressGesture, newValue) }
        get {   // runtime 懒加载
            guard let longPressGesture = AxcRuntime.getObj(self, &kaxc_longPressGesture) as? UILongPressGestureRecognizer else {
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
            guard let tag = AxcRuntime.getObj(self, &kaxc_intTag) as? Int else {
                let _tag = 0
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_intTag, newValue) }
    }
    /// 浮点型Tag
    var axc_floatTag: Float {
        get {
            guard let tag = AxcRuntime.getObj(self, &kaxc_floatTag) as? Float else {
                let _tag: Float = 0
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_floatTag, newValue) }
    }
    /// 浮点型Tag
    var axc_cgFloatTag: CGFloat {
        get {
            guard let tag = AxcRuntime.getObj(self, &kaxc_cgFloatTag) as? CGFloat else {
                let _tag: CGFloat = 0
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_cgFloatTag, newValue) }
    }
    /// 字符串型Tag
    var axc_strTag: String {
        get {
            guard let tag = AxcRuntime.getObj(self, &kaxc_strTag) as? String else {
                let _tag = ""
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_strTag, newValue) }
    }
}
