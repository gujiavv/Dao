//
//  JsonUtil.swift
//  LuGu
//
//  Created by odianyun on 2019/9/10.
//  Copyright © 2019 odianyun. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON

class JsonUtil: NSObject {
    /**
     * json转对象
     */
    static func jsonToModel(_ jsonStr:String,_ modelType:HandyJSON.Type) -> BaseModel {
        if jsonStr == "" || jsonStr.count == 0 {
            print("Json字符串为空")
            return BaseModel()
        }
        return modelType.deserialize(from: jsonStr) as! BaseModel
    }
    
    /**
     * json转数组对象
     */
    static func jsonToArrayModel(_ jsonStr:String,_ modelType:HandyJSON.Type) -> [BaseModel] {
        return []
    }
    
    /**
     * 字典转对象
     */
    
    static func dictionaryToModel(_ dictionaryString:[String:Any],_ modelType:HandyJSON.Type) -> BaseModel {
        if dictionaryString.count == 0{
            print("字典为空")
            return BaseModel()
        }
        return modelType.deserialize(from: dictionaryString) as! BaseModel
    }
    
    /**
     * 对象转json
     */
    
    static func modelToJson(_ model:BaseModel?) -> String {
        if model == nil {
            return ""
        }
        return (model?.toJSONString())!
    }
    
    /**
     * 对象转字典 肯定比上面的实用
     */
    
    
}
