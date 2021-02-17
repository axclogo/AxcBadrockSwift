//
//  AxcCGRectEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import UIKit

// MARK: - 数据转换
extension CGRect: AxcBaseStrTransform {
    // MARK: 协议
    /// 转换成String
    public var axc_strValue: String {
        return "\(axc_x)-\(axc_y)-\(axc_width)-\(axc_height)"
    }
    
    // MARK: 扩展
    /// 转换成元组 (x,y,width,height)
    public var axc_tuplesValue: (CGFloat,CGFloat,CGFloat,CGFloat) {
        return (axc_x,axc_y,axc_width,axc_height)
    }
}
 
// MARK: - 类方法/属性
extension CGRect: AxcInitializeZero {
    // MARK: 协议
    /// 直接获取0，0
    public static var axc_zero: CGRect {
        return CGRect.zero
    }
    
    // MARK: 扩展
    /// 通过元组实例化
    public init(_ tuples: (CGFloat,CGFloat,CGFloat,CGFloat) ){
        self = CGRect(x: tuples.0, y: tuples.1, width: tuples.2, height: tuples.3)
    }
    
    /// 计算一个center的Rect
    /// - Parameters:
    ///   - center: center
    ///   - size: size
    public init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
}
 
// MARK: - 属性 & Api
public extension CGRect {
    /// 获取区域面积
    var axc_area:   CGFloat { return axc_width * axc_height }
    /// 按比例缩放
    func axc_scale(_ scale: CGFloat) -> CGRect {
        return CGRect(x: origin.x * scale, y: origin.y * scale,
                      width: size.width * scale, height: size.height * scale)
    }
}
// MARK: - 读写扩展
public extension CGRect {
    /// 读写x
    var axc_x:      CGFloat {
        set{ return origin.x = newValue }
        get{ return origin.x }
    }
    /// 读写y
    var axc_y:      CGFloat {
        set{ return origin.y = newValue }
        get{ return origin.y }
    }
    /// 读写width
    var axc_width:  CGFloat {
        set{ return size.width = newValue }
        get{ return size.width }
    }
    /// 读写height
    var axc_height: CGFloat {
        set{ return size.height = newValue }
        get{ return size.height }
    }
    /// 读写left
    var axc_left: CGFloat {
        set { axc_x = newValue }
        get { return self.axc_x }
    }
    /// 读写right
    var axc_right: CGFloat {
        set { axc_x = newValue - axc_width }
        get { return axc_x + axc_width }
    }
    /// 读写top
    var axc_top: CGFloat {
        set { axc_y = newValue }
        get { return axc_y }
    }
    /// 读写bottom
    var axc_bottom: CGFloat {
        set { axc_y = newValue - axc_height }
        get { return axc_y + axc_height }
    }
    /// 读写origin
    var axc_origin: CGPoint {
        set { origin = newValue }
        get { return origin }
    }
    /// 读写size
    var axc_size: CGSize {
        set { size = newValue }
        get { return size }
    }
    /// 读写centerX
    var axc_centerX: CGFloat {
        get { return axc_x + axc_size.width / 2 }
        set { axc_x = newValue - axc_size.width / 2 }
    }
    /// 读写centerY
    var axc_centerY: CGFloat {
        get { return axc_y + axc_size.height / 2 }
        set { axc_y = newValue - axc_size.height / 2 }
    }
}
 
// MARK: - 决策判断
extension CGRect: AxcDecisionIsZero {
    /// 是否等于0
    public var axc_isZero: Bool { return self == CGRect.zero }
}
 
// MARK: - 运算符
public extension CGRect {
    /// 两个CGRect相加
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: CGRect
    /// - Returns: 相加后的CGRect
    static func + (leftValue: CGRect, rightValue: CGRect) -> CGRect {
        return CGRect(x: leftValue.axc_x + rightValue.axc_x,
                      y: leftValue.axc_y + rightValue.axc_y,
                      width: leftValue.axc_width + rightValue.axc_width,
                      height: leftValue.axc_height + rightValue.axc_height)
    }
    
    /// 使用元组相加
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: tuple value.
    /// - Returns: 相加后的CGRect
    static func + (leftValue: CGRect, rightValue: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> CGRect {
        return CGRect(x: leftValue.axc_x + rightValue.x,
                      y: leftValue.axc_y + rightValue.y,
                      width: leftValue.axc_width + rightValue.width,
                      height: leftValue.axc_height + rightValue.height)
    }
    
    /// 两个CGRect相减
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: CGRect
    /// - Returns: 相减后的CGRect
    static func - (leftValue: CGRect, rightValue: CGRect) -> CGRect {
        return CGRect(x: leftValue.axc_x - rightValue.axc_x,
                      y: leftValue.axc_y - rightValue.axc_y,
                      width: leftValue.axc_width - rightValue.axc_width,
                      height: leftValue.axc_height - rightValue.axc_height)
    }
    
    /// 使用元组相减
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: tuple value.
    /// - Returns: 相加后的CGRect
    static func - (leftValue: CGRect, rightValue: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> CGRect {
        return CGRect(x: leftValue.axc_x - rightValue.x,
                      y: leftValue.axc_y - rightValue.y,
                      width: leftValue.axc_width - rightValue.width,
                      height: leftValue.axc_height - rightValue.height)
    }
    
    /// 两个左边都乘以多少
    /// - Parameters:
    ///   - leftValue: CGRect
    ///   - rightValue: 倍数、标量
    /// - Returns: 计算后的CGRect
    static func * (leftValue: CGRect, rightValue: CGFloat) -> CGRect {
        return CGRect(x: leftValue.axc_x * rightValue,
                      y: leftValue.axc_y * rightValue,
                      width: leftValue.axc_width * rightValue,
                      height: leftValue.axc_height * rightValue)
    }
    
    /// 两个右边都乘以多少
    /// - Parameters:
    ///   - leftValue: 倍数、标量
    ///   - rightValue: CGRect
    /// - Returns: 计算后的CGRect
    static func * (leftValue: CGFloat, rightValue: CGRect) -> CGRect {
        return CGRect(x: rightValue.axc_x * leftValue,
                      y: rightValue.axc_y * leftValue,
                      width: rightValue.axc_width * leftValue,
                      height: rightValue.axc_height * leftValue)
    }
}

 
