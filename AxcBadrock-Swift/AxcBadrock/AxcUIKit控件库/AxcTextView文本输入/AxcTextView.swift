//
//  AxcTextView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcTextView {
    /// 文本输入框样式
    enum Style {
        case `default`
    }
}

// MARK: - AxcTextView
/// Axc文本输入框
@IBDesignable
public class AxcTextView: AxcBaseView {
    // MARK: - 初始化
    /// 初始化并设置一个占位文字
    public convenience init(_ placeholder: String) {
        self.init()
        axc_placeholderLabel.text = placeholder
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    var axc_style: AxcTextView.Style = .default { didSet { reloadLayout() } }
    
    /// 设置字号
    var axc_font: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet { axc_placeholderLabel.font = axc_font
            axc_textView.font = axc_font
        }
    }
    
    /// 设置内容边距 默认10
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(10) { didSet { reloadLayout() } }
    
    /// 设置底部工具视图的高度 默认30
    var axc_toolViewHeight: CGFloat = 30 { didSet { reloadLayout() } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 在textView获得焦点之前会调用textViewShouldBeginEditing: 方法。
    var axc_shouldBeginEditingBlock: ((_ textView: UITextView) -> Bool)?
    
    /// 当textView失去焦点之前会调用textViewShouldEndEditing
    var axc_shouldEndEditingBlock: ((_ textView: UITextView) -> Bool)?
    
    /// 当text view获得焦点之后，并且已经是第一响应者（first responder），那么会调用textViewDidBeginEditing
    var axc_didBeginEditingBlock: ((_ textView: UITextView) -> Void)?
    
    /// 结束编辑
    var axc_didEndEditingBlock: ((_ textView: UITextView) -> Void)?
    
    /// 内容将要发生改变编辑
    var axc_shouldChangeTextReplacementTextBlock: ((_ textView: UITextView,
                                               _ range: NSRange,
                                               _ text: String) -> Bool)?
    
    /// 内容发生改变编辑
    var axc_didChangeBlock: ((_ textView: UITextView) -> Void)?
    
    /// 焦点发生改变
    var axc_didChangeSelectionBlock: ((_ textView: UITextView) -> Void)?
    
    /// 指定范围的内容与 URL 将要相互作用时激发该方法
    var axc_shouldInteractUrlCharacterRangeInteractionBlock: ((_ textView: UITextView,
                                                               _ url: URL,
                                                               _ characterRange: NSRange,
                                                               _ interaction: UITextItemInteraction) -> Bool)?
    
    /// textView指定范围的内容与文本附件将要相互作用时
    var axc_shouldInteractTextAttachmentRangeInteractionBlock: ((_ textView: UITextView,
                                                                 _ textAttachment: NSTextAttachment,
                                                                 _ characterRange: NSRange,
                                                                 _ interaction: UITextItemInteraction) -> Bool)?
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    public override func config() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        axc_cornerRadius = 5
        axc_borderWidth = 0.5
        axc_borderColor = AxcBadrock.shared.lineColor
        axc_notificationCenter.addObserver(self, selector: #selector(textViewTextChange(_:)),
                                           name: UITextView.textDidChangeNotification, object: nil)
        axc_textView.delegate = self
    }
    /// 设置UI
    public override func makeUI() {
        addSubview(axc_contentView)
        axc_contentView.addSubview(axc_toolView)
        axc_contentView.addSubview(axc_textView)
        axc_contentView.addSubview(axc_placeholderLabel)
        
        reloadLayout()
    }
    /// 刷新布局
    public override func reloadLayout() {
        axc_contentView.axc.remakeConstraints { (make) in
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
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新样式
    func reloadStyle() {
        switch axc_style {
        case .default: break
        }
    }
    /// 刷新占位Label的约束
    func reloadPlaceholderLabelLayout() {
        axc_placeholderLabel.axc.remakeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(axc_placeholderLabel.axc_estimatedSize())
        }
    }
    // MARK: 其他
    /// 监听回调
    @objc private func textViewTextChange(_ sender: Any) {
        guard let notification = sender as? Notification else { return }
        guard let obj = notification.object as? NSObject,   // 是否为NSObject类
              obj == axc_textView // 判断是不是自己这个textView，否则不做操作
        else { return }
        axc_placeholderLabel.isHidden = (axc_textView.text.count != 0)
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    /// 底部工具栏
    lazy var axc_toolView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // MARK: 基础控件
    /// 占位文字label
    lazy var axc_placeholderLabel: AxcBaseLabel = {
        let label = AxcBaseLabel()
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
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.axc_removeInset()
        return textView
    }()
    /// 外部约束视图
    lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // MARK: 销毁
    deinit { axc_notificationCenter.removeObserver(self) }
}

// MARK: - 代理转Block
extension AxcTextView: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return axc_shouldBeginEditingBlock?(textView) ?? true
    }
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
        return axc_shouldEndEditingBlock?(textView) ?? true
    }
    public func textViewDidBeginEditing(_ textView: UITextView){
        axc_didBeginEditingBlock?(textView)
    }
    public func textViewDidEndEditing(_ textView: UITextView){
        axc_didEndEditingBlock?(textView)
    }
    public func textView(_ textView: UITextView, shouldChangeTextIn
                            range: NSRange,
                         replacementText text: String) -> Bool{
        return axc_shouldChangeTextReplacementTextBlock?(textView, range, text) ?? true
    }
    public func textViewDidChange(_ textView: UITextView){
        axc_didChangeBlock?(textView)
    }
    public func textViewDidChangeSelection(_ textView: UITextView){
        axc_didChangeSelectionBlock?(textView)
    }
    public func textView(_ textView: UITextView,
                         shouldInteractWith URL: URL,
                         in characterRange: NSRange,
                         interaction: UITextItemInteraction) -> Bool{
        return axc_shouldInteractUrlCharacterRangeInteractionBlock?(textView, URL, characterRange, interaction) ?? true
    }
    public func textView(_ textView: UITextView,
                         shouldInteractWith textAttachment: NSTextAttachment,
                         in characterRange: NSRange,
                         interaction: UITextItemInteraction) -> Bool{
        return axc_shouldInteractTextAttachmentRangeInteractionBlock?(textView, textAttachment, characterRange, interaction) ?? true
    }
}

