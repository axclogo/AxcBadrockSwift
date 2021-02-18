//
//  TestTabBarVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit
import RAMAnimatedTabBarController

class TestTabBarVC: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        for i in 0 ... 4 {
            let vc = UIViewController()
            vc.title = "1123"
            let navVC = UINavigationController(rootViewController: vc)  // 包装nav
            let _tabbarItem = UITabBarItem(title: "456", image: "".axc_sourceImage, selectedImage: "".axc_sourceImage)
            navVC.tabBarItem = _tabbarItem;
            addChild(navVC)
        }
        

    }
    


}
