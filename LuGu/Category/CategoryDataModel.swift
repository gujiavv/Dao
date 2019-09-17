//
//  CategoryDataModel.swift
//  LuGu
//
//  Created by odianyun on 2019/9/9.
//  Copyright © 2019 odianyun. All rights reserved.
//

import Foundation
import HandyJSON

class CategoryData: BaseModel {
    
    var list:Array<Dictionary<String, Any>>!
    required init(){}
}

class QuestionModel: BaseModel {
    
    var value:QuestionValueModel!
    required init(){}
}

class QuestionValueModel: HandyJSON {
    var endRow:NSNumber?
    var hasNext:Bool?
    var list:[AnswerModel]?
    required init(){}
}

class AnswerModel: HandyJSON {
    var answer:String?
    var bad:NSNumber?
    var categoryId:NSNumber?
    var code:String?
    var comments:String?
    var id:NSNumber?
    var question:String?
    var subCategoryId:NSNumber?
    var num:Int?
    required init(){}
}
