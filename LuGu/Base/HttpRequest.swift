//
//  HttpRequest.swift
//  LuGu
//
//  Created by odianyun on 2019/9/9.
//  Copyright © 2019 odianyun. All rights reserved.
//

import Foundation
import Moya

enum HttpRequest {
    case categoryLevel1 //列表数据请求,带有相关值的枚举，
    case categoryLevel2(categoryId:Int) //列表数据请求,带有相关值的枚举，
    case categoryLevel3(subCategoryId:Int,pageNum:Int,pageSize:Int,question:String) //列表数据请求,带有相关值的枚举，
    case othetRequest //带一个参数的请求
}

extension HttpRequest :TargetType{
    var baseURL: URL {
        return URL(string: "http://47.100.6.61:8800")!
    }
    
    var path: String {
        switch self {
        case .categoryLevel1:
            return "category/v1/getCategorys"
        case .categoryLevel2:
            return "category/v1/getSubCategorys"
        case .categoryLevel3:
            return "topic/v1/getTopics"
        default:
            return "baidu.com"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categoryLevel1:
            return .get
        case .categoryLevel2:
            return .get
        case .categoryLevel3:
            return .post
        default:
            return .get
        }
    }
    
    //单元测试模拟数据
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var param:[String:Any] = [:]
        switch self {
        case .categoryLevel1:
            param = [:]
        case let .categoryLevel2(categoryId):
            param = ["categoryId":categoryId]
        case let .categoryLevel3(subCategoryId,pageNum,pageSize,question):
            if question.count > 0 {
                param = ["subCategoryId":subCategoryId,"pageNum":pageNum,"pageSize":pageSize,"question":question]
            }else{
                param = ["subCategoryId":subCategoryId,"pageNum":pageNum,"pageSize":pageSize]
            }
            
            //body用json参数 比如用JSONEncoding 重要重要
            return .requestCompositeParameters(bodyParameters: param, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        default:
            return .requestPlain
        }
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]?{
        return ["Content-type" : "application/json"]
    }
}


