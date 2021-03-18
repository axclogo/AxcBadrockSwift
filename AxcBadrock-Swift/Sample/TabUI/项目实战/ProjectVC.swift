//
//  ProjectVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

@objc class ProjectVC: AxcBaseVC {
    
    let cameraView = AxcCameraView()
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        cameraView.backgroundColor = .lightGray
//        axc_addSubView(cameraView)
//        cameraView.axc.makeConstraints { (make) in
//            make.top.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.height.equalTo(200)
//        }
//        cameraView.axc_start()
//
//        imageView.backgroundColor = .lightGray
//        axc_addSubView(imageView)
//        imageView.axc.makeConstraints { (make) in
//            make.top.equalTo(cameraView.axc.bottom).offset(-10)
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.height.equalTo(200)
//        }
//        vieww.frame = .init((10,50,345,44))
//        vieww.layer.borderWidth = 0.5
//        vieww.axc_borderColor = .purple
//        vieww.layer.cornerRadius = 5
//        vieww.font = 14.axc_font
//        vieww.attributedPlaceholder = "如：木工、钢筋工、水泥工".axc_attributedStr.axc_setTextColor("#999999".axc_color)
//        vieww.axc_setMaxLength(3) { (text) in
            
//        viewwwww.backgroundColor = .white
//        viewwwww.axc_scrollDirection = .vertical
//        viewwwww.axc_textBannerNumberBlock = { _ in
//            return 5
//        }
//        viewwwww.axc_textBannerTextBlock = {_,_ in
//            return "asdasdasdasd"
//        }
//        viewwwww.axc_start()
//
//        axc_addSubView(viewwwww)
//        viewwwww.axc.makeConstraints { (make) in
//            make.top.equalTo(10)
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.height.equalTo(200)
//        }
        
        let btn = UIButton()
        btn.frame = CGRect((100,50,50,50))
        btn.backgroundColor = .systemRed
        btn.axc_cornerRadius = btn.axc_size.axc_smallerValue / 4
        axc_addSubView(btn)
        btn.axc_addEvent { (sender) in
            
            guard let button = sender as? UIButton else { return }
            button.isSelected = !button.isSelected
            
            let scaleAnimation = CASpringAnimation(.transform_scale)
            let radiusAnimation = CASpringAnimation(.cornerRadius).axc_setRemovedOnCompletion(false)
            if button.isSelected { // 选中
                scaleAnimation.axc_setFromValue(1).axc_setToValue(0.7)
                radiusAnimation.axc_setFromValue(button.axc_size.axc_smallerValue / 4)
                    .axc_setToValue(button.axc_size.axc_smallerValue / 2)
            }else{
                scaleAnimation.axc_setFromValue(0.7).axc_setToValue(1)
                radiusAnimation.axc_setFromValue(button.axc_size.axc_smallerValue / 2)
                    .axc_setToValue(button.axc_size.axc_smallerValue / 4)
            }
            let group = CAAnimationGroup()
                .axc_addAnimation( scaleAnimation )
                .axc_addAnimation( radiusAnimation )
                .axc_setDuration(0.5)
                .axc_setFillMode(.forwards)             // 保留最后状态
                .axc_setRemovedOnCompletion(false)      // 完成后不移除
            
            button.axc_makeCAAnimation { (make) in
                make.addAnimation(radiusAnimation)
            }
            
        }
        
//        let btn = AxcButton()
//                btn.setImage(themeBackArrowImage, for: .normal)
        
//        let btn = AxcButton(title: title, image: themeBackArrowImage)
//        btn.axc_contentInset = UIEdgeInsets.zero
//        btn.axc_style = .img
//
//        let customView = AxcBaseView(CGRect(x: 0, y: 0, width: 30, height: 30))
//        customView.backgroundColor = UIColor.lightGray
//        btn.axc_size = customView.axc_size
//        btn.axc_origin = 0.axc_cgPoint
//        customView.addSubview(btn)
//        //        btn.frame = customView.bounds
//
//        let item = UIBarButtonItem(customView: customView)
//        item.width = customView.axc_width
//        self.navigationItem.setLeftBarButtonItems([item], animated: true)
//        customView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        axc_addNavBarItem(image: themeBackArrowImage, size: 30.axc_cgSize) { (_) in
            print("123123123")
        }
        
    }
    private var themeBackArrowImage: UIImage {
        guard let _themeBackArrowImage = backArrowImage.axc_tintColor(AxcBadrock.shared.backImageColor) else { return backArrowImage }
        return _themeBackArrowImage
    }
    
    private var backArrowImage: UIImage = AxcBadrockBundle.arrowLeftImage

let viewwwww = AxcTextBannerView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewwwww.axc_stop()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        axc_pushViewController(ProjectVC())
        
    }
    
}
