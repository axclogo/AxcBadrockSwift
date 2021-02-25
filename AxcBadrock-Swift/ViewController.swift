//
//  ViewController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/1/30.
//  封装 继承 多态 颗粒度 重复代码

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        
        let imageView = UIImageView(image: "test".axc_sourceImage )
        imageView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(imageView)
        
        imageView.axc_addPanGesture()
        imageView.axc_addRotationGesture()
        imageView.axc_addPinchGesture()
        
//        let vc = AxcBaseVC()
        
        
                
        
        
//        imageView.axc.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//        }
        
        
        
//        let ciImg_1 = CIImage(cgImage: ("test".axc_sourceImage?.cgImage)! )
//        let ciImg_2 = CIImage(cgImage: ("yupao".axc_sourceImage?.cgImage)! )
//        let ciImg_3 = CIImage(cgImage: ("loukong".axc_sourceImage?.cgImage)! )
        
//        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        label.axc_openLongPressCopy = true
//        view.addSubview(label)
//
//        label.backgroundColor = UIColor.gray
//        label.axc.makeConstraints { (make) in
//            make.left.equalTo(view.axc.left).offset(20)
//            make.right.equalTo(view.axc.right).offset(-20)
//            make.bottom.equalTo(view.axc.bottom).offset(-20)
//            make.top.equalTo(view.axc.top).offset(20)
//        }
//
//        print("\n\n\n start")
//
//        let imageView = UIImageView()

//        UIImage(named: "demo")?
//            .axc_generatorStyleFilter
//            .axc_aztecCodeGeneratorFilter
//            .axc_asyncUIImage({ (img) in
//                imageView.image = img
//                print("\n\n\n Rada")
//            })
//        var image = AxcBadrockBundle.image(name: "badrock_placeholder")
//        image = image.axc_tintColor( "ff0000".axc_color ) ?? UIImage()
//
//        imageView.image = image
//
//        imageView.backgroundColor = UIColor.yellow
//        imageView.frame = CGRect(x: 5, y: 50, width: Axc_screenWidth - 10, height: 200)
//        imageView.axc_addPanGesture()
//        imageView.axc_addPinchGesture()
//        imageView.axc_addRotationGesture()
//        view.addSubview(imageView)
        
        
//        let imageView2 = UIImageView()
//
//        let img =  UIImage(named: "demo")
//
//        UIImage(named: "demo")?
//            .axc_gradientStyleFilter         // 选择滤镜类型
//            .axc_radialGradientFilter
//
//            .axc_asyncUIImage({ (img) in
////                imageView2.image = img
//                print("\n\n\n Rada2")
//            })
//        imageView2.image = img
//        imageView2.backgroundColor = UIColor.yellow
//        imageView2.frame = CGRect(x: 5, y: 280, width: Axc_screenWidth - 200, height: 200)
//        view.addSubview(imageView2)
        
//        print("\n\n\n end")
//
//        AxcLog("warning", level: .warning)
//        AxcLog("fatal", level: .fatal)
//        AxcLog("debug", level: .debug)
//        AxcLog("trace", level: .trace)
//        AxcLog("info", level: .info)

        let v = UIView()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        navigationController?.pushViewController(FilterDetailsVC(), animated: true)
        
        
    }
    
    
    
}

