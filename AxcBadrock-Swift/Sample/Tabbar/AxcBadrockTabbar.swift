//
//  AxcBadrockTabbar.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

class AxcBadrockTabbar: AxcBaseTabbarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let module = AxcUrlConfigModule("主模块", identifier: "Main",
                                       environment: [
                                        AxcEnvironmentType(environmentKey: "release",
                                                                standbyUrls: [(title: "主正式站", url: "www.baidu.com"),
                                                                              (title: "主正式站备用线路1", url: "www.baidu1.com"),
                                                                              (title: "主正式站备用线路2", url: "www.baidu2.com"),
                                                                              (title: "主正式站备用线路3", url: "www.baidu3.com"),
                                                                              (title: "主正式站备用线路4", url: "www.baidu4.com")]),
                                        
                                        AxcEnvironmentType(environmentKey: "prepare",
                                                                standbyUrls: [(title: "主预发布站", url: "www.bing.com"),
                                                                              (title: "主重构预发布站", url: "www.chonggou.com")]),
                                        
                                        AxcEnvironmentType(environmentKey: "test",
                                                                standbyUrls: [(title: "主测试站", url: "www.test.com")])
                                       ])
        AxcUrlConfig.shared.axc_addModule( module )
        
        
        let workAccountModule = AxcUrlConfigModule("记工记账模块", identifier: "WorkAccount",
                                          environment: [
                                            AxcEnvironmentType(environmentKey: "release",
                                                                    standbyUrls: [(title: "记工记账正式站", url: "https://certapi.54xiaoshuo.com")]),
                                            
                                            AxcEnvironmentType(environmentKey: "prepare",
                                                                    standbyUrls: [(title: "记工记账预发布站", url: "http://app.kkbbi.com")]),
                                            
                                            AxcEnvironmentType(environmentKey: "test",
                                                                    standbyUrls: [(title: "记工记账测试站", url: "http://apptest.zhaogong.vrtbbs.com")])
                                          ])
        AxcUrlConfig.shared.axc_addModule( workAccountModule )
        
        let webModule = AxcUrlConfigModule("网站模块", identifier: "Web",
                                          environment: [
                                            AxcEnvironmentType(environmentKey: "release",
                                                                    standbyUrls: [(title: "网站正式站", url: "www.releaseweb.com")]),
                                            
                                            AxcEnvironmentType(environmentKey: "prepare",
                                                                    standbyUrls: [(title: "网站预发布站", url: "www.prepareweb.com")]),
                                            
                                            AxcEnvironmentType(environmentKey: "test",
                                                                    standbyUrls: [(title: "网站测试站", url: "www.testweb.com")])
                                          ])
        AxcUrlConfig.shared.axc_addModule( webModule )
        AxcUrlConfig.shared.axc_loadAllModule() // 加载
    }
    
    override func makeUI() {
        
//        axc_addTabItem(AxcTabItem(className: "ScrollTestVC", title: "page示例", selectedImgColor: UIColor.systemBlue))
//        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例2", selectedImgColor: UIColor.systemBlue))
//        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例3", selectedImgColor: UIColor.systemBlue))

        
        
    }
    
    var idx = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        switch idx {
//        case 0:
//            AxcUrlConfig.shared.axc_switchEnvironment("release")
//        case 1:
//            AxcUrlConfig.shared.axc_switchEnvironment("prepare")
//        case 2:
//            AxcUrlConfig.shared.axc_switchEnvironment("test")
//        default:
//            break
//        }
//        // 主站单切
//        AxcUrlConfig.shared.axc_switchStandbyUrl("Main", environmentKey: "release", idx: Int(arc4random())%5)
//
//        idx += 1
//        if idx > 2 {
//            idx = 0
//        }
//        for module in AxcUrlConfig.shared.netModules {
//            print(module.currentUrl)
//        }
//        print("\n")
        
//        TestProvider.request(.liveInfo) { (data) in
//            print("\(data)")
//        } failure: { (err) in
//            print("\(err)")
//        }
        
        AxcCacheManager.shared.axc_saveCache("13231231".axc_data!, key: "112233", validityTime: 2.axc_seconds)
        
        sleep(3)
        
        let data = AxcCacheManager.shared.axc_readCache(key: "112233")
        
        print(data)
    }

}
