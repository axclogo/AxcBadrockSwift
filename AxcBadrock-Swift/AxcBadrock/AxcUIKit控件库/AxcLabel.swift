//
//  AxcLabel.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

/// Axc封装的文字控件
public class AxcLabel: UILabel, AxcBaseClassMakeUIProtocol {
    // MARK: - 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func makeUI() {
        isUserInteractionEnabled = false
        font = UIFont.systemFont(ofSize: 14)
        textColor = AxcBadrock.shared.themeColor
        textAlignment = .center
    }
    
    // MARK: - 父类重写
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let center = CGPoint(((axc_width  - textRect.width ) / 2,
                              (axc_height - textRect.height) / 2))
        var textPoint = center
        if contentAlignment.contains(.top) { textPoint.y = contentInset.top }
        if contentAlignment.contains(.left) { textPoint.x = contentInset.left }
        if contentAlignment.contains(.bottom) { textPoint.y = axc_height - textRect.height - contentInset.bottom }
        if contentAlignment.contains(.right) { textPoint.x = axc_width - textRect.width - contentInset.right }
        if contentAlignment.contains(.center) { textPoint = center }
        textRect.origin = textPoint
        return textRect
    }
    public override func drawText(in rect: CGRect) {
        let newRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: newRect)
    }
    
    
    // MARK: - Api
    /// 内容对齐方式
    var contentAlignment: AxcDirection = .center { didSet { setNeedsDisplay() } }
    /// 内容边距
    var contentInset: UIEdgeInsets = UIEdgeInsets(5) { didSet { setNeedsDisplay() } }
}
