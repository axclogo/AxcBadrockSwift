//
//  AxcPickerView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/23.
//

import UIKit

public typealias AxcPickerViewSelectedBlock = (_ pickerView: AxcPickerView, _ index: Int) -> Void
public typealias AxcPickerViewLabelStyleBlock = (_ pickerView: AxcPickerView, _ label: UILabel, _ index: Int) -> Void

@IBDesignable
public class AxcPickerView: AxcBaseView {
    // MARK: - 初始化
    convenience init(_ title: String? = nil, dataList: [Any], selectedBlock: @escaping AxcPickerViewSelectedBlock) {
        self.init()
        axc_title = title
        axc_dataList = dataList
        axc_selectedBlock = selectedBlock
        config()
        makeUI()
    }
    // MARK: - 父类重写
    public override func config() {
        axc_width = Axc_screenWidth
        axc_height = Axc_screenHeight / 3 //默认屏高的1/3
    }
    public override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        addSubview(titleView)
        titleView.addSubview(leftButton)
        titleView.addSubview(rightButton)
        titleView.addSubview(titleLabel)
        addSubview(pickView)
        // 刷新布局
        reloadLayout()
    }
    public override func reloadLayout() {
        titleView.axc.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(axc_titleViewHeight)
        }
        leftButton.axc.remakeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(axc_actionButtonWidth)
        }
        rightButton.axc.remakeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(axc_actionButtonWidth)
        }
        titleLabel.axc.remakeConstraints { (make) in
            make.left.equalTo(leftButton.axc.right)
            make.right.equalTo(rightButton.axc.left)
            make.top.bottom.equalToSuperview()
        }
        pickView.axc.remakeConstraints { (make) in
            make.top.equalTo(titleView.axc.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        reloadData()
    }
    
    // MARK: - Api
    /// 数据源，仅支持String和NSAttributedString
    var axc_dataList: [Any] = []
    /// 设置标题
    var axc_title: String? {
        set { titleLabel.text = newValue }
        get { return titleLabel.text }
    }
    
    /// 设置更新titleView的高度 默认30
    var axc_titleViewHeight: CGFloat = 30 {
        didSet {
            titleView.axc.updateConstraints { (make) in
                make.height.equalTo(axc_titleViewHeight)
            }
        }
    }
    /// 设置更新左右按钮的宽度 默认30
    var axc_actionButtonWidth: CGFloat = 40 {
        didSet {
            leftButton.axc.updateConstraints { (make) in
                make.width.equalTo(axc_actionButtonWidth)
            }
            rightButton.axc.updateConstraints { (make) in
                make.width.equalTo(axc_actionButtonWidth)
            }
        }
    }
    /// 获取选中的
    func axc_getSelectedIndex() -> Int {
        return _selectedIndex
    }
    /// 设置选中哪个
    func axc_setSelectedIndex(_ idx: Int, animation: Bool = true) {
        _selectedIndex = idx
        pickView.selectRow(idx, inComponent: 0, animated: animation)
    }
    /// 刷新数据
    func reloadData() {
        pickView.reloadAllComponents()
    }
    /// 设置label样式的block
    var axc_labelStyleBlock: AxcPickerViewLabelStyleBlock = { (_,label,_) in
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AxcBadrock.shared.textColor
        label.textAlignment = .center
    }
    /// 选中的回调
    var axc_selectedBlock: AxcPickerViewSelectedBlock = { (picker,index) in
        AxcLog("未设置AxcPickerView的点击回调\nAxcPickerView: \(picker)\nIndex: \(index)", level: .info)
    }
    
    // MARK: - 私有
    private var _selectedIndex: Int = 0
    
    // MARK: - 懒加载
    lazy var leftButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.titleLabel.text = AxcBadrockLanguage("取消")
        button.axc_style = .text
        button.axc_contentInset = UIEdgeInsets.zero
        return button
    }()
    lazy var rightButton: AxcButton = {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.titleLabel.text = AxcBadrockLanguage("确定")
        button.axc_style = .text
        button.axc_contentInset = UIEdgeInsets.zero
        button.axc_addEvent { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.axc_selectedBlock(weakSelf, weakSelf.axc_getSelectedIndex())
        }
        return button
    }()
    lazy var titleLabel: AxcLabel = {
        let label = AxcLabel()
        label.textColor = AxcBadrock.shared.themeFillContentColor
        label.axc_contentInset = UIEdgeInsets.zero
        return label
    }()
    lazy var titleView: AxcBaseView = {
        let view = AxcBaseView()
        view.axc_setGradient()
        return view
    }()
    lazy var pickView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()
}


extension AxcPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectedIndex = row
        axc_selectedBlock(self,row)
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return axc_dataList.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let text = axc_dataList[row] as? String else { return nil }
        return text
    }
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let attText = axc_dataList[row] as? NSAttributedString else { return nil }
        return attText
    }
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
