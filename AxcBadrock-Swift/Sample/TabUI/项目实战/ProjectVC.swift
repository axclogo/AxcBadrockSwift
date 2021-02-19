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
    
    override func makeUI() {
        
//        let _view = AxcBaseView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        _view.axc_backgroundImage("yupao".axc_sourceImage!)
//        _view.axc_gradient(colors: [UIColor.red,UIColor.purple],
//                           startDirection: [.left, .top],
//                           endDirection: [.right, .bottom])
//        view.addSubview(_view)
//        _view.axc.makeConstraints { (make) in
//            make.top.equalTo(60)
//            make.left.equalTo(10)
//            make.right.equalTo(20)
//            make.height.equalTo(200)
//        }
        
        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
//        btn.axc_backgroundImage("yupao".axc_sourceImage!)
        btn.setTitle("123", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setImage( UIImage.axc_appIcon , for: .normal)
//        btn.axc_cornerRadius = 10
        btn.axc_borderColor = UIColor.blue
        btn.axc_borderWidth = 1
        btn.axc_badgeValue("0")
        view.addSubview(btn)
        AxcGCD.delay(2) {
            btn.axc_badgeValue("150333")
            btn.axc_badgeDirection()
        }
        AxcGCD.delay(4) {
            btn.axc_badgeValue("11")
        }
        
        let ba = AxcBadgeLabel()
        ba.text = "1\n哈哈1234"
        ba.center = view.center
        ba.axc_gradient(colors: [UIColor.systemBlue,UIColor.systemTeal])
        view.addSubview(ba)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        axc_pushViewController(ViewController(), completion: {
//            print("push end")
//        })
        view.layoutSubviews()
    }

}
