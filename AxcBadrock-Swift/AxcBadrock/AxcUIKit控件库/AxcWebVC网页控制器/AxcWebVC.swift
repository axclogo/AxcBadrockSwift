//
//  AxcWebVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit

class AxcWebVC: AxcBaseVC {
    // MARK: - 初始化
    /// 容易造成主线程阻塞
    /// - Parameter url: url
    convenience init(_ url: URL) {
        self.init()
        axc_loadUrl(url)
    }
    // MARK: - 父类重写
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func config() {
        contigNavView()
    }
    override func makeUI() {
       let _axc_isUseCustomNavBar = axc_isUseCustomNavBar
        axc_isUseCustomNavBar = _axc_isUseCustomNavBar
    }
    
    // MARK: - Api
    // MARK: 加载
    /// 加载url
    @discardableResult
    func axc_loadUrl(_ url: URL) -> WKNavigation? {
        return webView.axc_loadUrl( url )
    }
    /// 加载url字符
    @discardableResult
    func axc_loadUrlStr(_ urlStr: String) -> WKNavigation? {
        return webView.axc_loadUrlStr( urlStr )
    }
    /// 加载文件
    @discardableResult
    func axc_loadFileUrl(_ url: URL, allowingReadAccessTo readAccessURL: URL) -> WKNavigation? {
        return webView.axc_loadFileUrl(url, allowingReadAccessTo: readAccessURL)
    }
    /// 加载HTML字符
    @discardableResult
    func axc_loadHTMLStr(_ string: String, baseUrl: URL? = nil) -> WKNavigation? {
        return webView.axc_loadHTMLStr(string, baseUrl: baseUrl)
    }
    /// 设置内容边距 webview
    func axc_setContentEdge(_ edge: UIEdgeInsets) {
        if !view.subviews.contains(webView) { axc_addSubView(webView) }
        webView.axc.makeConstraints { (make) in
            make.edges.equalTo(edge)
        }
    }
    /// 是否使用网页的标题
    var axc_isUseWebTitle = true
    /// 是否使用自定义透明导航
    var axc_isUseCustomNavBar: Bool = false {
        didSet { axc_setIsUseCustomNavBar( axc_isUseCustomNavBar, animated: false ) }
    }
    /// 设置是否使用自定义透明导航，可选动画
    func axc_setIsUseCustomNavBar(_ useClear: Bool, animated: Bool = true) {
        axc_useNavBar = !useClear
        if animated {
            UIView.animate(withDuration: Axc_duration) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.remakeLayout( useClear )
                weakSelf.view.layoutIfNeeded()
            }
        }else{
            remakeLayout( useClear )
        }
    }
    
    // MARK: - 私有
    private func remakeLayout(_ useClear: Bool) {
        if useClear { // 使用透明
            let topHeight = Axc_navBarHeight + Axc_statusHeight
            axc_setContentEdge( UIEdgeInsets(top: topHeight, left: 0, bottom: 0, right: 0) )
            view.addSubview(axc_navBar)
            axc_navBar.axc.remakeConstraints { (make) in
                make.top.left.right.equalTo(0)
                make.height.equalTo(topHeight)
            }
        }else{
            axc_setContentEdge( UIEdgeInsets.zero )
        }
    }
    /// 设置barView
    private func contigNavView() {
        axc_navBar.axc_addBackItem()
        axc_navBar.axc_selectedBlock = { [weak self] (_,direction,idx) in
            guard let weakSelf = self else { return }
            if direction == .left && idx == 0{  // 返回
                weakSelf.axc_popViewController()
            }
        }
    }
    
    // MARK: - 懒加载
    lazy var configuration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration()
        return configuration
    }()
    lazy var webView: AxcWebView = {
        let webView = AxcWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.axc_titleBlock = { [weak self] (_,title) in
            guard let weakSelf = self else { return }
            if weakSelf.axc_isUseWebTitle { weakSelf.title = title }
        }
        return webView
    }()
}

extension AxcWebVC: WKNavigationDelegate, WKUIDelegate {
    
}
