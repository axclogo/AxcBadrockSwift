//
//  AxcUILabel.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import UIKit


public extension UILabel {
    
    func axc_frame(_ rect: CGRect) -> UILabel {
        self.frame = rect
        return self
    }
    func axc_textColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    func axc_font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    func axc_textAlignment(_ textAlignment: NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }
    func axc_attributedText(_ attributedText: NSAttributedString) -> UILabel {
        self.attributedText = attributedText
        return self
    }
    func axc_numberOfLines(_ numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }
    
}
