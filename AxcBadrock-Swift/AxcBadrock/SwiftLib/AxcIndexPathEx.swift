//
//  AxcIndexPathEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/10.
//

import Foundation


// MARK: - 数据转换
public extension IndexPath {
    /// 转换成元组 (section,row)
    var axc_tuplesValue: (Int,Int) {
        return (self.section,self.row)
    }
    /// 转换成字符串 "section-row"
    var axc_strValue: String {
        return "\(self.section)-\(self.row)"
    }
}

// MARK: - 类方法/属性
public extension IndexPath {
    /// 直接实例化一个row，section = 0
    init(row: Int) {
        self = IndexPath(row: row, section: 0)
    }
    /// 直接实例化一个section，row = 0
    init(section: Int) {
        self = IndexPath(row: 0, section: section)
    }
    /// 直接获取0，0
    static var axc_zero: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
}

// MARK: - 属性 & Api
public extension IndexPath {
}

// MARK: - 决策判断
public extension IndexPath {
    /// 是否都是0
    var axc_isZero: Bool { return self == IndexPath.axc_zero }
    /// 是否是第一组
    var axc_isFirstSection: Bool { return self.section == 0 }
    /// 是否是第一行
    var axc_isFirstRow: Bool { return self.row == 0 }
    
}
