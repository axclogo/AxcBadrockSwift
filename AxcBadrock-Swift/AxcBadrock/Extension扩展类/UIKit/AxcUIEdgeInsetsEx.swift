//
//  AxcUIEdgeInsetsEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// MARK: - 类方法/属性
public extension UIEdgeInsets {
    /// 设置所有边距
    init(_ all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
}

// MARK: - 属性 & Api
public extension UIEdgeInsets {
    /// 获取水平值
    var axc_horizontal: CGFloat {
        return left + right
    }
    /// 获取垂直值
    var axc_verticality: CGFloat {
        return top + bottom
    }
    
    
}
