//
//  AxcFixedWidthIntegerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/19.
//

import UIKit

/**
 Swift4.0 新特性:
                +-------------+   +-------------+
        +------>+   Numeric   |   | Comparable  |
        |       |   (+,-,*)   |   | (==,<,>,...)|
        |       +------------++   +---+---------+
        |                     ^       ^
+-------+------------+        |       |
|    SignedNumeric   |      +-+-------+-----------+
|     (unary -)      |      |    BinaryInteger    |
+------+-------------+      |(words,%,bitwise,...)|
       ^                    ++---+-----+----------+
       |         +-----------^   ^     ^---------------+
       |         |               |                     |
+------+---------++    +---------+---------------+  +--+----------------+
|  SignedInteger  |    |  FixedWidthInteger      |  |  UnsignedInteger  |
|                 |    |(endianness,overflow,...)|  |                   |
+---------------+-+    +-+--------------------+--+  +-+-----------------+
                ^        ^                    ^       ^
                |        |                    |       |
                |        |                    |       |
                 ++--------+-+                +-+-------+-+
                 |Int family |-+              |UInt family|-+
                 +-----------+ |              +-----------+ |
                   +-----------+                +-----------+
 */

// MARK: - 数据转换
public extension FixedWidthInteger {
    // MARK: 基础转换
    /// 角度转弧度
    var axc_angleToRadian: Float { return Float(self).axc_angleToRadian }

    /// 弧度转角度
    var axc_radianToAngle: Float { return Float(self).axc_radianToAngle }
    
    
    // MARK: UIKit转换
    /// 转换成UIFont
    var axc_font: UIFont { return UIFont.systemFont(ofSize: CGFloat(self)) }
    
    /// 转换成CGRect
    var axc_cgRect: CGRect { return CGRect(CGFloat(self)) }
    
    /// 转换成CGPoint
    var axc_cgPoint: CGPoint { return CGPoint(CGFloat(self)) }
    
    /// 转换成CGSize
    var axc_cgSize: CGSize { return CGSize(CGFloat(self)) }
    
    /// 转换成UIEdgeInsets
    var axc_uiEdge: UIEdgeInsets { return UIEdgeInsets(CGFloat(self)) }
}

// MARK: - 操作符
public extension FixedWidthInteger {
    /// 获取固定长度整数的第几位，个十百千万
    ///
    ///     let value = 123456789[3] -> value = 6
    ///
    subscript(axc_idx: Int) -> Self {
        var decimalBase: Self = 1
        for _ in 1...axc_idx {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
