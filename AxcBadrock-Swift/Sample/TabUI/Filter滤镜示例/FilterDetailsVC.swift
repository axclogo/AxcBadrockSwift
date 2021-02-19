//
//  FilterDetailsVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

class FilterDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vv = AxcBaseView()
        vv.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        vv.backgroundColor = UIColor.gray
        view.addSubview(vv)
        
        
    }



}
