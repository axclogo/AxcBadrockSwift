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
        
        let module = AxcSolidNetModule("主模块", urls: [
                                        (title: "主站1", url: "www.baidu.com"),
                                        (title: "主站2", url: "www.baidu.com"),
                                        (title: "主站3", url: "www.baidu.com")])
        AxcSolidNet.shared.axc_addModule( module )
        
    }
    
    override func makeUI() {
        
        axc_addTabItem(AxcTabItem(className: "ScrollTestVC", title: "page示例", selectedImgColor: UIColor.systemBlue))
        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例2", selectedImgColor: UIColor.systemBlue))
        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例3", selectedImgColor: UIColor.systemBlue))

    }

}
