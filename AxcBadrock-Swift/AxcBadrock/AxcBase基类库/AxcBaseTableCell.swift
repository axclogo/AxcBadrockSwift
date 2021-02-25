//
//  AxcBaseTableCell.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

@IBDesignable
class AxcBaseTableCell: UITableViewCell,
                        AxcBaseClassConfigProtocol,
                        AxcBaseClassMakeXibProtocol,
                        AxcGradientLayerProtocol {
    // MARK: - 初始化
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    // Xib显示前
    public override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    deinit { AxcLog("View视图： \(self) 已销毁", level: .trace) }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    // 设置选中状态
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - 子类实现方法
    /// 配置 执行于makeUI()之前
    public func config() {
        selectionStyle = .none
    }
    /// 设置UI布局
    public func makeUI() { }
    /// 刷新UI布局
    public func reloadLayout() { }
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    public func makeXmlInterfaceBuilder() { }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    lazy var axc_button: AxcButton = {
        let button = AxcButton()
        addSubview(button)
        return button
    }()

}
