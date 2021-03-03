//
//  AxcPickerView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/23.
//

import UIKit

// MARK: - Block别名
public typealias AxcPickerViewSelectedBlock = (_ pickerView: AxcPickerView, _ index: Int) -> Void
public typealias AxcPickerViewLabelStyleBlock = (_ pickerView: AxcPickerView, _ label: UILabel, _ index: Int) -> Void

// MARK: - 样式扩展带参枚举
public extension AxcPickerView {
    /// 单选视图的样式
    enum Style {
        /// 默认样式
        case `default`
    }
}

// MARK: - AxcPickerView
/// AxcPickerView滚轮单选器
@IBDesignable
public class AxcPickerView: AxcChooseView {
    // MARK: - 初始化
    convenience init(_ title: String? = nil, dataList: [Any], selectedBlock: @escaping AxcPickerViewSelectedBlock) {
        self.init(title)
        axc_dataList = dataList
        axc_selectedBlock = selectedBlock
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 设置Picker的样式
    var axc_pickerStyle: AxcPickerView.Style = .default { didSet { reloadLayout() } }
    
    /// 数据源，仅支持String和NSAttributedString
    var axc_dataList: [Any] = []
 
    /// 选中到指定索引是否带动画
    func axc_selectedIdx(_ idx: Int, animated: Bool = true) {
        pickView.selectRow(idx, inComponent: 0, animated: animated)
    }
    /// 选中索引
    var axc_selectedIdx: Int = 0 {
        didSet { axc_selectedIdx(axc_selectedIdx, animated: false) }
    }
    
    // MARK: 方法
    /// 刷新数据
    func reloadData() { pickView.reloadAllComponents() }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 设置label样式的block
    var axc_labelStyleBlock: AxcPickerViewLabelStyleBlock = { (_,label,_) in
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AxcBadrock.shared.textColor
        label.textAlignment = .center
    }
    /// 选中的回调
    var axc_selectedBlock: AxcPickerViewSelectedBlock = { (picker,index) in
        let className = AxcClassFromString(self)
        AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(picker)\nIndex:\(index)", level: .action)
    }
        
    // MARK: - 父类重写
    public override func makeUI() {
        super.makeUI()
        addSubview(pickView)
        // 刷新布局
        reloadLayout()
    }
    public override func reloadLayout() {
        super.reloadLayout()
        pickView.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_titleView.axc.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        reloadData()
    }
    // MARK: 私有
    /// 刷新标题样式
    private func reloadStyle() {
        switch axc_pickerStyle {
        case .default: break
        }
    }
    /// 重写父类回调
    override func btnAction(_ direction: AxcDirection, sender: AxcButton) {
        if direction == .right { // 右边按钮
            axc_selectedBlock(self, axc_selectedIdx)
        }
    }
    
    // MARK: - 私有
    private var _selectedIndex: Int = 0
    
    // MARK: - 懒加载
    lazy var pickView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()
}

// MARK: - 代理&数据源
extension AxcPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    // 回调
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectedIndex = row
        axc_selectedBlock(self,row)
    }
    // 组数量
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 行数量
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return axc_dataList.count
    }
    // 文字
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let text = axc_dataList.axc_objAtIdx(row) as? String else { return nil }
        return text
    }
    // 富文本
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let attText = axc_dataList.axc_objAtIdx(row) as? NSAttributedString else { return nil }
        return attText
    }
    // label样式
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let label = view as? UILabel else {
            let _label = UILabel()
            if let text = self.pickerView(pickerView, titleForRow: row, forComponent: component) {
                _label.text = text
            }
            if let attributedText = self.pickerView(pickerView, attributedTitleForRow: row, forComponent: component) {
                _label.attributedText = attributedText
            }
            axc_labelStyleBlock(self,_label,row)
            return _label
        }
        return label
    }
}
