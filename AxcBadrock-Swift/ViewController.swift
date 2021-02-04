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
        
        let color = Axc_RGB(1, 2, 3)
        print(color)
        
        
    }
//    @discardableResult
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let bol = "12345564" - "4"
    
        
        let range = bol.axc_nsRange
        
        
        let aaa =  3 *^ 2
        
        
        let ff: CGFloat = 12
//        ff.axc_abs
        
        
        let dd: Int = 12
        dd.axc_abs
        
//        12.abs
        
        print(bol)
    }

}

