//
//  AxcConstraintMaker.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

public class AxcConstraintMaker {
    public var left: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.left)
    }
    public var top: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.top)
    }
    public var bottom: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.bottom)
    }
    public var right: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.right)
    }
    public var leading: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leading)
    }
    public var trailing: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailing)
    }
    public var width: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.width)
    }
    public var height: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.height)
    }
    public var centerX: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerX)
    }
    public var centerY: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerY)
    }
    public var lastBaseline: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.lastBaseline)
    }
    public var firstBaseline: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.firstBaseline)
    }
    public var leftMargin: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leftMargin)
    }
    public var rightMargin: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.rightMargin)
    }
    public var topMargin: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.topMargin)
    }
    public var bottomMargin: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.bottomMargin)
    }
    public var leadingMargin: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leadingMargin)
    }
    public var trailingMargin: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailingMargin)
    }
    public var centerXWithinMargins: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerXWithinMargins)
    }
    public var centerYWithinMargins: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerYWithinMargins)
    }
    
    public var edges: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.edges)
    }
    public var horizontalEdges: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.horizontalEdges)
    }
    public var verticalEdges: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.verticalEdges)
    }
    public var directionalEdges: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalEdges)
    }
    public var directionalHorizontalEdges: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalHorizontalEdges)
    }
    public var directionalVerticalEdges: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalVerticalEdges)
    }
    public var size: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.size)
    }
    public var center: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.center)
    }
    
    public var margins: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.margins)
    }
    public var directionalMargins: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalMargins)
    }
    public var centerWithinMargins: AxcConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerWithinMargins)
    }
    
    private let item: AxcLayoutConstraintItem
    private var descriptions = [AxcConstraintDescription]()
    
    internal init(item: AxcLayoutConstraintItem) {
        self.item = item
        self.item.prepare()
    }
    
    internal func makeExtendableWithAttributes(_ attributes: AxcConstraintAttributes) -> AxcConstraintMakerExtendable {
        let description = AxcConstraintDescription(item: self.item, attributes: attributes)
        self.descriptions.append(description)
        return AxcConstraintMakerExtendable(description)
    }
    
    internal static func prepareConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) -> [AxcConstraint] {
        let maker = AxcConstraintMaker(item: item)
        closure(maker)
        var constraints: [AxcConstraint] = []
        for description in maker.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
        return constraints
    }
    
    internal static func makeConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) {
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: false)
        }
    }
    
    internal static func remakeConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) {
        self.removeConstraints(item: item)
        self.makeConstraints(item: item, closure: closure)
    }
    
    internal static func updateConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) {
        guard item.constraints.count > 0 else {
            self.makeConstraints(item: item, closure: closure)
            return
        }
        
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: true)
        }
    }
    
    internal static func removeConstraints(item: AxcLayoutConstraintItem) {
        let constraints = item.constraints
        for constraint in constraints {
            constraint.deactivateIfNeeded()
        }
    }
    
}
