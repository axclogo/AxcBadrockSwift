//
//  AxcUIImageEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 数据转换
public extension UIImage {
    /// 将这个图片转换成PNG的base64字符
    var axc_base64StrPNG: String? {
        return axc_pngData?.base64EncodedString()
    }
    /// 将这个图片转换成JPEG的base64字符
    func axc_base64StrJPEG(compressed: CGFloat) -> String? {
        return axc_jpegData(compressed: compressed)?.base64EncodedString()
    }
    
    /// 转成Data
    var axc_pngData: Data? {
        return self.pngData()
    }
    /// 压缩这个image生成data
    var axc_jpegData: Data? {
        return self.axc_jpegData()
    }
    /// 压缩这个image生成data
    func axc_jpegData(compressed: CGFloat = 1) -> Data? {
        return self.jpegData(compressionQuality: compressed)
    }
    
    /// 转换成富文本的附件对象
    func axc_textAttachment(_ type: String? = nil) -> NSTextAttachment {
        return NSTextAttachment(image: self)
    }
    
    /// 转换这幅图的平均颜色
    var axc_averageColor: UIColor? {
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }
        let parameters = [kCIInputImageKey: ciImage, kCIInputExtentKey: CIVector(cgRect: ciImage.extent)]
        guard let outputImage = CIFilter(name: "CIAreaAverage", parameters: parameters)?.outputImage else { return nil }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let workingColorSpace: Any = cgImage?.colorSpace ?? NSNull()
        let context = CIContext(options: [.workingColorSpace: workingColorSpace])
        context.render(outputImage, toBitmap: &bitmap,
                       rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8, colorSpace: nil)
        return UIColor(CGFloat(bitmap[0]), CGFloat(bitmap[1]), CGFloat(bitmap[2]), a: CGFloat(bitmap[3]) / 255.0)
    }
}

// MARK: - 类方法/属性
public extension UIImage {
    /// 通过颜色生成Image
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小 默认最小
    /// - Returns: UIImage
    convenience init?(_ color: UIColor, size: CGSize = CGSize.axc_minSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil}
        self.init(cgImage: aCgImage)
    }
    
    /// 通过base64Str生成图片
    /// - Parameters:
    ///   - base64Str: base64Str
    ///   - scale:  比例缩放
    convenience init?(base64Str: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64Str) else { return nil }
        self.init(data: data, scale: scale)
    }
    
    /// 获取AppIcon
    static var axc_appIcon: UIImage? {
        guard let CFBundleIcons = Axc_infoDictionary!["CFBundleIcons"] as? [String:Any] else { return nil }
        guard let CFBundlePrimaryIcon = CFBundleIcons["CFBundlePrimaryIcon"] as? [String:Any] else { return nil }
        guard let CFBundleIconFiles = CFBundlePrimaryIcon["CFBundleIconFiles"] as? [Any] else { return nil }
        guard let imageName = CFBundleIconFiles.last as? String else { return nil }
        return UIImage(named: imageName)
    }
}

// MARK: - 属性 & Api
public extension UIImage {
    /// 获取宽度
    var axc_width: CGFloat {
        return size.width
    }
    /// 获取高度
    var axc_height: CGFloat {
        return size.height
    }
    
    /// 保存到系统相册，需要权限访问
    func axc_saveAlbum(target: Any? = nil, selector: Selector? = nil) -> UIImage {
        UIImageWriteToSavedPhotosAlbum(self, target, selector, nil)
        return self
    }
    
    /// 获取图片某一点的颜色
    func axc_pointColor(_ point: CGPoint) -> UIColor? {
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: size).contains(point) else { return nil }
        let pointX = trunc(point.x);
        let pointY = trunc(point.y);
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [0, 0, 0, 0]
        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1,
                                       bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
               let cgImage = cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - size.height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
        }
        return UIColor(CGFloat(pixelData[0]),CGFloat(pixelData[1]), CGFloat(pixelData[2]),a: CGFloat(pixelData[3]))
    }
}

