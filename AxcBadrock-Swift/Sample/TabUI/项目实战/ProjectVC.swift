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

        cameraView.backgroundColor = .lightGray
        axc_addSubView(cameraView)
        cameraView.axc.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(200)
        }
        cameraView.axc_start()
        
        imageView.backgroundColor = .lightGray
        axc_addSubView(imageView)
        imageView.axc.makeConstraints { (make) in
            make.top.equalTo(cameraView.axc.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(200)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cameraView.axc_shooting { [weak self] (image, _) in
            guard let weakSelf = self else { return }
            weakSelf.imageView.image = image
        }
    }
    
}
