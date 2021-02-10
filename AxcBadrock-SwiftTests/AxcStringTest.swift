//
//  AxcStringTest.swift
//  AxcBadrock-SwiftTests
//
//  Created by 赵新 on 2021/2/1.
//

import XCTest
import AxcBadrock_Swift

class AxcStringTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
    }
    
    func testStringCoding() {
        
        
        
        var url_1asdasdasd = "https://google.com?axc=Swifter&123=456".axc_url
        print(url_1asdasdasd?["axc"])
        print(url_1asdasdasd?["123"])
        url_1asdasdasd?.axc_removeAllParam()
        print(url_1asdasdasd?["axc"])
        
        let value = url_1asdasdasd!["axc"]
        
        url_1asdasdasd?["123"] = "123"
        
        print(url_1asdasdasd?.axc_strValue!)
        
        let arrStr =
            "asd"
            .axc_attributedStr
            .axc_font(UIFont.systemFont(ofSize: 12))
            .axc_textColor(
                "123".axc_color(0.5)!)
            .axc_applying(attributes: [.backgroundColor: "#ffffff".axc_color! ])
            +
            "zhanggen"
            .axc_attributedStr
            .axc_textColor("ffffff".axc_color!)
            .axc_font(UIFont.boldSystemFont(ofSize: 12))
            +
            ("test"
                .axc_sourceImage?
                .axc_pngData?
                .axc_textAttachment
                .axc_attributedStr)!
        
        
        var dic: [String:String] = [:]
        dic["asd"] = "asd"
//        let ff: Double = √9
////        ff.axc_cgFloatValue
//
//        let sss = 12 *^ 2
//
//
//        var dic: [String:Any] = [:]
//        dic["axc"] = "qwe"
//        let aa = dic.axc_jsonStr?.axc_jsonObj
//
//
//        let char: Character = Character.axc_max
//
//        let ccc = char.axc_strValue * 3
//        print(ccc)
//
//        let str = "1234567890" - "1"
//
//
        print(arrStr)
        
//        let headerS = "<html lang=\"zh-cn\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, nickName-scalable=no\"></meta><style>img{max-width: 100%; width:auto; height:auto;}body{text-align:justify;font-size:14px !important;}</style></head><body>"
//        let endS = "</body></html>"
//        let htmlStr = headerS + "12312312313" + endS
//
//        let bol = htmlStr.axc_attributedStr( isHtml: false)
//        print(bol)
    
        let  now =  NSDate ()
         
        // 创建一个日期格式器
        let  dformatter =  DateFormatter ()
        dformatter.dateFormat = "GG-yyyy-MM-ww-WW-DD-dd"
        print ( "当前日期时间：\(dformatter.string(from: now as Date))" )
         
        //当前时间的时间戳
//        let  timeInterval: NSTimeInterval  = now.timeIntervalSince1970
//        let  timeStamp =  Int (timeInterval)
//        print ( "当前时间的时间戳：\(timeStamp)" )
        
        
//        let bol = "123" |= "23"
//        print(bol)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
