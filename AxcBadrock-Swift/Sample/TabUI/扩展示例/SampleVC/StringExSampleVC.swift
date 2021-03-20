//
//  StringExSampleVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/20.
//

import UIKit

class StringExSampleVC: AxcBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let aaa = "123".axc_aesEncryptBase64Str(.ebc("1234123412341234"))
        
        let eee =  aaa?.axc_aesDecryptBase64Str(.ebc("1234123412341234"))
        
        print(aaa)
    }
    


}
