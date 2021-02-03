//
//  AxcSignedIntegerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

// MARK: - 属性
extension SignedInteger {
    
    /// SwifterSwift: Absolute value of integer number.
    var abs: Self {
        return Swift.abs(self)
    }

    /// SwifterSwift: Check if integer is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// SwifterSwift: Check if integer is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// SwifterSwift: Check if integer is even.
    var isEven: Bool {
        return (self % 2) == 0
    }

    /// SwifterSwift: Check if integer is odd.
    var isOdd: Bool {
        return (self % 2) != 0
    }
    
}

// MARK: - Api
extension SignedInteger {
    
}
