//
//  AxcNavBar.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

public class AxcNavBar: AxcBaseView {
    // MARK: - 创建UI
    public override func makeUI() {
        // 默认渐变背景
        axc_setGradient()
        // 设置边框线色
        axc_setBorderLineDirection()
        axc_setBorderLineWidth(0.5)
        addSubview(contentView)
        contentView.axc.makeConstraints { (make) in
            make.top.equalTo(Axc_statusHeight)
            make.left.bottom.right.equalToSuperview()
        }
        
        contentView.addSubview(titleView)
    }
    // MARK: - 属性
    
    var leftBarItems: [UIView] = [] {
        didSet {
            
        }
    }
    
    
    /// 添加一个按钮
    func axc_addItem(title: String? = nil, image: UIImage? = nil, size: CGSize? = nil,
                     contentLayout: AxcButton.Layout = .img,
                     actionBlock: AxcActionBlock? = nil) {
        
    }
    

    
    // MARK: - 懒加载
    lazy var titleView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    /// 内容承载视图
    lazy var contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
}
