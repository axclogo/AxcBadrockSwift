//
//  AxcUIViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension UIView {
    /// 对视图进行截图，转换成Image
    var axc_screenshot: UIImage? {
        return axc_screenshot(layer.frame)
    }
    /// 对视图部分区域进行截图，转换成Image
    func axc_screenshot(_ rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIRectClip(rect)
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - 类方法/属性
public extension UIView {
    /// 实例化一个比superView小的边距
    /// - Parameters:
    ///   - superView: superView
    ///   - spacing: 边距
    convenience init(superView: UIView, spacing: CGFloat = 0) {
        self.init(frame: CGRect(x: superView.axc_x + spacing, y: superView.axc_y + spacing,
                                width: superView.axc_width - spacing*2, height: superView.axc_height - spacing*2))
    }
    
    /// 调整这个视图的大小，使它适合最大的子视图
    static func axc_resizeToFitSubviews(view: UIView, ignoreTags: [Int] = []) -> CGRect {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in view.subviews {
            let aView = someView
            if !ignoreTags.contains(someView.tag) {
                let newWidth = aView.axc_x + aView.axc_width
                let newHeight = aView.axc_y + aView.axc_height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        return CGRect(x: view.axc_x, y: view.axc_y, width: width, height: height)
    }
}

// MARK: - 属性 & Api
public extension UIView {
    /// 循环，直到找到根视图
    func axc_rootView() -> UIView {
        guard let parentView = superview else { return self }
        return parentView.axc_rootView()
    }
    
    /// 获取相对于window的坐标
    var axc_convertWindowRect: CGRect {
        return self.convert(self.bounds, to: window)
    }
    
    /// 调整自己的大小，使它适合最大的子视图
    func axc_resizeToFitSubviews() {
        frame = UIView.axc_resizeToFitSubviews(view: self)
    }
    /// 调整自己的大小，使它适合最宽的子视图
    func axc_resizeToFitWidth() {
        let currentHeight = self.axc_height
        self.sizeToFit()
        self.axc_height = currentHeight
    }
    /// 调整自己的大小，使它适合最高的子视图
    func axc_resizeToFitHeight() {
        let currentWidth = self.axc_width
        self.sizeToFit()
        self.axc_width = currentWidth
    }
    
    /// 添加一组视图
    @discardableResult
    func axc_addSubviews(_ views: [UIView]) -> UIView {
        views.forEach { addSubview($0) }
        return self
    }
    /// 移除所有子视图
    @discardableResult
    func axc_removeAllSubviews() -> UIView {
        for subview in subviews { subview.removeFromSuperview() }
        return self
    }
    /// 移除自己和子视图的第一响应
    @discardableResult
    func axc_cancleFirstResponder() -> UIView {
        if isFirstResponder { resignFirstResponder() }
        subviews.forEach{ $0.resignFirstResponder() }
        return self
    }
}

// MARK: - 动态绑定参数
/// 可读写视图对象的键
private var kaxc_vc = "kaxc_vc"
public extension UIView {
    /// 可读写视图对象
    var axc_vc: UIViewController? {
        get { guard let vc = AxcRuntime.getAssociatedObj(self, &kaxc_vc) as? UIViewController else { return nil }
            return vc }
        set { AxcRuntime.setAssociatedObj(self, &kaxc_vc, newValue) }
    }
}

// MARK: - 视觉扩展属性 & 方法
public extension UIView {
    /// 快速设置阴影 支持圆角阴影
    /// - Parameters:
    ///   - offset: 阴影偏移量
    ///   - radius: 阴影圆角
    ///   - color: 阴影颜色
    ///   - opacity: 阴影透明
    ///   - cornerRadius: 圆角
    @discardableResult
    func axc_addShadow(offset: CGSize = CGSize(width: 5, height: 5),
                       radius: CGFloat = 5,
                       color: UIColor = UIColor.black,
                       opacity: CGFloat = 0.7,
                       cornerRadius: CGFloat? = nil) -> UIView {
        self.axc_shadowOffset = offset
        self.axc_shadowRadius = radius
        self.axc_shadowOpacity = opacity
        self.axc_shadowColor = color
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
        return self
    }
}

// MARK: - Xib扩展属性
public extension UIView {
    /// 边框颜色
    @IBInspectable var axc_borderColor: UIColor? {
        get { return layer.axc_borderColor }
        set { layer.axc_borderColor = newValue }
    }
    /// 边框宽度
    @IBInspectable var axc_borderWidth: CGFloat {
        get { return layer.axc_borderWidth }
        set { layer.axc_borderWidth = newValue }
    }
    /// 圆角
    @IBInspectable var axc_cornerRadius: CGFloat {
        get { return layer.axc_cornerRadius }
        set { layer.axc_cornerRadius = newValue }
    }
    /// 阴影颜色
    @IBInspectable var axc_shadowColor: UIColor? {
        get { layer.axc_shadowColor }
        set { layer.axc_shadowColor = newValue }
    }
    /// 阴影透明度
    @IBInspectable var axc_shadowOpacity: CGFloat {
        get { return layer.axc_shadowOpacity }
        set { layer.axc_shadowOpacity = newValue }
    }
    /// 阴影偏移
    @IBInspectable var axc_shadowOffset: CGSize {
        get { return layer.axc_shadowOffset }
        set { layer.axc_shadowOffset = newValue }
    }
    /// 阴影圆角
    @IBInspectable var axc_shadowRadius: CGFloat {
        get { return layer.axc_shadowRadius }
        set { layer.axc_shadowRadius = newValue }
    }
    /// 遮罩边缘
    @IBInspectable var axc_masksToBounds: Bool {
        get { return layer.axc_masksToBounds }
        set { layer.axc_masksToBounds = newValue }
    }
}

// MARK: - frame扩展属性
public extension UIView {
    /// 读写x
    var axc_x: CGFloat {
        set { frame = CGRect(x: newValue, y: frame.axc_y, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_x }
    }
    /// 读写y
    var axc_y: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: newValue, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_y }
    }
    /// 读写width
    var axc_width: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: newValue, height: frame.axc_height) }
        get { return frame.axc_width }
    }
    /// 读写height
    var axc_height: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: frame.axc_width, height: newValue) }
        get { return frame.axc_height }
    }
    /// 读写left
    var axc_left: CGFloat {
        set { axc_x = newValue }
        get { return frame.axc_left }
    }
    /// 读写right
    var axc_right: CGFloat {
        set { axc_x = newValue - axc_width }
        get { return frame.axc_right }
    }
    /// 读写top
    var axc_top: CGFloat {
        set { axc_y = newValue }
        get { return frame.axc_top }
    }
    /// 读写bottom
    var axc_bottom: CGFloat {
        set { axc_y = newValue - axc_height }
        get { return frame.axc_bottom }
    }
    /// 读写origin
    var axc_origin: CGPoint {
        set { frame = CGRect(origin: newValue, size: axc_size ) }
        get { return frame.axc_origin }
    }
    /// 读写size
    var axc_size: CGSize {
        set { frame = CGRect(origin: frame.axc_origin, size: newValue) }
        get { return frame.axc_size }
    }
    /// 读写centerX
    var axc_centerX: CGFloat {
        get { return center.x }
        set { center.x = newValue }
    }
    /// 读写centerY
    var axc_centerY: CGFloat {
        get { return self.center.y }
        set { self.center.y = newValue }
    }
}

