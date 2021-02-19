//
//  AxcBaseTabbarController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit


class AxcBaseTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    func config() {
        view.backgroundColor = UIColor.white
        
        
        axc_addTabItem( AxcTabItem(selectedImg: UIImage.axc_appIcon) )
        axc_addTabItem( AxcTabItem() )
        axc_addTabItem( AxcTabItem() )
        axc_addTabItem( AxcTabItem() )
        
        axc_itemNormalTextColor(UIColor.red)
        axc_itemSelectedTextColor(UIColor.green)
        
        axc_itemNormalImageColor(UIColor.red)
        axc_itemSelectedImageColor(UIColor.green)
//        tabBar.tintColor = nil
        
        axc_itemBadge(text: "12", 1)

    }
}
