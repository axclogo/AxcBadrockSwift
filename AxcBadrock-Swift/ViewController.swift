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
//        print(CIFilter(name: "CIBoxBlur")?.attributes)
        
        let image = UIImage(named: "yupao")?
            .axc_stylizeStyleFilter         // 选择滤镜类型
            .axc_convolution3x3Filter
            .axc_uiImage            // 获取输出的UIImage
        
        let imageView = UIImageView(image:image)
        imageView.frame = CGRect(x: 5, y: 50, width: Axc_screenWidth - 10, height: 200)
        view.addSubview(imageView)
        
        
        let image2 = UIImage(named: "yupao")?
            .axc_stylizeStyleFilter         // 选择滤镜类型
            .axc_convolution7x7Filter
            .axc_uiImage            // 获取输出的UIImage
        
        let imageView2 = UIImageView(image:image2)
        imageView2.frame = CGRect(x: 5, y: 280, width: Axc_screenWidth - 10, height: 200)
        view.addSubview(imageView2)
        
        print("\n\n\n start")

    }
    
    
    
    
    
}

