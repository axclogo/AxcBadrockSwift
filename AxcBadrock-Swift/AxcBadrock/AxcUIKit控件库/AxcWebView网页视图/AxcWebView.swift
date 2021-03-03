//
//  AxcWebView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit

public typealias AxcWebViewTitleBlock = (_ webView: AxcWebView, _ title: String) -> Void
public typealias AxcWebViewProgressBlock = (_ webView: AxcWebView, _ progress: CGFloat) -> Void

@IBDesignable
public class AxcWebView: WKWebView,
                         AxcBaseClassConfigProtocol,
                         AxcBaseClassMakeXibProtocol,
                         AxcGradientLayerProtocol  {
    // MARK: - 初始化
    public required init?(coder: NSCoder) { super.init(coder: coder)
        config()
        makeUI()
    }
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
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
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    // MARK: - Api
    /// 配置 执行于makeUI()之前
    public func config() {
        axc_addProgressObserver()
        axc_addTitleObserver()
    }
    /// 设置UI布局
    public func makeUI() {
        addSubview(axc_progressView)
        reloadLayout()
    }
    /// 刷新UI布局
    public func reloadLayout() {
        axc_progressView.axc.remakeConstraints { (make) in
            if axc_progressDirection.contains(.top)    { make.top.equalToSuperview() }
            if axc_progressDirection.contains(.left)   { make.left.equalToSuperview() }
            if axc_progressDirection.contains(.bottom) { make.bottom.equalToSuperview() }
            if axc_progressDirection.contains(.right)  { make.right.equalToSuperview() }
            make.height.equalTo(axc_progressHeight)
        }
    }
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    public func makeXmlInterfaceBuilder() { }
    
    /// 设置进度条的高度
    var axc_progressHeight: CGFloat = 2 { didSet { reloadLayout() } }
    /// 设置进度条的方位
    var axc_progressDirection: AxcDirection = [.top, .left, .right] { didSet { reloadLayout() } }
    
    /// 标题读取回调
    var axc_titleBlock: AxcWebViewTitleBlock = { (webView,title) in
        AxcLog("[可选]未设置AxcWebView的标题回调\nWebView: \(webView)\nTitle: \(title)", level: .info)
    }
    /// 加载进度读取回调
    var axc_progressBlock: AxcWebViewProgressBlock = { (webView,progress) in
        AxcLog("[可选]未设置AxcWebView的进度回调\nWebView: \(webView)\nProgress: \(progress)", level: .info)
    }
    
    // MARK: - 其他
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == kEstimatedProgress {  // 进度
            axc_progressView.isHidden = false
            var progress = estimatedProgress.axc_cgFloatValue
            axc_progressView.axc_progress = progress
            if progress >= 1.0 {
                progress = 1
                axc_progressView.axc_animateFade(isIn: false) {  [weak self] (_,_)  in
                    guard let weakSelf = self else { return }
                    weakSelf.axc_progressView.axc_progress = 0
                }
                axc_progressBlock(self, progress)
            }
        }else if keyPath == kWebTitle {  // 标题
            if let _title = title { axc_titleBlock(self, _title) }
        }else{  // 其他的
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    // MARK: - 懒加载
    // MARK: 预设
    /// 进度条
    lazy var axc_progressView: AxcProgressView = {
        let progressView = AxcProgressView()
        progressView.isHidden = true
        return progressView
    }()
    
    deinit {
        axc_removeProgressObserver()
        axc_removeTitleObserver()
        AxcLog("AxcWebView视图： \(self) 已销毁", level: .trace)
    }
}
