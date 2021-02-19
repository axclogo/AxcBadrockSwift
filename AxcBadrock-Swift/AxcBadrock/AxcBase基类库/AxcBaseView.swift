//
//  AxcBaseView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

@IBDesignable
public class AxcBaseView: UIView,
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
    deinit { AxcLog("View视图： \(self) 已销毁", level: .trace) }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    // MARK: - 子类实现方法
    /// 配置 执行于makeUI()之前
    public func config() { }
    /// 设置UI布局
    public func makeUI() { }
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    public func makeXmlInterfaceBuilder() { }
    
    // MARK: - 懒加载
    public lazy var axc_badgeLabel: AxcBadgeLabel = {
        return AxcBadgeLabel()
    }()
}

// MARK: - 功能性Api
// MARK: 徽标
public extension AxcBaseView {
    func axc_badgeDirection(_ direction: AxcDirection) {
        
    }
}
