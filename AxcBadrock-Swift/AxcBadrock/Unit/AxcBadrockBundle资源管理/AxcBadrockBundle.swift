//
//  AxcBadrockBundle.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

/// Badrock框架内部的Bundle
public class AxcBadrockBundle: Bundle {
    /// 单例实例化
    static let shared: AxcBadrockBundle = {
        let bundle = AxcBadrockBundle()
        guard let path = Axc_bundle.path(forResource: "AxcBadrock", ofType: "bundle") else { return bundle }
        guard let b = AxcBadrockBundle(path: path) else { return bundle }
        return b
    }()
    
}
