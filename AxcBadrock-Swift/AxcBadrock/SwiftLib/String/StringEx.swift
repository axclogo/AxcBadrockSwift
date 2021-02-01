//
//  StringEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 类型转换
public extension String {
    // MARK: Foundation转换
    
    
    
    // MARK: UIKit转换
    /// 获取这个资源名对应的图片
    var axc_sourceImage: UIImage? {
        return UIImage(named: self)
    }
    
    /// 将这个base64字符转换成图片
    var axc_base64Image: UIImage? {
        guard let data = Data.init(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: data)
    }
    
    /// 生成字符串对应的二维码图片
    var axc_qrCodeImage: UIImage? {
        return self.axc_qrCodeImage()
    }
    
    /// 生成字符串对应的二维码图片
    /// - Parameter size: 大小，默认1024
    /// - Returns: 图片
    func axc_qrCodeImage(size: CGSize = CGSize(width: 1024, height: 1024)) -> UIImage? {
        guard let ciImage = self.axc_qrCodeCIImage else { return nil }
        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(ciImage, from: ciImage.extent)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height),
                                      bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let scale = min(size.width / ciImage.extent.width, size.height / ciImage.extent.height)
        bitmapContext!.interpolationQuality = CGInterpolationQuality.none
        bitmapContext?.scaleBy(x: scale, y: scale)
        bitmapContext?.draw(bitmapImage!, in: ciImage.extent)
        guard let scaledImage = bitmapContext?.makeImage() else { return nil }
        return UIImage(cgImage: scaledImage)
    }
    
    /// 获取以这个字符串为内容生成CIImage格式的二维码
    var axc_qrCodeCIImage: CIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setDefaults()
        guard let data = self.data(using: .utf8) else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        guard let outPutImage = filter.outputImage else { return nil }
        return outPutImage
    }
    
    /// 获取这个十六进制字符串的颜色
    var axc_color: UIColor? {
        return self.axc_color()
    }
    
    /// 获取这个十六进制字符串的颜色
    /// - Parameter alpha: 透明度
    /// - Returns: 颜色
    func axc_color(_ alpha: CGFloat = 1) -> UIColor?{
        if self.count <= 0 || self == "(null)" || self == "<null>" { return nil }
        var string = ""
        if self.lowercased().hasPrefix("0x") {
            string = self.replacingOccurrences(of: "0x", with: "")
        } else if self.hasPrefix("#") {
            string = self.replacingOccurrences(of: "#", with: "")
        } else {
            string = self
        }
        if string.count == 3 {
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        guard let hexValue = Int(string, radix: 16) else { return nil }
        var trans = alpha
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        let red = (hexValue >> 16) & 0xFF
        let green = (hexValue >> 8) & 0xFF
        let blue = hexValue & 0xFF
        return Axc_RGB(CGFloat(red), CGFloat(green), CGFloat(blue), a: trans)
    }
    
    
    // MARK: 富文本转换
    
    /// 转换成可变富文本
    /// - Returns: 可变富文本
    func axc_attributedString(color: UIColor? = nil,
                              font: UIFont? = nil) -> NSMutableAttributedString {
        let attStr_M = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: self.count)
        if let textColor = color { attStr_M.addAttribute(.foregroundColor, value: textColor, range: range) }
        if let textFont = font { attStr_M.addAttribute(.font, value: textFont, range: range) }
        return attStr_M
    }
    
   
    
    
}
