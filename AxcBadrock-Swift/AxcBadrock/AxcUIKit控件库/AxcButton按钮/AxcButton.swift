//
//  AxcButton.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcButton {
    /// 布局样式
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

// MARK: - AxcButton
/// Axc按钮控件
@IBDesignable
public class AxcButton: AxcBaseControl {
    // MARK: - 初始化
    /// 初始化
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    convenience init(title: String? = nil, image: UIImage? = nil) {
        self.init()
        if let _title = title { axc_titleLabel.text = _title }
        if let _image = image { axc_imageView.image = _image }
        makeUI()
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 内容布局样式
    var axc_style: AxcButton.Style = .imgLeft_textRight { didSet { reloadLayout() } }
    
    /// 内容边距
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(5) { didSet { reloadLayout() } }
    
    /// 设置图宽高 默认 Axc_navigationItemSize.width
    var axc_imgSize: CGFloat = Axc_navigationItemSize.width { didSet { reloadLayout() } }
    
    // MARK: 方法
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
            weakSelf.axc_titleLabel.text = String(format: format, countDown)
        }, endBlock: endBlock)
    }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 点击事件
    var axc_actionBlock: ((_ button: AxcButton ) -> Void)
        = { (btn) in
        let className = AxcClassFromString(self)
        AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(btn)", level: .action)
    }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    public override func config() {
        super.config()
        axc_isTouchMaskFeedback = true
        axc_isTouchVibrationFeedback = true
        // 点击事件
        axc_addEvent { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.axc_actionBlock(weakSelf)
        }
    }
    /// 设置UI布局
    public override func makeUI() {
        super.makeUI()
        // 加载布局
        reloadLayout()
    }
    /// 刷新布局
    public override func reloadLayout() {
        // 设置内容视图的边距
        axc_contentView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle() {
        // 设置展示样式
        axc_imageView.isHidden = false
        axc_titleLabel.isHidden = false
        switch axc_style {
        case .imgTop_textBottom:    // 图上文下
            axc_imageView.axc.remakeConstraints { (make) in
                make.top.left.right.equalTo(0)
                make.height.equalTo(axc_imgSize)
            }
            axc_titleLabel.axc.remakeConstraints { (make) in
                make.left.bottom.right.equalTo(0)
                make.top.equalTo(axc_imageView.axc.bottom)
            }
        case .textTop_imgBottom:    // 文上图下
            axc_titleLabel.axc.remakeConstraints { (make) in
                make.top.left.right.equalTo(0)
                make.bottom.equalTo(axc_imageView.axc.top)
            }
            axc_imageView.axc.remakeConstraints { (make) in
                make.left.bottom.right.equalTo(0)
                make.height.equalTo(axc_imgSize)
            }
        case .imgLeft_textRight:    // 图左文右
            axc_imageView.axc.remakeConstraints { (make) in
                make.top.bottom.left.equalTo(0)
                make.width.equalTo(axc_imgSize)
            }
            axc_titleLabel.axc.remakeConstraints { (make) in
                make.top.bottom.right.equalTo(0)
                make.left.equalTo(axc_imageView.axc.right)
            }
        case .textLeft_imgRight:    // 文左图右
            axc_imageView.axc.remakeConstraints { (make) in
                make.top.bottom.right.equalTo(0)
                make.width.equalTo(axc_imgSize)
            }
            axc_titleLabel.axc.remakeConstraints { (make) in
                make.top.bottom.left.equalTo(0)
                make.right.equalTo(axc_imageView.axc.left)
            }
        case .img:  // 全图片
            axc_titleLabel.isHidden = true
            axc_imageView.axc.remakeConstraints { (make) in
                make.edges.equalTo(0)
            }
        case .text: // 全文字
            axc_imageView.isHidden = true
            axc_titleLabel.axc.remakeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
    
    // MARK: - 懒加载
    // MARK: 基础控件
    /// 图片
    lazy var axc_imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = false
        imgView.contentMode = .scaleAspectFit
        axc_contentView.addSubview(imgView)
        return imgView
    }()
    /// 标题label
    lazy var axc_titleLabel: AxcBaseLabel = {
        let label = AxcBaseLabel()
        axc_contentView.addSubview(label)
        return label
    }()
    /// 承载组件的视图
    lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.clear
        addSubview(view) // 承载视图
        return view
    }()
}
