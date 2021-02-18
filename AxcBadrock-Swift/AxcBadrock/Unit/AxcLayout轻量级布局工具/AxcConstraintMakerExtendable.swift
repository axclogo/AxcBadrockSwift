//
//  AxcConstraintMakerExtendable.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

    import UIKit


public class AxcConstraintMakerExtendable: AxcConstraintMakerRelatable {
    
    public var left: AxcConstraintMakerExtendable {
        self.description.attributes += .left
        return self
    }
    
    public var top: AxcConstraintMakerExtendable {
        self.description.attributes += .top
        return self
    }
    
    public var bottom: AxcConstraintMakerExtendable {
        self.description.attributes += .bottom
        return self
    }
    
    public var right: AxcConstraintMakerExtendable {
        self.description.attributes += .right
        return self
    }
    
    public var leading: AxcConstraintMakerExtendable {
        self.description.attributes += .leading
        return self
    }
    
    public var trailing: AxcConstraintMakerExtendable {
        self.description.attributes += .trailing
        return self
    }
    
    public var width: AxcConstraintMakerExtendable {
        self.description.attributes += .width
        return self
    }
    
    public var height: AxcConstraintMakerExtendable {
        self.description.attributes += .height
        return self
    }
    
    public var centerX: AxcConstraintMakerExtendable {
        self.description.attributes += .centerX
        return self
    }
    
    public var centerY: AxcConstraintMakerExtendable {
        self.description.attributes += .centerY
        return self
    }
    
    public var lastBaseline: AxcConstraintMakerExtendable {
        self.description.attributes += .lastBaseline
        return self
    }
    public var firstBaseline: AxcConstraintMakerExtendable {
        self.description.attributes += .firstBaseline
        return self
    }
    public var leftMargin: AxcConstraintMakerExtendable {
        self.description.attributes += .leftMargin
        return self
    }
    public var rightMargin: AxcConstraintMakerExtendable {
        self.description.attributes += .rightMargin
        return self
    }
    public var topMargin: AxcConstraintMakerExtendable {
        self.description.attributes += .topMargin
        return self
    }
    public var bottomMargin: AxcConstraintMakerExtendable {
        self.description.attributes += .bottomMargin
        return self
    }
    public var leadingMargin: AxcConstraintMakerExtendable {
        self.description.attributes += .leadingMargin
        return self
    }
    public var trailingMargin: AxcConstraintMakerExtendable {
        self.description.attributes += .trailingMargin
        return self
    }
    public var centerXWithinMargins: AxcConstraintMakerExtendable {
        self.description.attributes += .centerXWithinMargins
        return self
    }
    public var centerYWithinMargins: AxcConstraintMakerExtendable {
        self.description.attributes += .centerYWithinMargins
        return self
    }
    
    public var edges: AxcConstraintMakerExtendable {
        self.description.attributes += .edges
        return self
    }
    public var horizontalEdges: AxcConstraintMakerExtendable {
        self.description.attributes += .horizontalEdges
        return self
    }
    public var verticalEdges: AxcConstraintMakerExtendable {
        self.description.attributes += .verticalEdges
        return self
    }
    public var directionalEdges: AxcConstraintMakerExtendable {
        self.description.attributes += .directionalEdges
        return self
    }
    public var directionalHorizontalEdges: AxcConstraintMakerExtendable {
        self.description.attributes += .directionalHorizontalEdges
        return self
    }
    public var directionalVerticalEdges: AxcConstraintMakerExtendable {
        self.description.attributes += .directionalVerticalEdges
        return self
    }
    public var size: AxcConstraintMakerExtendable {
        self.description.attributes += .size
        return self
    }
    public var margins: AxcConstraintMakerExtendable {
        self.description.attributes += .margins
        return self
    }
    public var directionalMargins: AxcConstraintMakerExtendable {
      self.description.attributes += .directionalMargins
      return self
    }
    public var centerWithinMargins: AxcConstraintMakerExtendable {
        self.description.attributes += .centerWithinMargins
        return self
    }
    
}
