//
//  AxcVCFadeAnimation.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

/// 下方拉起式动画
public class AxcAlentPullUpAnimation: AxcBaseVCAnimationTransitioning {
    // 出现转场
    override func presentAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let alentVC = transitionContext.viewController(forKey: .to) as? AxcAlentVC else { return }
        guard let contentView = alentVC.axc_contentView else { return }
        // 添加进展示视图
        alentVC.view.axc_origin = CGPoint.zero
        alentVC.view.axc_size = CGSize(( Axc_screenWidth, Axc_screenHeight ))
        
        transitionContext.containerView.addSubview(alentVC.view)
        alentVC.view.axc.makeConstraints { (make) in make.edges.equalTo(0) }
        // 设置初始值
        alentVC.view.alpha = 0
        contentView.transform = CGAffineTransform(translationX: 0, y: alentVC.view.axc_height)

        UIView.animate(withDuration: alentVC.axc_presentDuration, delay: 0,
                       usingSpringWithDamping: alentVC.axc_usingSpringWithDamping,
                       initialSpringVelocity: 15, options: .curveEaseInOut) {
            alentVC.view.alpha = 1
            let difference = alentVC.view.axc_height - contentView.axc_height
            switch alentVC.axc_preferredStyle {
            case .alent:
                contentView.transform = CGAffineTransform(translationX: 0, y: difference / 2)
            case .sheet:
                contentView.transform = CGAffineTransform(translationX: 0, y: 0 )
            }
        } completion: { (_) in
            transitionContext.completeTransition(true)
        }
    }
    // 消失转场
    override func dismissAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let alentVC = transitionContext.viewController(forKey: .from) as? AxcAlentVC else { return }
        guard let contentView = alentVC.axc_contentView else { return }
        // 设置初始值
        alentVC.view.alpha = 1
        UIView.animate(withDuration: alentVC.axc_dismissDuration, delay: 0,
                       usingSpringWithDamping: alentVC.axc_usingSpringWithDamping,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            alentVC.view.alpha = 0
            switch alentVC.axc_preferredStyle {
            case .alent:
                contentView.transform = CGAffineTransform(translationX: 0, y: alentVC.view.axc_height)
            case .sheet:
                contentView.transform = CGAffineTransform(translationX: 0, y: alentVC.view.axc_height)
            }
        } completion: { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
