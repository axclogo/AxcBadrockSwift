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
//    init(_ url: ) {
//        <#statements#>
//    }
    // MARK: - 父类重写
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func config() {
        // 添加进度观察
        webView.axc_addProgressObserver()
    }
    override func makeUI() {
        view.addSubview(webView)
        axc_setContentEdge( UIEdgeInsets.zero )
    }
    
    // MARK: - Api
    // MARK: 加载
    /// 加载url
    func axc_loadUrl(_ url: URL) -> WKNavigation? {
        return webView.axc_loadUrl( url )
    }
    /// 加载url字符
    func axc_loadUrlStr(_ urlStr: String) -> WKNavigation? {
        return webView.axc_loadUrlStr( urlStr )
    }
    /// 加载文件
    func axc_loadFileUrl(_ url: URL, allowingReadAccessTo readAccessURL: URL) -> WKNavigation? {
        return webView.axc_loadFileUrl(url, allowingReadAccessTo: readAccessURL)
    }
    /// 加载HTML字符
    func axc_loadHTMLStr(_ string: String, baseUrl: URL? = nil) -> WKNavigation? {
        return webView.axc_loadHTMLStr(string, baseUrl: baseUrl)
    }
    /// 设置内容边距 webview
    func axc_setContentEdge(_ edge: UIEdgeInsets) {
        webView.axc.makeConstraints { (make) in
            make.edges.equalTo(edge)
        }
    }
    
    // MARK: - 懒加载
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.isHidden = true
        return progressView
    }()
    lazy var configuration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration()
        
        return configuration
    }()
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension AxcWebVC: WKNavigationDelegate, WKUIDelegate {
    
}
