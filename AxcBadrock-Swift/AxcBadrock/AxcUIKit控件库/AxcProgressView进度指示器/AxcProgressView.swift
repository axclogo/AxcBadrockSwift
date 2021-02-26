//
//  AxcProgressView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

@IBDesignable
public class AxcProgressView: AxcBaseView {
    // MARK: - 父类重写
    public override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        addSubview(axc_indicator)
        reloadLayout()
    }
    
    // MARK: - Api
    var axc_startDirection: AxcDirection = [.top, .left, .bottom] {
        didSet {
            UIView.animate(withDuration: Axc_duration) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.axc_indicator.axc.remakeConstraints { (make) in
                    if weakSelf.axc_startDirection.contains(.top) && weakSelf.axc_startDirection.contains(.bottom){
                        make.width.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                    }
                    if weakSelf.axc_startDirection.contains(.left) && weakSelf.axc_startDirection.contains(.right){
                        make.height.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                    }
                    if weakSelf.axc_startDirection == .center {
                        make.width.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                        make.height.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                    }
                    if weakSelf.axc_startDirection.contains(.top)    { make.top.equalToSuperview().heightPriority() }
                    if weakSelf.axc_startDirection.contains(.left)   { make.left.equalToSuperview().heightPriority() }
                    if weakSelf.axc_startDirection.contains(.bottom) { make.bottom.equalToSuperview().heightPriority() }
                    if weakSelf.axc_startDirection.contains(.right)  { make.right.equalToSuperview().heightPriority() }
                    if weakSelf.axc_startDirection.contains(.center) { make.center.equalToSuperview().heightPriority() }
                }
                weakSelf.layoutIfNeeded()
            }
        }
    }
    
    /// 设置进度值
    var axc_progress: CGFloat {
        set {
            var progress: CGFloat = 0
            if newValue < 0 { progress = 0 }
            if newValue > 1 { progress = 1 }
            progress = newValue
            _axc_progress = progress
            reloadLayout()
        }
        get { return _axc_progress }
    }
    /// 设置底部颜色
    func axc_setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    /// 设置底部渐变色
    func axc_setBackgroundGradient(colors: [UIColor],
                                   startDirection: AxcDirection  = .left,
                                   endDirection: AxcDirection    = .right,
                                   locations: [CGFloat]? = nil,
                                   type: CAGradientLayerType = .axial) {
        axc_setGradient(colors: colors, startDirection: startDirection,
                        endDirection: endDirection,
                        locations: locations, type: type)
    }
    
    /// 设置进度颜色
    func axc_setIndicatorColor(_ color: UIColor) {
        axc_indicator.backgroundColor = color
    }
    /// 设置底部渐变色
    func axc_setIndicatorGradient(colors: [UIColor],
                                 startDirection: AxcDirection  = .left,
                                 endDirection: AxcDirection    = .right,
                                 locations: [CGFloat]? = nil,
                                 type: CAGradientLayerType = .axial) {
        axc_indicator.axc_setGradient(colors: colors, startDirection: startDirection,
                                  endDirection: endDirection,
                                  locations: locations, type: type)
    }
    public override func reloadLayout() {
        let _axc_startDirection = axc_startDirection
        axc_startDirection = _axc_startDirection
    }
    
    // MARK: 私有
    private var _axc_progress: CGFloat = 0
    
    // MARK: - 懒加载
    /// 指示器视图
    lazy var axc_indicator: AxcBaseView = {
        let view = AxcBaseView()
        view.axc_setGradient()
        return view
    }()
}
