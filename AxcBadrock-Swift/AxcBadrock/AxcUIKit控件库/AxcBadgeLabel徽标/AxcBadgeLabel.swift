//
//  AxcBadgeswift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

/// Axc封装的徽标控件
@IBDesignable
public class AxcBadgeLabel: AxcLabel {
    // 每当需要布局时
    public override func layoutSubviews() {
        super.layoutSubviews()
        axc_cornerRadius = axc_size.axc_smallerValue / 2
    }
    // 属性被改变时，自适应
    public override var text: String? {
        didSet { super.text = text; autoSize() }
    }
    public override var font: UIFont! {
        didSet { super.font = font; autoSize() }
    }
    public override var attributedText: NSAttributedString? {
        didSet { super.attributedText = attributedText; autoSize() }
    }
    public override var numberOfLines: Int {
        didSet { super.numberOfLines = numberOfLines; autoSize() }
    }
    
    // MARK: - 复用
    // 计算大小
    func autoSize() {
        sizeToFit()
        var spacing = font.pointSize
        if spacing < 10 { spacing = 10 } // 边距最少10pt
        axc_width += spacing
        // 执行一次set
        let _direction = direction
        self.direction = _direction
    }
    /// 设置徽标位置
    var direction: AxcDirection = [.top, .right] {
        didSet{
            guard superview != nil else { return }
            self.axc.remakeConstraints { (make) in
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
                make.size.equalTo( axc_size )
            }
        }
    }
    
    // MARK: - 设置
    // 配置 执行于makeUI()之前
    public override func config() {
        super.config()  // 执行父类的配置
        textColor = AxcBadrock.shared.themeFillTextColor
        font = UIFont.systemFont(ofSize: 10)
        axc_setGradient()
    }
    
    // 设置UI布局
    public override func makeUI() {
        
    }
    // Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    public func makeXmlInterfaceBuilder() {
        
    }
}
