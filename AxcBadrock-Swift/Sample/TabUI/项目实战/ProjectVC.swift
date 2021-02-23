//
//  ProjectVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

class ProjectVC: AxcBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    let vvv = AxcTextField(CGRect(x: 10, y: 100, width: 300, height: 45))
    override func makeUI() {
        
        vvv.axc_style = .general
        axc_addSubView(vvv)
        vvv.axc.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(100)
            make.right.equalTo(-10)
            make.height.equalTo(45)
        }
        
        
    }

    var isop = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       axc_pushViewController(FilterDetailsVC())
        
//        vvv.rightButton.titleLabel.text = "获取验证码"
//        vvv.axc_style = .password
    }

}
