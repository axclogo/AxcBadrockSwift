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
    }
    override func makeUI() {
        view.addSubview(webView)
        axc_setContentEdge( UIEdgeInsets.zero )
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
        webView.axc.makeConstraints { (make) in
            make.edges.equalTo(edge)
        }
    }
    /// 默认使用网页的标题
    var axc_isUseWebTitle = true
    
    
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
