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
    let btn = AxcButton( (100,100,100,100) )

    override func makeUI() {
        
        btn.axc_cornerRadius = 10
        btn.axc_borderWidth = 1
        btn.axc_borderColor = UIColor.purple
        btn.backgroundColor = UIColor.white
        view.addSubview(btn)
        btn.axc.makeConstraints { (make) in
            make.left.equalTo(view.axc.left).offset(20)
            make.right.equalTo(view.axc.right).offset(-20)
            make.bottom.equalTo(view.axc.bottom).offset(-200)
            make.top.equalTo(view.axc.top).offset(200)
        }
        
//        let _view = AxcBaseView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
////        _view.axc_backgroundImage("yupao".axc_sourceImage!)
//        _view.axc_gradient(colors: [UIColor.red,UIColor.purple])
//        view.addSubview(_view)
//        _view.axc.makeConstraints { (make) in
//            make.top.equalTo(60)
//            make.left.equalTo(10)
//            make.right.equalTo(20)
//            make.height.equalTo(200)
//        }
        
//        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
////        btn.axc_backgroundImage("yupao".axc_sourceImage!)
//        btn.setTitle("123", for: .normal)
//        btn.setTitleColor(UIColor.black, for: .normal)
//        btn.setImage( UIImage.axc_appIcon , for: .normal)
////        btn.axc_cornerRadius = 10
////        btn.axc_borderColor = UIColor.blue
////        btn.axc_borderWidth = 1
//        view.addSubview(btn)
//
//
//        btn.axc.makeConstraints { (make) in
//            make.left.equalTo(50)
//            make.right.equalTo(-50)
//            make.top.equalTo(100)
//            make.height.equalTo(150)
//        }
//
//        btn.axc_badgeDirection( [.top, . right] )
//        for i in 0...100 {
//            AxcGCD.delay(0.1 * i.axc_doubleValue) {
//                btn.axc_badgeValue("\(arc4random()%10000)")
//            }
//        }
//
//        btn.axc_borderLineDirection( [.left, .right , .top] )
//        btn.axc_borderLineWidth(5, direction: [.right, .bottom])

//        btn.axc_borderLineColor( UIColor.green )
        
//        AxcGCD.delay(2) {
//            btn.axc_badgeValue("150333")
//            btn.axc_badgeDirection( [.bottom, .right] )
//        }
//        AxcGCD.delay(4) {
//            btn.axc_badgeValue("11")
//        }
        
//        let ba = AxcBadgeLabel()
//        ba.text = "1\n哈哈1234"
//        ba.center = view.center
//        ba.axc_gradient(colors: [UIColor.systemBlue,UIColor.systemTeal])
//        view.addSubview(ba)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        axc_pushViewController(ViewController(), completion: {
//            print("push end")
//        })
        btn.textLabel.contentAlignment = [.right ]
        btn.textLabel.textAlignment = .center
        
        btn.contentLayout = .textLeft_imgRight
    }

}
