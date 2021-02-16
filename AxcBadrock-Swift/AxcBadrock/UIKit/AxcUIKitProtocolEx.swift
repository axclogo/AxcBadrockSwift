//
//  AxcUIKitProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - UIKit公用协议
// MARK: Nib加载协议
/// Nib加载协议，遵循协议后，可以通过Class.axc_loadNib来进行加载
public protocol AxcNibLoadable {}
public extension AxcNibLoadable where Self : UIView {
    /// 通过Nib加载
    static func axc_loadNib(_ nibname: String? = nil, frame: CGRect? = nil) -> Self? {
        let loadName = nibname == nil ? "\(self)" : nibname!
        guard let nibObj = Axc_bundle.loadNibNamed(loadName, owner: nil, options: nil)?.first as? Self else { return nil }
        if let rect = frame { nibObj.frame = rect }
        return nibObj
    }
}
