//
//  ProjectVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

class ProjectVC: AxcBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func makeUI() {
        
        
        let vvv = AxcBaseView()
        axc_addSubView(vvv)
        
    }

    
    var isop = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       axc_pushViewController(FilterDetailsVC())
    }

}
