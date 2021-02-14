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
        
        let ciImg_1 = CIImage(cgImage: ("test".axc_sourceImage?.cgImage)! )
        let ciImg_2 = CIImage(cgImage: ("yupao".axc_sourceImage?.cgImage)! )
        let ciImg_3 = CIImage(cgImage: ("loukong".axc_sourceImage?.cgImage)! )
        
        
        print("\n\n\n start")
        
        let imageView = UIImageView()

        UIImage(named: "test")?
            .axc_gradientStyleFilter
            .axc_smoothLinearFilter
            .axc_asyncUIImage({ (img) in
                imageView.image = img
                print("\n\n\n Rada")
            })
        
        imageView.backgroundColor = UIColor.yellow
        imageView.frame = CGRect(x: 5, y: 50, width: Axc_screenWidth - 10, height: 200)
        view.addSubview(imageView)
        
        
        let imageView2 = UIImageView()
        
        UIImage(named: "test")?
            .axc_gradientStyleFilter         // 选择滤镜类型
            .axc_radialGradientFilter
            
            .axc_asyncUIImage({ (img) in
                imageView2.image = img
                print("\n\n\n Rada2")
            })

        imageView2.backgroundColor = UIColor.yellow
        imageView2.frame = CGRect(x: 5, y: 280, width: Axc_screenWidth - 10, height: 200)
        view.addSubview(imageView2)
        
        print("\n\n\n end")

    }
    
    
    
    
    
}

