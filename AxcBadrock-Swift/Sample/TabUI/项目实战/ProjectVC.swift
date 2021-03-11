//
//  ProjectVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

@objc class ProjectVC: AxcBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let contentScrollView = AxcTextScrollView()

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        date.axc_depthTraversalSubviews { (view) in
////            if let label = view as? UILabel {
////                label.font = 12.axc_font
////                label.textColor = .red
////            }
//            print("\(AxcClassFromString(view))\n")
//        }
//        date.axc_printDepthTraversalSubviews()
    }
    
    let imageV = AxcButton()

    let imageV2 = UIImageView()
    
    let borderView = UIView(CGRect(50))
    
    override func makeUI() {
        
        let image = "demo".axc_image
        
//        imageV.image = image
        
        imageV.axc_isTouchMaskFeedback = true
        imageV.axc_isTouchVibrationFeedback = true
//        imageV.axc_touchVibrationStyle = .
        imageV.axc_isTouchMaskAnimation = true
        
        
//        imageV.axc_touchVibrationStyle = .
        imageV.axc_touchMaskAnimationBlock = { (view, isIn) in
            view.axc_animateScaleHorizontal(isIn: isIn, 0.2)
//            view.axc_makeCAAnimation { (make) in
//
//            }
//            UIView.animate(withDuration: 0.3) {
//                <#code#>
//            }
        }
        imageV.isUserInteractionEnabled = true
        imageV.backgroundColor = .systemRed
        axc_addSubView(imageV)
        imageV.axc.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(300)
        }
        
        borderView.axc_borderColor = .red
        borderView.axc_borderWidth = 1
        borderView.axc_addPanGesture()
        axc_addSubView(borderView)
        
        
        imageV2.axc_isTouchMaskFeedback = true
        imageV2.axc_isTouchVibrationFeedback = true
        imageV2.axc_isTouchMaskAnimation = false
        imageV2.isUserInteractionEnabled = true
        imageV2.backgroundColor = UIColor.lightGray
        imageV2.contentMode = .scaleAspectFit
        axc_addSubView(imageV2)
        imageV2.axc.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(imageV.axc.bottom).offset(20)
            make.height.equalTo(200)
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let image2 = imageV.image?.axc_cropping( 200.axc_uiEdge )
//        imageV2.image = image2
    }

}
