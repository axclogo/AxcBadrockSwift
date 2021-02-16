//
//  AxcUIImageViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension UIImageView {
}

// MARK: - 类方法/属性
public extension UIImageView {
    /// 通过图片名创建ImageView
    /// - Parameter imageName: 图片名
    convenience init(_ imageName: String) {
        self.init()
        image = imageName.axc_sourceImage
    }
}

// MARK: - 属性 & Api
public extension UIImageView {
    /// 快速设置图片名称
    func axc_imageName(_ imageName: String) -> UIImageView {
        image = imageName.axc_sourceImage
        return self
    }
    /// 快速设置渲染颜色
    func axc_tintColor(_ tintColor: UIColor, mode: UIImage.RenderingMode = .alwaysTemplate ) -> UIImageView {
        image = image?.withRenderingMode(mode)
        self.tintColor = tintColor
        return self
    }
    /// 开启抗锯齿
    func axc_antialias(_ antialias: Bool = true) -> UIImageView {
        layer.shouldRasterize = antialias
        layer.allowsEdgeAntialiasing = antialias
        return self
    }
}

// MARK: - 决策判断
public extension UIImageView {
    /// 是否有图片
    var axc_isHasImage: Bool { return image != nil }
    
}
