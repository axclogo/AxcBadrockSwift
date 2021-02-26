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

    let progress = AxcProgressView()
    override func makeUI() {
        
//        progress.axc_startDirection = [.top, .left, .bottom]
//        progress.axc_startDirection = [.top, .right, .bottom]
//        progress.axc_startDirection = [.left, .bottom, .right]
//        progress.axc_startDirection = [.center]
        progress.backgroundColor = UIColor.gray
        view.addSubview(progress)
        progress.axc.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(100)
        }
        
//        AxcGCD.timer(60) { [weak self] in
//            guard let weakSelf = self else { return }
//            weakSelf.pp += 0.1
//            if weakSelf.pp > 1 {
//                weakSelf.pp = 0
//            }
//
//            weakSelf.progress.axc_progress = weakSelf.pp
//        }
        
    }
    var pp: CGFloat = 0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let p = CGFloat(arc4random() % 100) / 100
//        progress.axc_progress = p
//        print(p)

        let web = AxcWebVC("https://blog.csdn.net/weixin_43364994/article/details/102684626".axc_url!)
        web.axc_isUseCustomNavBar = true
        axc_pushViewController(web)
        
    }

}
