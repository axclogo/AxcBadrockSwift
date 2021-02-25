//
//  AxcLabel.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// 设置文字时候会调用
public typealias AxcLabelDidSetTextBlock = (_ label: AxcLabel, _ text: String) -> Void

/// Axc封装的文字控件
@IBDesignable
public class AxcLabel: UILabel,
                       AxcBaseClassConfigProtocol,
                       AxcBaseClassMakeUIProtocol,
                       AxcGradientLayerProtocol {
    // MARK: - 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        makeUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func config() {
        font = UIFont.systemFont(ofSize: 14)
        textColor = AxcBadrock.shared.themeColor
        textAlignment = .center
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
    }
    public func makeUI() {
        
    }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    // 文本绘制
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let center = CGPoint(((axc_width  - textRect.width ) / 2,
                              (axc_height - textRect.height) / 2))
        var textPoint = center
        if axc_contentAlignment.contains(.top) { textPoint.y = axc_contentInset.top }
        if axc_contentAlignment.contains(.left) { textPoint.x = axc_contentInset.left }
        if axc_contentAlignment.contains(.bottom) { textPoint.y = axc_height - textRect.height - axc_contentInset.bottom }
        if axc_contentAlignment.contains(.right) { textPoint.x = axc_width - textRect.width - axc_contentInset.right }
        if axc_contentAlignment.contains(.center) { textPoint = center }
        textRect.origin = textPoint
        return textRect
    }
    public override func drawText(in rect: CGRect) {
        let newRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: newRect)
    }
    public override var text: String? {
        didSet {
            guard let _text = text else { return }
            axc_didSetTextBlock?(self, _text)
        }
    }
    
    // MARK: - Api
    /// 内容对齐方式
    var axc_contentAlignment: AxcDirection = .center { didSet { reloadLayout() } }
    /// 内容边距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(5) { didSet { reloadLayout() } }
    /// 刷新布局
    func reloadLayout() { setNeedsDisplay() }
    /// 设置文字回调的block
    var axc_didSetTextBlock: AxcLabelDidSetTextBlock?
    
}
