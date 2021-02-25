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
//    let vvv = AxcTextField(CGRect(x: 10, y: 100, width: 300, height: 45))
    override func makeUI() {
//        var array = [(String?, UIImage?)]()
//        for idx in 0..<4 {
//            array.append(("\(idx)",nil))
//        }
//        let se = AxcSegmentedControl(array) { (control, idx) in
//            print(idx)
//        }
//        axc_addSubView(se)
//        se.axc.makeConstraints { (make) in
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.height.equalTo(45)
//            make.top.equalTo(100)
//        }
        let scvc = AxcPageScrollController()
        
        
    }

    var isop = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}
