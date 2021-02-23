//
//  AxcButton.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// 布局模式
public extension AxcButton {
    enum Style {
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
        if let _title = title { titleLabel.text = _title }
        if let _image = image { imageView.image = _image }
        makeUI()
    }
    public override func config() {
        
    }
    public override func makeUI() {
        addSubview(counentView) // 承载视图
        counentView.addSubview(imageView)
        counentView.addSubview(titleLabel)
        // 重新加载布局
        reloadLayout()
    }
    
    // MARK: - 设置参数
    /// 设置图宽高 默认 Axc_navigationItemSize.width
    var axc_imgSize: CGFloat = Axc_navigationItemSize.width { didSet { reloadLayout() } }

    /// 内容布局样式
    var axc_style: AxcButton.Style = .imgLeft_textRight {
        didSet {
            imageView.isHidden = false
            titleLabel.isHidden = false
            switch axc_style {
            case .imgTop_textBottom:    // 图上文下
                imageView.axc.remakeConstraints { (make) in
                    make.top.left.right.equalTo(0)
                    make.height.equalTo(axc_imgSize)
                }
                titleLabel.axc.remakeConstraints { (make) in
                    make.left.bottom.right.equalTo(0)
                    make.top.equalTo(imageView.axc.bottom)
                }
            case .textTop_imgBottom:    // 文上图下
                titleLabel.axc.remakeConstraints { (make) in
                    make.top.left.right.equalTo(0)
                    make.bottom.equalTo(imageView.axc.top)
                }
                imageView.axc.remakeConstraints { (make) in
                    make.left.bottom.right.equalTo(0)
                    make.height.equalTo(axc_imgSize)
                }
            case .imgLeft_textRight:    // 图左文右
                imageView.axc.remakeConstraints { (make) in
                    make.top.bottom.left.equalTo(0)
                    make.width.equalTo(axc_imgSize)
                }
                titleLabel.axc.remakeConstraints { (make) in
                    make.top.bottom.right.equalTo(0)
                    make.left.equalTo(imageView.axc.right)
                }
            case .textLeft_imgRight:    // 文左图右
                imageView.axc.remakeConstraints { (make) in
                    make.top.bottom.right.equalTo(0)
                    make.width.equalTo(axc_imgSize)
                }
                titleLabel.axc.remakeConstraints { (make) in
                    make.top.bottom.left.equalTo(0)
                    make.right.equalTo(imageView.axc.left)
                }
            case .img:  // 全图片
                titleLabel.isHidden = true
                imageView.axc.remakeConstraints { (make) in
                    make.edges.equalTo(0)
                }
            case .text: // 全文字
                imageView.isHidden = true
                titleLabel.axc.remakeConstraints { (make) in
                    make.edges.equalTo(0)
                }
            }
        }
    }
    /// 内容边距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(5) {
        didSet { counentView.axc.remakeConstraints { (make) in make.edges.equalTo(axc_contentInset) } }
    }
    /// 内容rect
    var axc_contentRect: CGRect = CGRect.zero {
        didSet {
            counentView.axc.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(axc_contentRect.axc_y)
                make.left.equalToSuperview().offset(axc_contentRect.axc_x)
                make.size.equalTo(axc_contentRect.size)
            }
        }
    }
    /// 重载倒计时方法
    /// - Parameters:
    ///   - duration: 时间
    ///   - format: 格式 如 "%d秒后重新获取"
    ///   - endBlock: 结束Block
    func axc_startCountdown(duration: Int,
                            format: String,
                            endBlock:AxcCountdownEndBlock? = nil) {
        self.axc_startCountdown(duration: duration, countdownBlock: { [weak self] (_, countDown) in
            guard let weakSelf = self else { return }
            weakSelf.titleLabel.text = String(format: format, countDown)
        }, endBlock: endBlock)
    }
    
    // MARK: - 复用
    public override func reloadLayout() {
        // 重set边距
        let _contentInset = axc_contentInset
        axc_contentInset = _contentInset
        // 重set布局
        let _contentLayout = axc_style
        axc_style = _contentLayout
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
    lazy var titleLabel: AxcLabel = {
        let label = AxcLabel()
        return label
    }()
    /// 承载组件的视图
    lazy var counentView: AxcBaseView = {
        let view = AxcBaseView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.clear
        return view
    }()
}
