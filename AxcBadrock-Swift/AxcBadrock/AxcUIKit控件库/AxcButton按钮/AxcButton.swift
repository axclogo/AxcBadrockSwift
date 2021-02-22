//
//  AxcButton.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// 布局模式
public extension AxcButton {
    enum Layout {
        /// 图上文下
        case imgTop_textBottom
        /// 文上图下
        case textTop_imgBottom
        /// 图左文右
        case imgLeft_textRight
        /// 文左图右
        case textLeft_imgRight
        /// 纯图片
        case text
        /// 纯文字
        case img
    }
}

/// Axc封装的按钮控件
public class AxcButton: AxcBaseControl {
    convenience init(title: String? = nil, image: UIImage? = nil) {
        self.init()
        if let _title = title { textLabel.text = _title }
        if let _image = image { imageView.image = _image }
        makeUI()
    }
    
    public override func makeUI() {
        addSubview(counentView) // 承载视图
        counentView.addSubview(imageView)
        counentView.addSubview(textLabel)
        // 重新加载布局
        reloadLayout()
    }
    
    // MARK: - 设置参数
    /// 设置图所占比值 默认 图1/3
     var imgRatio: CGFloat = 1/3 { didSet { reloadLayout() } }
    /// 设置文所占比值 默认 文字2/3
     var textRatio: CGFloat = 2/3 { didSet { reloadLayout() } }

    /// 内容布局
    var contentLayout: AxcButton.Layout = .imgLeft_textRight {
        didSet {
            imageView.isHidden = false
            textLabel.isHidden = false
            switch contentLayout {
            case .imgTop_textBottom:    // 图上文下
                imageView.axc.remakeConstraints { (make) in
                    make.top.left.right.equalTo(0)
                    make.height.equalToSuperview().multipliedBy(imgRatio)
                }
                textLabel.axc.remakeConstraints { (make) in
                    make.left.bottom.right.equalTo(0)
                    make.height.equalToSuperview().multipliedBy(textRatio)
                }
            case .textTop_imgBottom:    // 文上图下
                textLabel.axc.remakeConstraints { (make) in
                    make.top.left.right.equalTo(0)
                    make.height.equalToSuperview().multipliedBy(textRatio)
                }
                imageView.axc.remakeConstraints { (make) in
                    make.left.bottom.right.equalTo(0)
                    make.height.equalToSuperview().multipliedBy(imgRatio)
                }
            case .imgLeft_textRight:    // 图左文右
                imageView.axc.remakeConstraints { (make) in
                    make.top.bottom.left.equalTo(0)
                    make.width.equalToSuperview().multipliedBy(imgRatio)
                }
                textLabel.axc.remakeConstraints { (make) in
                    make.top.bottom.right.equalTo(0)
                    make.width.equalToSuperview().multipliedBy(textRatio)
                }
            case .textLeft_imgRight:    // 文左图右
                imageView.axc.remakeConstraints { (make) in
                    make.top.bottom.right.equalTo(0)
                    make.width.equalToSuperview().multipliedBy(imgRatio)
                }
                textLabel.axc.remakeConstraints { (make) in
                    make.top.bottom.left.equalTo(0)
                    make.width.equalToSuperview().multipliedBy(textRatio)
                }
            case .img:  // 全图片
                textLabel.isHidden = true
                imageView.axc.remakeConstraints { (make) in
                    make.edges.equalTo(0)
                }
            case .text: // 全文字
                imageView.isHidden = true
                textLabel.axc.remakeConstraints { (make) in
                    make.edges.equalTo(0)
                }
            }
        }
    }
    /// 内容边距
    var contentInset: UIEdgeInsets = UIEdgeInsets(5) {
        didSet { counentView.axc.remakeConstraints { (make) in make.edges.equalTo(contentInset) } }
    }
    /// 内容rect
    var contentRect: CGRect = CGRect.zero {
        didSet {
            counentView.axc.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(contentRect.axc_y)
                make.left.equalToSuperview().offset(contentRect.axc_x)
                make.size.equalTo(contentRect.size)
            }
        }
    }
    
    // MARK: - 复用
    func reloadLayout() {
        // 重set编剧
        let _contentInset = contentInset
        contentInset = _contentInset
        // 重set布局
        let _contentLayout = contentLayout
        contentLayout = _contentLayout
    }

    // MARK: - 懒加载
    /// 图片
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    /// 标题label
    lazy var textLabel: AxcLabel = {
        let label = AxcLabel()
        return label
    }()
    /// 承载组件的视图
    lazy var counentView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.clear
        return view
    }()
}