// MARK: - 手势相关
public extension UIView {
    // MARK: 操作
    /// 添加一组手势
    @discardableResult
    func axc_addGestureRecs(_ gestureRecognizers: [UIGestureRecognizer]) -> UIView {
        for recognizer in gestureRecognizers {
            addGestureRecognizer(recognizer)
        }
        return self
    }
    /// 移除一组手势
    @discardableResult
    func axc_removeGestureRecs(_ gestureRecognizers: [UIGestureRecognizer]) -> UIView {
        for recognizer in gestureRecognizers {
            removeGestureRecognizer(recognizer)
        }
        return self
    }
    /// 移除所有手势
    @discardableResult
    func axc_removeAllGestureRecs() -> UIView {
        gestureRecognizers?.forEach(removeGestureRecognizer)
        return self
    }
    // MARK: 快速添加
    /// 添加任意一种手势
    @discardableResult
    func axc_addGesture<T>(_ gestureRec: T) -> T {
        if gestureRec is UIGestureRecognizer {
            isUserInteractionEnabled = true
            addGestureRecognizer(gestureRec as! UIGestureRecognizer)
        }
        return gestureRec
    }
    /// 点击手势
    @discardableResult
    func axc_addTapGesture(_ actionBlock: @escaping AxcGestureActionBlock) -> UITapGestureRecognizer {
        return axc_addGesture(UITapGestureRecognizer(actionBlock))
    }
    /// 长按手势
    @discardableResult
    func axc_addLongPressGesture(_ actionBlock: @escaping AxcGestureActionBlock) -> UILongPressGestureRecognizer {
        return axc_addGesture(UILongPressGestureRecognizer(actionBlock))
    }
    /// 滑动手势 默认添加右滑手势
    @discardableResult
    func axc_addSwipeGesture(_ direction: UISwipeGestureRecognizer.Direction = .right,
                             _ actionBlock: @escaping AxcGestureActionBlock) -> UISwipeGestureRecognizer {
        let left = UISwipeGestureRecognizer(actionBlock) // 同一个手势只能指定一个方向
        left.direction = direction
        return axc_addGesture(left)
    }
    /// 拖动手势 可不传Block，默认实现拖动功能
    @discardableResult
    func axc_addPanGesture(_ actionBlock: AxcGestureActionBlock? = nil) -> UIPanGestureRecognizer {
        guard let block = actionBlock else {
            return axc_addGesture(UIPanGestureRecognizer { [weak self] (p) in
                guard let weakSelf = self else { return }
                if let pan = p as? UIPanGestureRecognizer {
                    let translation = pan.translation(in: weakSelf)
                    guard let panView = pan.view else { return }
                    weakSelf.center = CGPoint(x: panView.axc_centerX + translation.x, y: panView.axc_centerY + translation.y)
                    pan.setTranslation(CGPoint.zero, in: weakSelf)  // 归零
                }
            })
        }
        return axc_addGesture(UIPanGestureRecognizer(block))
    }
    /// 长按手势
    /// - Parameters:
    ///   - actionBlock: 触发回调
    ///   - minScale: 最小缩放临界比
    ///   - maxScale: 最大缩放临界比
    /// - Returns: UIPinchGestureRecognizer
    @discardableResult
    func axc_addPinchGesture(_ actionBlock: AxcGestureActionBlock? = nil,
                             minScale: CGFloat = 0.5,
                             maxScale: CGFloat = 2) -> UIPinchGestureRecognizer {
        guard let block = actionBlock else {
            return axc_addGesture(UIPinchGestureRecognizer{ [weak self] (p) in
                guard let weakSelf = self else { return }
                if let pinch = p as? UIPinchGestureRecognizer {
                    if pinch.state == .changed {
                        guard let pinchView = pinch.view else { return }
                        weakSelf.transform = pinchView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
                        pinch.scale = 1
                    }else if pinch.state == .ended {
                        UIView.animate(withDuration: Axc_duration) {
                            if weakSelf.transform.a < minScale || weakSelf.transform.d < minScale { // 最小缩放临界
                                weakSelf.transform = CGAffineTransform(scaleX: minScale, y: minScale)
                            }
                            if weakSelf.transform.a > maxScale || weakSelf.transform.d > maxScale { // 最大缩放临界
                                weakSelf.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
                            }
                        }
                    }
                }
            })
        }
        return axc_addGesture(UIPinchGestureRecognizer(block))
    }
    
