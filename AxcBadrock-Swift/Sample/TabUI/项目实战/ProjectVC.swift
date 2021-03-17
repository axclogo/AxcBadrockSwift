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
            
        viewwwww.backgroundColor = .white
        viewwwww.axc_scrollDirection = .vertical
        viewwwww.axc_textBannerNumberBlock = { _ in
            return 5
        }
        viewwwww.axc_textBannerTextBlock = {_,_ in
            return "asdasdasdasd"
        }
        viewwwww.axc_start()
        
        axc_addSubView(viewwwww)
        viewwwww.axc.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(200)
        }
        
        
    }
    
let viewwwww = AxcTextBannerView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewwwww.axc_stop()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        axc_pushViewController(ProjectVC())
        
    }
    
}
