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
        var array = [(String?, UIImage?)]()
        for idx in 0..<4 {
            array.append(("\(idx)",nil))
        }
        let se = AxcSegmentedControl(array) { (control, idx) in
            print(idx)
        }
        axc_addSubView(se)
        se.axc.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(45)
            make.top.equalTo(100)
        }
        
        
        
    }

    var isop = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//       axc_pushViewController(FilterDetailsVC())
        
//        vvv.rightButton.titleLabel.text = "获取验证码"
//        vvv.axc_style = .password
//        let vvv = UIView(CGRect(x: 10, y: 100, width: 300, height: 500))
//        vvv.backgroundColor = UIColor.systemBlue
//
//        let vc = AxcSheetVC(view: vvv)
//        vc.axc_tapBackgroundDismissEnable = true
//        vc.axc_show()
        var array = [String]()
        for idx in 0..<20 {
            array.append("\(idx)")
        }
        axc_presentPickerView("测试", dataList: array, selectedBlock: { (_, idx) in
            print(idx)
        })
        
//        let view = UIView()
//        view.backgroundColor = UIColor.black
//        self.view.addSubview(view)
        
//        view.axc.remakeConstraints { (make) in
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.centerY.centerX.equalToSuperview()
//            make.height.equalTo(200)
//            make.width.lessThanOrEqualTo(100).heightPriority()
////            make.centerX.lessThanOrEqualTo(100).priority(1)
//        }
        
    }

}
