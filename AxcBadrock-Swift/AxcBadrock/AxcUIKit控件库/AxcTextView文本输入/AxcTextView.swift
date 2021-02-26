//
//  AxcTextView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

@IBDesignable
public class AxcTextView: AxcBaseView {
    // MARK: - 初始化
    /// 初始化并设置一个占位文字
    public convenience init(_ placeholder: String) {
        self.init()
        axc_placeholderLabel.text = placeholder
    }
    
    // MARK: - 父类重写
    public override func config() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        axc_cornerRadius = 5
        axc_borderWidth = 0.5
        axc_borderColor = AxcBadrock.shared.lineColor
        axc_notificationCenter.addObserver(self, selector: #selector(textViewTextChange(_:)),
                                           name: UITextView.textDidChangeNotification, object: nil)
    }
    public override func makeUI() {
        addSubview(contentView)
        contentView.addSubview(axc_toolView)
        contentView.addSubview(axc_textView)
        contentView.addSubview(axc_placeholderLabel)
        
        reloadLayout()
    }
    /// 适配布局
    public override func reloadLayout() {
        contentView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
        reloadPlaceholderLabelLayout()
        axc_toolView.axc.remakeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(axc_toolViewHeight)
        }
        axc_textView.axc.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(axc_toolView.axc.top)
        }
    }
    
    // MARK: - Api
    /// 代理
    weak var axc_delegate: UITextViewDelegate? = nil { didSet { axc_textView.delegate = axc_delegate } }
    /// 设置字号
    var axc_font: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            axc_placeholderLabel.font = axc_font
            axc_textView.font = axc_font
        }
    }
    /// 设置内容边距 默认10
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(10) { didSet { reloadLayout() } }
    /// 设置底部工具视图的高度 默认30
    var axc_toolViewHeight: CGFloat = 30 { didSet { reloadLayout() } }

    // MARK: - 私有
    // 刷新占位Label的约束
    func reloadPlaceholderLabelLayout() {
        axc_placeholderLabel.axc.remakeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(axc_placeholderLabel.axc_estimatedSize())
        }
    }
    // MARK: 其他
    // 监听回调
    @objc private func textViewTextChange(_ sender: Any) {
        guard let notification = sender as? Notification else { return }
        guard let obj = notification.object as? NSObject,   // 是否为NSObject类
              obj == axc_textView // 判断是不是自己这个textView，否则不做操作
        else { return }
        axc_placeholderLabel.isHidden = (axc_textView.text.count != 0)
    }
    
    // MARK: - 懒加载
    /// 占位文字label
    lazy var axc_placeholderLabel: AxcLabel = {
        let label = AxcLabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AxcBadrock.shared.unTextColor
        label.axc_contentInset = UIEdgeInsets.zero
        label.isUserInteractionEnabled = false
        label.text = AxcBadrockLanguage("输入文本")
        label.axc_didSetTextBlock = { [weak self] (_,_) in  // 文字set时
            guard let weakSelf = self else { return }
            weakSelf.reloadPlaceholderLabelLayout()
        }
        return label
    }()
    /// 输入框
    lazy var axc_textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = AxcBadrock.shared.textColor
        textView.contentInset = UIEdgeInsets.zero
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.axc_removeInset()
        return textView
    }()
    /// 底部工具栏
    lazy var axc_toolView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    /// 外部约束视图
    lazy var contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    deinit { axc_notificationCenter.removeObserver(self) }
}

