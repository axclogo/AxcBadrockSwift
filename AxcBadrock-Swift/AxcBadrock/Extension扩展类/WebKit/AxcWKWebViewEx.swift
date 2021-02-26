//
//  AxcWKWebViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit

// MARK: - 类方法/属性
public extension WKWebView {
    /// url初始化
    /// - Parameter url: url
    convenience init(_ url: URL) {
        self.init()
        axc_loadUrl(url)
    }
    
    /// urlStr初始化
    /// - Parameter urlStr: urlStr
    convenience init(_ urlStr: String) {
        self.init()
        axc_loadUrlStr(urlStr)
    }
    
    /// FileUrl初始化
    /// - Parameters:
    ///   - url: url
    ///   - readAccessUrl: readAccessUrl
    convenience init(_ url: URL, readAccessUrl: URL) {
        self.init()
        axc_loadFileUrl(url, allowingReadAccessTo: readAccessUrl)
    }
    
    /// HTMLStr初始化
    /// - Parameters:
    ///   - string: HTMLStr
    ///   - baseUrl: baseUrl
    convenience init(_ string: String, baseUrl: URL? = nil) {
        self.init()
        axc_loadHTMLStr(string, baseUrl: baseUrl)
    }
}

// MARK: - 属性 & Api
private var kEstimatedProgress = "estimatedProgress"
public extension WKWebView {
    /// 添加进度观察者
    func axc_addProgressObserver() {
        axc_removeObserver(kEstimatedProgress)  // 先移除
        axc_addObserver(kEstimatedProgress)     // 后添加
    }
    /// 加载url
    @discardableResult
    func axc_loadUrl(_ url: URL) -> WKNavigation? {
        return load( url.axc_request )
    }
    /// 加载url字符
    @discardableResult
    func axc_loadUrlStr(_ urlStr: String) -> WKNavigation? {
        guard let url = urlStr.axc_url else { return nil }
        return axc_loadUrl( url )
    }
    /// 加载文件
    @discardableResult
    func axc_loadFileUrl(_ url: URL, allowingReadAccessTo readAccessUrl: URL) -> WKNavigation? {
        return loadFileURL(url, allowingReadAccessTo: readAccessUrl)
    }
    /// 加载HTML字符
    @discardableResult
    func axc_loadHTMLStr(_ string: String, baseUrl: URL? = nil) -> WKNavigation? {
        return loadHTMLString(string, baseURL: baseUrl)
    }
}

// MARK: - 决策判断
public extension WKWebView {
}
