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
        let keyiv = "1234123412341234"
        
        let eee = "1234567890zxcasd".axc_3desEncryptBase64Str(.cbc(keyiv, iv: keyiv))
        
        let ddd = eee?.axc_3desDecryptBase64Str(.cbc(keyiv, iv: keyiv))
        
        print(eee)
        
    }
    
    
}

