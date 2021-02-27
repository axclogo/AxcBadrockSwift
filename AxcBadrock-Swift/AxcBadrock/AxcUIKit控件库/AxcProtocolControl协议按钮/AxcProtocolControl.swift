//
//  AxcProtocolControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/23.
//

import UIKit

public typealias AxcProtocolControlTapUrlBlock = (_ protocolControl: AxcProtocolControl, _ url: String? ) -> Void

@IBDesignable
public class AxcProtocolControl: AxcBaseControl {
    // MARK: - 父类重写
    public override func config() {
        axc_masksToBounds = false
    }
    public override func makeUI() {
        addSubview(textView)
        
        reloadLayout()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        reloadLayout()
    }
    // MARK: - Api
    /// 协议选中勾选的图片
    var axc_selectedImage: UIImage = AxcBadrockBundle.selectedHookImage.axc_tintColor(AxcBadrock.shared.themeColor) ?? UIImage(){
        didSet { reloadLayout() }
    }
    /// 协议未勾选的图片
    var axc_normalImage: UIImage = AxcBadrockBundle.selectedHookImage.axc_tintColor(AxcBadrock.shared.unTextColor) ?? UIImage(){
        didSet { reloadLayout() }
    }
    var axc_imageSize: CGSize = CGSize(15) { didSet { reloadLayout() } }
    /// 协议条款文字颜色
    var axc_selectedTextColor: UIColor = AxcBadrock.shared.themeColor{
        didSet { reloadLayout() }
    }
    /// 协议普通文字颜色
    var axc_normalTextColor: UIColor = AxcBadrock.shared.unTextColor {
        didSet { reloadLayout() }
    }
    /// 设置文字
    var axc_text: String = "" {
        didSet { textView.text = axc_text
            reloadLayout()
        }
    }
    /// 设置需要标明的协议文字
    var axc_protocols: [(text: String, url: String)] = [] {
        didSet { reloadLayout() }
    }
    /// 设置字号大小
    var axc_font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet { textView.font = axc_font
            reloadLayout()
        }
    }
    /// 设置对齐方式
    var axc_textAlignment: NSTextAlignment = .left {
        didSet { reloadLayout() }
    }
    /// 设置文字基线偏移，正为上，负为下 默认2.5
    var axc_baselineOffset: CGFloat = 2.5 { didSet { reloadLayout() } }
    /// 设置图文间距 默认5
    var axc_imgTextSpacing: CGFloat = 5 { didSet { reloadLayout() } }
    /// 设置内容边距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(5) {
        didSet { reloadLayout() }
    }
    
    // MARK: 回调
    /// 回调Block
    var axc_tapUrlBlock: AxcProtocolControlTapUrlBlock = { (control,url) in
        AxcLog("[可选]未设置AxcProtocolControl的点击回调\nControl: \(control)\nUrl: %@",url, level: .info)
    }
    
    // MARK: 其他
    // 刷新布局
    public override func reloadLayout() {
        let headerImg = isSelected ? axc_selectedImage : axc_normalImage
        let headerImgAttributed = headerImg.axc_textAttachment().axc_setSize(axc_imageSize).axc_attributedStr // 头部的选中图片
        let imgTextSpacingAttchment = NSTextAttachment().axc_setSize(CGSize(axc_imgTextSpacing)).axc_attributedStr // 间距
        let attributedText = axc_text    // 全部文本
            .axc_attributedStr(color: axc_normalTextColor, font: axc_font)      // 颜色字体
            .axc_setParagraphStyle( NSParagraphStyle().axc_setAlignment( axc_textAlignment ) )  // 对齐模式
            .axc_setBaselineOffset( axc_baselineOffset )    // 基线偏移
        axc_protocols.forEach{  // 标注协议部分
            let text = $0.0
            let url = $0.1
            let range = (attributedText.axc_strValue as NSString).range(of: text)
            if let mutableAttributedText = attributedText as? NSMutableAttributedString {
                var validUrl = Axc_placeholderUrl
                if url.axc_isValidUrl { // 判断是否是有效Url，否则textView点击会闪退
                    validUrl = url
                }else{  // 回报日志及可拦截闪退处理
                    let log = "试图添加Url到协议文本中失败！\n原因：不是有效的Url！\nUrl: \(url)\nText: \(text)"
                    AxcLog(log, level: .fatal)
                    if AxcBadrock.fatalError { fatalError(log) }
                }
                mutableAttributedText.addAttributes([ .link : validUrl ], range: range)
            }
        }
        textView.attributedText = headerImgAttributed + imgTextSpacingAttchment + attributedText
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor : axc_selectedTextColor]
        // 约束
        textView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
    }
    
    // MARK: - 懒加载
    private lazy var textView: AxcProtocolTextView = {
        let textView = AxcProtocolTextView()
        textView.axc_masksToBounds = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.axc_removeInset()
        // 手势响应到自身
        textView.axc_addTapGesture { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.isSelected = !weakSelf.isSelected
            weakSelf.reloadLayout()
        }
        textView.setShouldInteractWithURL { [weak self] (url) in
            guard let weakSelf = self else { return }
            weakSelf.axc_tapUrlBlock(weakSelf, url)
        }
        return textView
    }()
}

private typealias AxcProtocolTextViewTapUrlBlock = (_ url: String? ) -> Void
private class AxcProtocolTextView: UITextView, UITextViewDelegate {
    // 回调Block
    var tapUrlBlock: AxcProtocolTextViewTapUrlBlock = { _ in }
    // 设置Url点击监听
    func setShouldInteractWithURL(_ block: @escaping AxcProtocolTextViewTapUrlBlock) {
        delegate = self
        tapUrlBlock = block
    }
    // url回调
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        tapUrlBlock( URL.axc_strValue )
        return false
    }
    // 禁用选中
    override var canBecomeFirstResponder: Bool{
        return false
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        resignFirstResponder()
        return false
    }
}
