//
//  AxcBaseControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

@IBDesignable
public class AxcBaseControl: UIControl, AxcBaseClassMakeXibProtocol {
    // MARK: 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    // Xib显示前
    public override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    deinit { AxcLog("View视图： \(self) 已销毁", level: .trace) }
    
    // MARK: 子类实现方法
    /// 设置UI布局
    public func makeUI() { }
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    public func makeXmlInterfaceBuilder() { }
}
