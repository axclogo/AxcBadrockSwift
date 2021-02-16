//
//  AxcBadrock.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

/*
 单词缩写规则
 Object     -> Obj
 String     -> Str
 Array      -> Arr
 Dictionary -> Dic
 Parameters -> Param
 
 指定名称命名
 方法 selector
 边框 border
 衰变 decay
 默认 default
 方向 direction
 翻转 flip
 旋转 rotate
 水平 horizontal
 垂直 vertical
 拉伸 tensile
 半径 radius
 圆角 cornerRadius
 压缩 compressed                  取值范围：(0-1)
 平均 average
 透明 opaque
 透明度 alpha
 元组 tuples
 距离 distance
 间距 spacing
 标量 scalar                      取值范围：(0-1)
 角度 angle                       取值范围 0 - 360
 弧度 radian                      取值范围 0 - 2pi
 比值 ratio                       取值范围：(0-1)
 比例缩放 scale                   取值范围：(0-1)
 极大值 max                        无需参考，指内存中能存下最大的极值
 极小值 min                        无需参考，指内存中能存下最小的极值
 自身属性相比下的最大值 bigger         具有参考对比性的描述词汇
 自身属性相比下的最小值 smaller        具有参考对比性的描述词汇
 唯一标识符命名 identifier
 
 private修饰的扩展参数需以_开头，无需前缀
 */


/*
 操作符参数命名规则
 左参数 leftValue
 右参数 rightValue
 中参数 centerValue
 驼峰式、首字母小写、不带前缀、根据方位+Value模式作为命名规范
 */

/*
 mutating命名规则
 能修改自身的函数方法，不得有命名歧义的其他方法
 修改自身函数方法必须唯一
 如有重复方法，须以set区分
 */

/*
 类方法函数命名规则
 axc_后的首字母要大写，采用驼峰式
 */

/*
 全局方法参数命名规则
 全局方法命名，Axc+方法名，驼峰式
 全局参数命名，Axc_+参数名，驼峰式
 */

/*
 struct结构体命名规则
 结构体本身开头大写，驼峰式
 结构体内部参数无需axc前缀
 参数方法均小写开头，驼峰式
 */

/*
 类方法命名规则
 类本身若是以Axc开头，则无需axc前缀
 基类预设方法除初始化方法外，全部统一以base开头
 基类预设参数也如上
 如果基类需要子类实现的方法以及参数，命名则无需任何前缀
 */

import Foundation
