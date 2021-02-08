//
//  ViewController.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/1/30.
//  封装 继承 多态 颗粒度 重复代码

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        
        createUI()
        
        
        
        var url_1asdasdasd = "https://google.com".axc_url! + ["axc":"Swifter"]

        print(url_1asdasdasd)
        
        let i: UInt = 0

    }
    
    
    
    
    
    
    // 小明是个程序员
    // 产品说我要一个效果，上边展示一张图配一段文本
    func test_1() {
        
        // 一个承载图片和文字的白板视图
        let _view = UIView()
        
        
        // 一个图片视图
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dingwei")
        _view.addSubview(imageView) // 添加到白板视图
        
        
        // 一个文字视图
        let label = UILabel()
        label.text = "一个label"
        label.font = UIFont.systemFont(ofSize: 12)
        _view.addSubview(label) // 添加到白板视图
        
    }
    
    
    
    
    
    
    
    
    
    // 产品说我需要这个文字后边再加一张图片
    func test_2() {
        
        // 图-文-图
        createImgTextView_2()   // .满足他
        
    }
    
    
    @discardableResult
    func createImgTextView_2() -> UIView {
        
        // 一个承载图片和文字的白板视图
        let _view = UIView()
        
        
        // 一个头部图片视图
        let prefixImageView = UIImageView()
        prefixImageView.image = UIImage(named: "dingwei")
        _view.addSubview(prefixImageView) // 添加到白板视图
        
        
        // 一个文字视图
        let label = UILabel()
        label.text = "一个label"
        label.font = UIFont.systemFont(ofSize: 12)
        _view.addSubview(label) // 添加到白板视图
        
        
        // 一个尾部图片视图
        let suffixImageView = UIImageView()
        suffixImageView.image = UIImage(named: "dingwei")
        _view.addSubview(suffixImageView) // 添加到白板视图
        
        return view
    }
        
        
        
    // 产品说我成年人不做选择，那俩效果我全都要
    func test_3() {
        
        createImgTextView_3()   // ...
        
    }
        
    
    @discardableResult
    func createImgTextView_3() -> UIView {
        // 一个总体View
        let backgroundView = UIView()
        
        // 一个承载图片和文字的白板视图
        let _view_1 = UIView()
        
        // 一个图片视图
        let imageView_1 = UIImageView()
        imageView_1.image = UIImage(named: "dingwei")
        _view_1.addSubview(imageView_1) // 添加到白板视图
        
        // 一个文字视图
        let label_1 = UILabel()
        label_1.text = "一个label"
        label_1.font = UIFont.systemFont(ofSize: 12)
        _view_1.addSubview(label_1) // 添加到白板视图
        // 这个视图添加进总体视图
        backgroundView.addSubview(_view_1)
        
        // 一个承载图片和文字的白板视图
        let _view_2 = UIView()
        
        // 一个头部图片视图
        let prefixImageView = UIImageView()
        prefixImageView.image = UIImage(named: "dingwei")
        _view_2.addSubview(prefixImageView) // 添加到白板视图
        
        // 一个文字视图
        let label_2 = UILabel()
        label_2.text = "一个label"
        label_2.font = UIFont.systemFont(ofSize: 12)
        _view_2.addSubview(label_2) // 添加到白板视图
        
        // 一个尾部图片视图
        let suffixImageView = UIImageView()
        suffixImageView.image = UIImage(named: "dingwei")
        _view_2.addSubview(UIImageView()) // 添加到白板视图
        // 这个视图添加进总体视图
        backgroundView.addSubview(_view_2)

        return view
    }
        
        
    // 产品话没说完就被绑起来了
    func test_4() {
        
        // 小明发现这样下去不行，于是对代码进行了封装 DRY原则
        createImgTextView_4()   // 😁
        
    }
    
    /// 进行了封装
    @discardableResult
    func createImgTextView_4() -> UIView {
        // 一个总体View
        let backgroundView = UIView()
        // 图-文 视图
//        let imageTextView = createImgTextView_2()
//        backgroundView.addSubview(imageTextView)
        
        // 图-文-图 视图
        let imageTextImageView = createImgTextView_2()
        backgroundView.addSubview(imageTextImageView)
        
        // 图-文-图 视图
//        let imageTextImageView = createImgTextView_2()
//        backgroundView.addSubview(imageTextImageView)
        
        return backgroundView
    }
    
    
    
    
    
    
    
    
    // 小明放开了产品
    // 产品张口就来，我需要这些元素能自由组合
    func test_5() {
        
        // 小明继续苦逼的封装，但这次降低了颗粒度
        createImgTextView_5()   // WDNMD..
        
    }
    
    
    @discardableResult
    func createImgTextView_5() -> UIView {
        // 一个总体View
        let backgroundView = UIView()
        
        backgroundView.addSubview(createLabel())        // 添加文字
        backgroundView.addSubview(createImageView())    // 添加图片
        
        backgroundView.addSubview(createLabel())        // 添加文字
        backgroundView.addSubview(createImageView())    // 添加图片
        backgroundView.addSubview(createImageView())    // 添加图片
        backgroundView.addSubview(createLabel())        // 添加文字

        return backgroundView
    }
    
    func createLabel() -> UILabel {
        return UILabel()
    }
    func createImageView() -> UIImageView {
        return UIImageView()
    }
    
    
    
    
    
    // Two Hours Later ..
    // 产品：我希望你能动态配置这些组件
    func test_6() {
        
        createImgTextView_6()   //
        
    }
    
    
    @discardableResult
    func createImgTextView_6() -> UIView {
        // 一个总体View
        let backgroundView = UIView()
        backgroundView.addSubview(createControl(isImage: false))        // 添加文字
        backgroundView.addSubview(createControl(isImage: true))        // 添加图片
        backgroundView.addSubview(createControl(isImage: false))        // 添加文字
        backgroundView.addSubview(createControl(isImage: true))        // 添加图片
        backgroundView.addSubview(createControl(isImage: false))        // 添加文字
        return backgroundView
    }
    func createControl( isImage: Bool ) -> UIView {
        // 两个组件都属于UIView的继承，返回值的多态
        return isImage ? UIImageView() : UILabel() ;
    }
    
    
    
    
    // Two Hours Later ..
    // 产品：我还要加个按钮，或者之后可能也会添加其他组件
    func test_7() {
        
        createImgTextView_7()
        
    }
    
    
    @discardableResult
    func createImgTextView_7() -> UIView {
        // 一个总体View
        let backgroundView = UIView()
        backgroundView.addSubview(createControl_2(0))        // 添加图片
        backgroundView.addSubview(createControl_2(1))        // 添加文字
        backgroundView.addSubview(createControl_2(2))        // 添加按钮
        backgroundView.addSubview(createControl_2(1))        // 添加文字
        backgroundView.addSubview(createControl_2(0))        // 添加图片
        return backgroundView
    }
    func createControl_2(_ type: Int ) -> UIView {
        switch type {
        case 0: return UIImageView()
        case 1: return UILabel()
        case 2: return UIButton()
        case 3: return UIControl()
        case 4: return UISwitch()
        case 5: return UIProgressView()
        case 6: return UIToolbar()
        default:return UIView()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func createUI() {
        
        "压缩".axc_attributedStr
            .axc_font(UIFont.systemFont(ofSize: 12))
            .axc_textColor( "ffffff".axc_color! )
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let label =
            "".axc_label
            .axc_frame(CGRect(x: 10, y: 50, width: AxcScreen_Width-20, height: 200))
            .axc_numberOfLines(0)
            .axc_attributedText(
                "成都武侯区工地招iOS搬砖         "
                    .axc_attributedStr
                    .axc_font(UIFont.systemFont(ofSize: 16))  // 设置字体
                    .axc_strikethroughStyle(true)   // 开启删除线
                    .axc_strikethroughColor( UIColor.red )  // 删除线颜色
                    +   // 追加操作符 ++++++++++++++
                    
                    "我要置顶 "
                    .axc_attributedStr
                    .axc_font(UIFont.systemFont(ofSize: 12))  // 设置字体
                    .axc_textColor( "#1049D9".axc_color! )  // 设置字色
                    .axc_backgroundColor( "#0099FF".axc_color! )    // 设置字背景色
                    +   // 追加操作符 ++++++++++++++
                    
                    "\n".axc_attributedStr
                    +   // 追加操作符 ++++++++++++++
                    NSTextAttachment().axc_bounds(CGRect(x: 0, y: 0, width: 20, height: 20))
                    .axc_attributedStr
                    +
                    NSTextAttachment()
                    .axc_image( "yupao".axc_sourceImage! )    // 生成一个图片NSTextAttachment
                    .axc_bounds( CGRect(x: 0, y: 0, width: 25, height: 25) ) // 设置图片bounds
                    .axc_attributedStr
                    +   // 追加操作符 ++++++++++++++
                    
                    "   张大炮"
                    .axc_attributedStr
                    .axc_baselineOffset(8)   // 设置基线上移
                    .axc_font(UIFont.systemFont(ofSize: 15))  // 设置字体
                    +   // 追加操作符 ++++++++++++++
                    
                    "\n".axc_attributedStr
                    +   // 追加操作符 ++++++++++++++
                    
                    "内蒙古鄂尔多斯招后八轮宽体司机"
                    .axc_attributedStr
                    .axc_font(UIFont.systemFont(ofSize: 14))  // 设置字体
                    .axc_textColor( "#7F7E7E".axc_color! )  // 设置字色
                    +   // 追加操作符 ++++++++++++++
                    
                    "\n".axc_attributedStr
                    +   // 追加操作符 ++++++++++++++
                    
                    NSTextAttachment()
                    .axc_image( "dingwei".axc_sourceImage! )    // 生成一个图片NSTextAttachment
                    .axc_bounds( CGRect(x: 0, y: 0, width: 10, height: 15) ) // 设置图片bounds
                    .axc_attributedStr
                    +   // 追加操作符 ++++++++++++++
                    
                    "双流区 · 远大都市风景".axc_attributedStr.axc_font(UIFont.systemFont(ofSize: 12))
                    .axc_link( "www.baidu.com".axc_url! )
            )
        label.backgroundColor = UIColor.white
        view.addSubview(label)
    }
    
}

