//
//  AxcBaseView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseView
/// 基类View视图
@IBDesignable
public class AxcBaseView: UIView,
                          AxcBaseClassConfigProtocol,
                          AxcBaseClassMakeXibProtocol,
                          AxcGradientLayerProtocol,
                          AxcLayoutSubviewProtocol {
    // MARK: - 初始化
    public override init(frame: CGRect) { super.init(frame: frame)
        config()
        makeUI()
    }
    public required init?(coder: NSCoder) { super.init(coder: coder)
        config()
        makeUI()
    }
    public override func awakeFromNib() { super.awakeFromNib()
        config()
        makeUI()
    }
    // MARK: - Api
    // MARK: Block回调
    /// 当view设置BackgroundColor前会调用
    public var axc_willSetBackgroundColorBlock: ((_ view: UIView, _ backgroundColor: UIColor?) -> Void)?
    /// 当view设置BackgroundColor后会调用
    public var axc_didSetBackgroundColorBlock: ((_ view: UIView, _ backgroundColor: UIColor?) -> Void)?
    
    // MARK: func回调
    /// 当view设置BackgroundColor前会调用
    /// - Parameters:
    ///   - view: 视图
    ///   - backgroundColor: backgroundColor
    public func axc_willSetBackgroundColor(view: UIView, backgroundColor: UIColor?) { }
    
    /// 当view设置BackgroundColor后会调用
    /// - Parameters:
    ///   - view: 视图
    ///   - backgroundColor: backgroundColor
    public func axc_didSetBackgroundColor(view: UIView, backgroundColor: UIColor?) { }

    // MARK: - 子类实现
    /// 配置参数
    public func config() { }
    /// 创建UI
    public func makeUI() { }
    /// 刷新布局
    public func reloadLayout() { }
    /// Xib显示前会执行
    public func makeXmlInterfaceBuilder() { }
    /// 被添加进视图
    /// - Parameter superView: 父视图
    public func addSelf(superView: UIView) { }
    /// 被移除视图
    public func removeSelf() { }
    
    // MARK: - 父类重写
    /// 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    /// Xib显示前会执行
    public override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    /// 颜色改变
    public override var backgroundColor: UIColor? {
        set {
            axc_willSetBackgroundColorBlock?(self,backgroundColor)
            axc_willSetBackgroundColor(view: self,backgroundColor: backgroundColor)
            super.backgroundColor = newValue
            axc_removeGradient()    // 移除渐变背景
            axc_didSetBackgroundColorBlock?(self,backgroundColor)
            axc_didSetBackgroundColor(view: self,backgroundColor: backgroundColor)
        }
        get { return super.backgroundColor }
    }
    /// 开始布局
    public override func layoutSubviews() {
        super.layoutSubviews()
        axc_layoutSubviewBlock?(bounds)
    }
    /// 视图移动
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let superview = newSuperview {   // 添加进视图
            addSelf(superView: superview)
        }else{  // 被移除
            removeSelf()
        }
    }
    
    // MARK: - 销毁
    deinit { AxcLog("\(AxcClassFromString(self))视图： \(self) 已销毁", level: .trace) }
}
