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
        vieww.frame = .init((10,50,345,44))
        vieww.layer.borderWidth = 0.5
        vieww.axc_borderColor = .purple
        vieww.layer.cornerRadius = 5
        vieww.font = 14.axc_font
        vieww.attributedPlaceholder = "如：木工、钢筋工、水泥工".axc_attributedStr.axc_setTextColor("#999999".axc_color)
        vieww.axc_setMaxLength(3) { (text) in
            
        }
        
        vieww.axc_leftSpacing(5)


//        let btn = AxcButton()
//        btn.backgroundColor = .axc_random
//        btn.frame = CGRect((0,0,30,44))
        
        let rightView = UIView()
        rightView.backgroundColor = .red
        let rightSubView = UIView()
        rightView.addSubview(rightSubView)
        rightSubView.axc_size = 44.axc_cgSize
//        rightSubView.axc.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        
        vieww.axc_addView(direction: .left, view: rightView, viewSize: CGSize((44,44)), spacing: 10)
        
        
        self.view.addSubview(vieww)
        
        
//        UIRectCorner
        
    }
    
    let vieww = MyTF()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        vieww.rightView?.axc_printSubviewsLevel()
        
        axc_pushViewController(ProjectVC())
        
    }
    
}

class MyTF: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        
        return rect
    }
}
