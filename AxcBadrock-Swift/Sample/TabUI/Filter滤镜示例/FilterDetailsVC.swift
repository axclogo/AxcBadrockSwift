//
//  FilterDetailsVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

class FilterDetailsVC: AxcBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vv = AxcBaseView()
        vv.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        vv.backgroundColor = UIColor.gray
        view.addSubview(vv)
        
        axc_addCustomNavBar()
        axc_addCustomToolBar()
        
//        axc_navBar.backgroundColor = UIColor.gray

        
        
//        let tableView = axc_makeTableView()
//        tableView.backgroundColor = UIColor.lightGray
//        view.addSubview(tableView)
//        tableView.axc.makeConstraints { (make) in
//            make.edges.equalTo(0)
//        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        navigationItem.axc_removeBarItem(idx: 0)
//        axc_popViewController()
            axc_navBar.backgroundColor = AxcColorRGB(CGFloat(arc4random() % 255), CGFloat(arc4random() % 255), CGFloat(arc4random() % 255))
    }

}
