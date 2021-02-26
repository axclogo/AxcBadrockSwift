//
//  AxcWebView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit

public class AxcWebView: WKWebView {
    
    
    // MARK: - 懒加载
    // MARK: 预设
    lazy var axc_progressView: AxcProgressView = {
        let progressView = AxcProgressView()
        return progressView
    }()
}