    /// 旋转手势
    @discardableResult
    func axc_addRotationGesture(_ actionBlock: AxcGestureActionBlock? = nil) -> UIRotationGestureRecognizer {
        guard let block = actionBlock else {
            return axc_addGesture(UIRotationGestureRecognizer{ [weak self] (r) in
                guard let weakSelf = self else { return }
                if let rotation = r as? UIRotationGestureRecognizer {
                    if rotation.state == .changed {
                        guard let rotationView = rotation.view else { return }
                        weakSelf.transform = rotationView.transform.rotated(by: rotation.rotation)
                        rotation.rotation = 0 // 归零
                    }
                }
            })
        }
        return axc_addGesture(UIRotationGestureRecognizer(block))
    }
}

// MARK: - 决策判断
public extension UIView {
    // MARK: 点
    /// 判断这个点是否包含在本视图范围内
    func axc_isContains(to point: CGPoint) -> Bool { return self.bounds.contains(point) }
    
    // MARK: 视图
    /// 判断这个视图是否包含在本视图范围内
    func axc_isContains(to view: UIView) -> Bool { return self.bounds.contains(view.bounds) }
    /// 判断两个视图是否有交错
    func axc_isIntersects(to view: UIView) -> Bool { return bounds.intersects(view.bounds) }
}
