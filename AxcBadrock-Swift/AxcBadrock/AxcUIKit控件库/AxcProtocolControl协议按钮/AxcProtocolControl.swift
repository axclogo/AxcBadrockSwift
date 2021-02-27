//
//  AxcProtocolControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/23.
//

import UIKit

public typealias AxcProtocolControlTapBlock = (_ protocolControl: AxcProtocolControl, _ protocolText: String ) -> Void

@IBDesignable
public class AxcProtocolControl: AxcBaseControl {

    
    // MARK: - Api
    /// 协议选中勾选的图片
    var axc_selectedImage: UIImage = AxcBadrockBundle.selectedHookImage.axc_tintColor(AxcBadrock.shared.themeColor) ?? UIImage(){
        didSet { reloadLayout() }
    }
    /// 协议未勾选的图片
    var axc_normalImage: UIImage = AxcBadrockBundle.selectedHookImage.axc_tintColor(AxcBadrock.shared.unTextColor) ?? UIImage(){
        didSet { reloadLayout() }
    }
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
    var axc_protocols: [String] = [] {
        didSet { reloadLayout() }
    }
    /// 设置字号大小
    var axc_font: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet { textView.font = axc_font
            reloadLayout()
        }
    }
    /// 设置对齐方式
    var acx_textAlignment: NSTextAlignment = .left {
        didSet { reloadLayout() }
    }
    
    
    // 刷新布局
    public override func reloadLayout() {
        textView.attributedText =
            axc_text.axc_attributedStr(color: axc_normalTextColor, font: axc_font)
            .axc_paragraphStyle( NSParagraphStyle().axc_ )
    }
    
    
    // MARK: - 懒加载
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.axc_removeInset()
        return textView
    }()
}