// MARK: - 图像处理
public extension UIImage {
    /// 使用.alwaysOriginal模式渲染
    var axc_original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// 使用.alwaysTemplate模式渲染
    var axc_template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    /// 压缩比值，默认0.5压缩
    func axc_compressed(ratio: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: ratio) else { return nil }
        return UIImage(data: data)
    }
    
    /// 图片缩放绘制
    func axc_scale(scale: CGFloat, opaque: Bool = false) -> UIImage? {
        let newHeight = size.height * scale
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片旋转，选择一个方向
    /// - Parameter direction: 方向
    func axc_rotate(direction: AxcDirection = .bottom) -> UIImage? {
        var angle = 0
        switch direction {
        case .top:      angle = 180
        case .left:     angle = 90
        case .right:    angle = -90
        default:        angle = 0 }
        return axc_rotate(angle: CGFloat(angle))
    }
    
    /// 图片旋转 0 - 320
    func axc_rotate(angle: CGFloat) -> UIImage? {
        return axc_rotate(radians: angle.axc_angleToRadian)
    }
    
    /// 图片旋转 0 - 2.pi
    func axc_rotate(radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())
        UIGraphicsBeginImageContextWithOptions(roundedDestRect.size, false, scale)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)
        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片切圆角，默认以最小宽高
    func axc_cornerRadius(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = size.axc_smallerValue / 2   // 取宽高中一个最小的
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0, radius <= maxRadius {
            cornerRadius = radius
        } else { cornerRadius = maxRadius }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    /// 选择横向拉伸
    /// - Parameters:
    ///   - width: width
    ///   - isCenter: 是否从中间拉伸，如果为true，则优先从中间拉伸
    /// - Returns: UIImage
    func axc_tensileHorizontal(_ width: CGFloat? = nil, isCenter: Bool = false) -> UIImage? {
        var w: CGFloat = 0
        if width != nil { w = width! }
        if isCenter { w =  size.width / 2 }
        if w == 0 { return nil }
        return axc_tensile(point: CGPoint(x: w, y: 0))
    }
    
    /// 选择纵向拉伸
    /// - Parameters:
    ///   - height: height
    ///   - isCenter: 是否从中间拉伸，如果为true，则优先从中间拉伸
    /// - Returns: UIImage
    func axc_tensileVertical(_ height: CGFloat? = nil, isCenter: Bool = false) -> UIImage? {
        var h: CGFloat = 0
        if height != nil { h = height! }
        if isCenter { h =  size.height / 2 }
        if h == 0 { return nil }
        return axc_tensile(point: CGPoint(x: 0, y: h))
    }
    
    /// 选择点位进行拉伸
    /// - Parameters:
    ///   - point: point
    ///   - isCenter: 是否从中间拉伸，如果为true，则优先从中间拉伸
    /// - Returns: UIImage
    func axc_tensile(point: CGPoint? = nil, isCenter: Bool = false) -> UIImage? {
        var p = CGPoint.zero;
        if point != nil { p = point! }
        if isCenter { p = CGPoint(x: size.width / 2, y: size.height / 2) }
        if p.axc_isZero { return nil }
        return stretchableImage(withLeftCapWidth: Int(p.x), topCapHeight: Int(p.y))
    }
    
    /// 镜像翻转
    /// - Parameter direction: 方向
    /// - Returns: UIImage
    func axc_mirror(direction: AxcDirection) -> UIImage? {
        guard let _cgImage = cgImage else { return nil }
        var orientation: UIImage.Orientation = .upMirrored
        switch direction {
        case .top:      orientation = .upMirrored
        case .left:     orientation = .leftMirrored
        case .bottom:   orientation = .downMirrored
        case .right:    orientation = .rightMirrored
        default: return self }
        return UIImage(cgImage: _cgImage, scale: scale, orientation: orientation)
    }
}

// MARK: - 图像滤镜
/// 滤镜方法扩展
public extension UIImage {
    /// 渲染一个模糊组的滤镜
    var axc_blurStyleFilter: AxcBlurStyleFilter {
        return AxcBlurStyleFilter(image: self)
    }
    
    
}
