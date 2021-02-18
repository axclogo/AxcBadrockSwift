//
//  AxcBaseClassProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

public protocol AxcBaseClassMakeUIProtocol {
    /// 创建UI的接口
    func makeUI()
}
public protocol AxcBaseClassMakeXibProtocol: AxcBaseClassMakeUIProtocol {
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    func makeXmlInterfaceBuilder()
}
