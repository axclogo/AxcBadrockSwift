//
//  TestApi.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import UIKit
import Moya

public enum NetWorkApi {
    case liveInfo
}

extension NetWorkApi: TargetType {
    // 设置当前域名
    public var baseURL: URL {
        return "https://www.beckyspremium.com".axc_url!
    }
    // 地址
    public var path: String {
        switch self {
        case .liveInfo:
            return "/system/config/tx/live/info"
            
        }
    }
    // 地址对应的方法
    public var method: Moya.Method {
        switch self {
        
        case .liveInfo:
            
            return .get
        }
    }
    
    // 表单
    var acceptForm: String  {
        return "application/x-www-form-urlencoded"
    }
    // json对象
    var acceptJson: String{
        return "application/json"
    } 

    // 地址对应的Accept
    var accept: String {
        switch self {
        case .liveInfo:
            return acceptForm
        default:
            return acceptJson
        }
    }
    
    
    //
    // 地址对应的头
    public var headers: [String : String]? {
        var currentHeader: [String : String] = [
            "Accept":"application/json",
            "isToken":"false",
            "Content-Type"
        ]
        switch self {
        default:
            <#code#>
        }
        return currentHeader
    }
    
    
    public var task: Task {
        switch self {
        default:
            if let parameters = parameters {
                
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    
  
    public var sampleData: Data {
        return "".axc_data ?? Data()
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .liveInfo: break
        }
        return params
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
