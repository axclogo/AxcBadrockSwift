//
//  ViewController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/1/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let color = AxcRGB(1, 2, 3)
        print(color)
        
        
    }
//    @discardableResult
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let bol = "12345564" - "4"
        let ff: Double = √9
        let _ = √ff
        
        let sss: Int = 5
        sss.axc_power(2)
        let bbbbb = sss *^ 2
        print(bbbbb)
    }

}

