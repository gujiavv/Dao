//
//  BaseModel.swift
//  LuGu
//
//  Created by odianyun on 2019/9/10.
//  Copyright © 2019 odianyun. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON

class BaseModel: HandyJSON {
    var success:NSNumber!
    var errorCode:NSNumber?
    var isSuccess:NSNumber?
    var errorMessage:NSString?
    required init(){}
}
