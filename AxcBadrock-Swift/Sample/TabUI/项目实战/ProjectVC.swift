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
        
//        "asd".axc_attributedStr[.font] = UIFont.systemFont(ofSize: 12)
        
        
        let textView = AxcProtocolControl()
        textView.axc_text = "代表你同意《直播协议》和《隐私协议》"
        textView.axc_protocols = [(text: "《直播协议》", url: "https://www.baidu2.com/"),
                                  (text: "《隐私协议》", url: "https://www.baidu.com/")]
        
//        textView.backgroundColor = UIColor.lightGray
        view.addSubview(textView)
        textView.axc.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize((300,40)))
        }
        
    }

    
    var pp: Int = 0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}
