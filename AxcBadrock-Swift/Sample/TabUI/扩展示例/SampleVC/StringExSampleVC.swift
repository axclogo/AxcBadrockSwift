//
//  StringExSampleVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/20.
//

import UIKit

import CommonCrypto

class StringExSampleVC: AxcBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyiv = "123456789012345678901234"
        
        let eee = "19981023zjf".axc_3desEncryptHexStr(.cbc(keyiv, iv: "12345678"))
        
        let ddd = eee?.axc_3desDecryptHexStr(.cbc(keyiv, iv: "12345678"))
        
        print(eee)
        
    }
    
    
}

