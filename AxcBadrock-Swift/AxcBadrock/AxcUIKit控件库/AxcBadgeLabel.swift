//
//  AxcBadgeswift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

public class AxcBadgeLabel: UILabel,
                            AxcBaseClassConfigProtocol,
                            AxcBaseClassMakeXibProtocol,
                            AxcGradientLayerProtocol {
    // MARK: - 初始化
    public override init(frame: CGRect) { super.init(frame: frame)
        config()
        makeUI()
    }
    public required init?(coder: NSCoder) { super.init(coder: coder)
        config()
        makeUI()
    }
    // Xib显示前
    public override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    deinit { AxcLog("AxcBadgeLabel： \(self) 已销毁", level: .trace) }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    // 每当需要布局时
    public override func layoutSubviews() {
        super.layoutSubviews()
        axc_cornerRadius = axc_size.axc_smallerValue / 2
    }
    // 属性被改变时，自适应
    public override var text: String? {
        didSet { super.text = text; axc_autoSize() }
    }
    public override var font: UIFont! {
        didSet { super.font = font; axc_autoSize() }
    }
    public override var attributedText: NSAttributedString? {
        didSet { super.attributedText = attributedText; axc_autoSize() }
    }
    public override var numberOfLines: Int {
        didSet { super.numberOfLines = numberOfLines; axc_autoSize() }
    }
    
    // MARK: - 复用
    // 计算大小
    func axc_autoSize() {
        sizeToFit()
        var spacing = font.pointSize
        if spacing < 10 { spacing = 10 } // 边距最少10pt
        self.axc_width += spacing
    }
    
    // MARK: - 设置
    // 配置 执行于makeUI()之前
    public func config() {
        textAlignment = .center
        backgroundColor = AxcBadrock.shared.markedColor
        textColor = UIColor.white
        font = UIFont.systemFont(ofSize: 10)
    }
    
    // 设置UI布局
    public func makeUI() {
        
    }
    // Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    public func makeXmlInterfaceBuilder() {
        
    }


}
