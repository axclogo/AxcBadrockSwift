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
        guard let path = Axc_bundle.path(forResource: "AxcBadrock", ofType: "bundle") else { AxcLog("获取AxcBadrock.bundle资源目录失败！", level: .warning)
            return bundle
        }
        guard let b = AxcBadrockBundle(path: path) else { AxcLog("获取AxcBadrock.bundle资源目录失败！", level: .warning)
            return bundle
        }
        return b
    }()
}

// MARK: - 图片资源相关
public extension AxcBadrockBundle {
    /// 获取图片资源文件
    static var imageBundle: Bundle? {
        guard let image_path = Axc_BadrockBundle.path(forResource: "AxcImageResources", ofType: nil) else {
            AxcLog("获取图片资源文件Bundle失败！请检查目录！\nAxcImageResources", level: .warning)
            return nil
        }
        return Bundle(path: image_path)
    }
    
    /// 获取ImageBundle中的某个图片
    static func image(name: String) -> UIImage {
        guard let resourcePath = imageBundle?.resourcePath else {
            AxcLog("没有找到AxcBadrock.bundle中的图片资源文件！image name: \(name)", level: .warning)
            return UIImage()
        }
        let nsStr = resourcePath as NSString
        let imageName = "\(name).png"
        let imagePath = nsStr.appendingPathComponent(imageName)
        guard let img = UIImage(contentsOfFile: imagePath) else {
            AxcLog("没有找到AxcBadrock.bundle路径中的图片资源文件！image path: \(imagePath)", level: .warning)
            return placeholderImage
        }
        return img
    }
    
    /// 获取ImageBundle的占位图
    static var placeholderImage: UIImage {
        return image(name: "badrock_placeholder")
    }
}
