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
        
    
//        view.addSubview(scrollView)
//        scrollView.axc.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(view.axc_height - 200)
//        }
//
//        progress.axc_startDirection = [.center]
//        progress.backgroundColor = UIColor.gray
//        scrollView.addSubview(progress)
//        progress.axc_progress = 0.5
//        progress.axc.makeConstraints { (make) in
//            make.top.left.equalToSuperview().offset(50)
//            make.size.equalTo(CGSize( ( 300,300 ) ))
//        }
        
        let textView = AxcTextView()
//        textView.backgroundColor = UIColor.lightGray
        view.addSubview(textView)
        textView.axc.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize((300,200)))
        }
        
    }

    
    var pp: Int = 0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}
