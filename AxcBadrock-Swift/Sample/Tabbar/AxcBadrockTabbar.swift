//
//  AxcBadrockTabbar.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

class AxcBadrockTabbar: AxcBaseTabbarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func makeUI() {
        
        axc_addTabItem(AxcTabItem(className: "ScrollTestVC", title: "page示例", selectedImgColor: UIColor.systemBlue))
        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例2", selectedImgColor: UIColor.systemBlue))
        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例3", selectedImgColor: UIColor.systemBlue))

    }

}
