//
//  AxcBaseVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

class AxcBaseViewController: UIViewController,
                             AxcBaseClassMakeUIProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() { }

}
