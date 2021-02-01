//
//  AxcStringEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 1 - 类型转换
public extension String {
    // MARK: Foundation转换
    
    /// 字符串转Data
    var axc_data: Data? {
        return self.axc_data()
    }
    
    /// 字符串转Data
    /// - Parameter using: 编码模式
    /// - Returns: Data
    func axc_data(_ using: Encoding = .utf8) -> Data? {
        return self.data(using: using)
    }
    
    /// 获取这个路径下的文件数据
    var axc_fileData: Data? {
        guard let url = self.axc_url else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    
    /// 转换成URL
    var axc_url: URL? {
        return URL(string: self)
    }
    
    /// 转换成URLRequest
    var axc_urlRequest: URLRequest? {
        guard let url = self.axc_url else { return nil }
        return URLRequest(url: url)
    }
    
    
    
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
    func axc_color(_ alpha: CGFloat = 1) -> UIColor? {
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
    
    
    // MARK: 编码转换
    /// 获取这个字符串UrlEncoded编码字符
    var axc_urlEncoded: String? {
        guard let encodedStr = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return encodedStr
    }
    
    /// 获取这个字符串UrlDecode编码字符
    var axc_urlDecoded: String? {
        guard let decodedStr = self.removingPercentEncoding else { return nil }
        return decodedStr
    }
    
    /// 获取这个汉字字符串的拼音
    var axc_pinYin: String? {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        return String(mutableString)
    }
    
    
    
    
    
    // MARK: 富文本转换
    /// 转换成可变富文本
    var axc_attributedStr: NSMutableAttributedString {
        return self.axc_attributedStr()
    }
    
    /// 转换成可变富文本
    /// - Returns: 可变富文本
    func axc_attributedStr(color: UIColor? = nil,
                           font: UIFont? = nil,
                           isHtml: Bool = false) -> NSMutableAttributedString {
        var attStr_M = NSMutableAttributedString()
        if isHtml { // 是html字符串
            guard let data = self.axc_data else { return attStr_M }
            attStr_M = try! NSMutableAttributedString.init(data: data,
                                                           options: [.documentType : NSAttributedString.DocumentType.html],
                                                           documentAttributes: nil)
        }else{
            attStr_M = NSMutableAttributedString(string: self)
            let range = NSRange(location: 0, length: self.count)
            if let textColor = color { attStr_M.addAttribute(.foregroundColor, value: textColor, range: range) }
            if let textFont = font { attStr_M.addAttribute(.font, value: textFont, range: range) }
        }
        return attStr_M
    }
    
}

// MARK: - 2 - 判断决策

/// 预设表达式枚举
enum AxcRegularEnum: String {
    /// Url正则
    case urlRegular         = "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
    /// 手机号正则
    case phoneRegular       = "^1\\d{10}$"
    /// 邮箱正则
    case emailRegular       = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    /// 身份证正则
    case idCardRegular      = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
    /// ip正则
    case ipAddressRegular   = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
    /// 纯中文正则
    case chineseRegular     = "^[\\u4e00-\\u9fa5]+$"
    /// 纯英文正则
    case englishRegular     = "^[A-Za-z]+$"
    /// 纯数字
    case numberRegular      = "^[0-9]*$"
    /// 英文数字正则
    case englishNumRegular  = "^[A-Za-z0-9]+$"
    /// 是否为整数
    case integerNumRegular  = "^-?\\d+$"
    /// 这个字符串是否为有理数和小数
    case ratDecNumRegular   = "^(\\-|\\+)?\\d+(\\.\\d+)?$"
    /// 至少是x位的数字
    case minNumRegular      = "^\\d{%d}$"
}

public extension String {
    
    /// 是否为合法Url
    var axc_isUrl: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.urlRegular.rawValue) }
    
    /// 是否为合法手机号
    var axc_isPhone: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.phoneRegular.rawValue) }
    
    /// 是否为合法邮箱
    var axc_isEmail: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.emailRegular.rawValue) }
    
    /// 是否为合法身份证号
    var axc_isIdCard: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.idCardRegular.rawValue) }
        
    /// 是否为合法ip
    var axc_isIpAddress: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.ipAddressRegular.rawValue) }
    
    /// 是否为纯中文
    var axc_isChinese: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.chineseRegular.rawValue) }
    
    /// 是否为纯英文
    var axc_isEnglish: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.englishRegular.rawValue) }
    
    /// 是否为纯数字
    var axc_isNumber: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.numberRegular.rawValue) }
    
    /// 是否为英文/数字
    var axc_isEnNum: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.englishNumRegular.rawValue) }
    
    /// 是否为整数
    var axc_isIntegerNum: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.integerNumRegular.rawValue) }
    
    /// 是否为正数、负数、和小数（有理数和小数）
    var axc_isRatDecNum: Bool { return axc_isMatchingRegular(regular: AxcRegularEnum.ratDecNumRegular.rawValue) }
    
    /// 是否为至少为x位的数字
    /// - Parameter min: 至少min位的数字
    /// - Returns: true or false
    func axc_isMinNum(min: Int) -> Bool {
        return axc_isMatchingRegular(regular: String(format: AxcRegularEnum.minNumRegular.rawValue, min))
    }
    
    /// 判断路径的文件是否存在
    var axc_isFileExist: Bool {
        return AxcFileManager.fileExists(atPath: self)
    }
    
    /// 判断是否包含另一个字符串
    /// - Parameter subStr: 查找子串
    /// - Returns: true or false
    func axc_hasSubStr(subStr: String) -> Bool {
        return (self.range(of: subStr) != nil)
    }
    
    /// 判断本字符串是否符合正则表达式
    /// - Parameter regular: 正则表达式
    /// - Returns: true or false
    func axc_isMatchingRegular(regular: String) -> Bool {
        guard !regular.isEmpty else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return predicate.evaluate(with: self)
    }
    
}
