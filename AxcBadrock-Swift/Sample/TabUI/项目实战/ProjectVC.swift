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

    let textView = AxcProtocolControl()
    override func makeUI() {
        
//        "asd".axc_attributedStr[.font] = UIFont.systemFont(ofSize: 12)
        
        
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

    
    var pp: Bool = false
    let animation = CAKeyframeAnimation(.transform_translation_x)
        .axc_setValues( [0,12,-12,9,-9,6,-6,0] )
        .axc_setEndBlock { (a, b) in
            print(a)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
//            .axc_setStartBlock({ (an) in
//                print(an)
//            })
//            .axc_setEndBlock { (anima, flas) in
//                print(anima)
//            }
//        textView.layer.axc_addAnimation(animation, key: "asd")
        
        pp = !pp
        pp ? textView.axc_animateFadeOut() : textView.axc_animateFadeIn()
        
//        textView.layer.axc_makeCAAnimation { (make) in
//            make.keyframeAnimation(.transform_translation_x)
//                .axc_setValues( [0,12,-12,9,-9,6,-6,0] )
//                .axc_setStartBlock({ (an) in
//                    print("开始")
//                })
//                .axc_setEndBlock { (anima, flas) in
//                    print("结束")
//                }
//            make.keyframeAnimation(.transform_translation_y)
//                .axc_setDuration(2)
//                .axc_setValues( [0,12,-12,9,-9,6,-6,0] )
//                .axc_setStartBlock({ (an) in
//                    print("开始1")
//                })
//                .axc_setEndBlock { (anima, flas) in
//                    print("结束1")
//                }
//            make.groupAnimation
//                .axc_addAnimation(CAKeyframeAnimation(.transform_translation_y)
//                                    .axc_setValues( [0,12,-12,9,-9,6,-6,0] ))
//                .axc_addAnimation(CAKeyframeAnimation(.transform_translation_x)
//                                    .axc_setValues( [0,12,-12,9,-9,6,-6,0] ))
//                .axc_setDuration(2)
//                .axc_setStartBlock({ (an) in
//                    print("开始-----1")
//                })
//                .axc_setEndBlock { (anima, flas) in
//                    print("结束-----1")
//                }
//        }
    }

}
