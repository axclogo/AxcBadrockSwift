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
    
    let contentScrollView = AxcContentScrollView()
    let textView = AxcProtocolControl()
    override func makeUI() {
        
        
        contentScrollView.axc_startPoint = .right
        contentScrollView.backgroundColor = UIColor.lightGray
        contentScrollView.axc_contentScrollNumberBlock = { _ in
            return 6
        }
        contentScrollView.axc_contentScrollViewBlock = { _,idx in
            let view = UIControl()
            view.backgroundColor = UIColor.axc_random
            view.axc_addEvent { (_) in
                print(idx)
            }
            return view
        }
        contentScrollView.axc_contentScrollViewSizeBlock = { _,idx in
            return CGSize(( CGFloat(arc4random()%100+100), 30))
        }
        axc_addSubView(contentScrollView)
        contentScrollView.axc.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        contentScrollView.axc_start()
        
//        "asd".axc_attributedStr[.font] = UIFont.systemFont(ofSize: 12)
        
        
//        textView.axc_text = "代表你同意《直播协议》和《隐私协议》"
//        textView.axc_protocols = [(text: "《直播协议》", url: "https://www.baidu2.com/"),
//                                  (text: "《隐私协议》", url: "https://www.baidu.com/")]
//
//        textView.axc_borderColor = UIColor.purple
//        textView.axc_borderWidth = 5
//        textView.backgroundColor = UIColor.lightGray
//        view.addSubview(textView)
//        textView.axc.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo( CGSize(width: 300, height: 300) )
//        }
//
//        let label  = UILabel()
//        label.frame = CGRect(x: 10, y: 100, width: 300, height: 100)
//        label.numberOfLines = 0
//        label.attributedText = "代表你同意《直播协议》和《隐私协议》所有协议中，需要遵守xxxx协议".axc_mark("协议", attributes: [.foregroundColor : UIColor.purple])
//        view.addSubview(label)
        
//        let imageView = UIImageView()
//        imageView.frame = CGRect(x: 5, y: 50, width: Axc_screenWidth - 10, height: 200)
//        UIImage(named: "demo")?
//            .axc_blurStyleFilter
//            .axc_boxBlurFilter
//            .axc_asyncUIImage({ (img) in
//                imageView.image = img
//                print("\n\n\n Rada")
//            })
////        var image = AxcBadrockBundle.image(name: "badrock_placeholder")
////        image = image.axc_tintColor( "ff0000".axc_color ) ?? UIImage()
//        axc_addSubView(imageView)
    }

    override func axc_navBarBack(_ sender: Any?) {
        contentScrollView.axc_stop()
        super.axc_navBarBack(sender)
    }
    
    var pp: Bool = false
    let animation = CAKeyframeAnimation(.transform_translation_x)
        .axc_setValues( [0,12,-12,9,-9,6,-6,0] )
        .axc_setEndBlock { (a, b) in
            print(a)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        axc_pushViewController(ProjectVC())
        
//        axc_presentPickerView(dataList: ["1","1","1","1"]) { (_, _) in
//            print("111")
//        }
        
   
//            .axc_setStartBlock({ (an) in
//                print(an)
//            })
//            .axc_setEndBlock { (anima, flas) in
//                print(anima)
//            }
//        textView.layer.axc_addAnimation(animation, key: "asd")
        
//        pp = !pp
//        textView.axc_animateBorderWidth(isIn: pp)
        
        textView.axc_makeCAAnimation { (make) in
            make.addAnimation( AxcAnimationManager.axc_remindBorderColor(fromColor: UIColor.purple, toColor: UIColor.systemRed) )
            
            
//            make.keyframeAnimation(.opacity)
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
        }
    }

}
