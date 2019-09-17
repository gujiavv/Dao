//
//  UIView+Category.swift
//  LuGu
//
//  Created by odianyun on 2019/9/10.
//  Copyright © 2019 odianyun. All rights reserved.
//

import Foundation
import UIKit
// MARK:- 给View添加下划线
extension UIView {
    var GJ_X:CGFloat {
        get{
            return self.frame.origin.x
        }
    }
    
    var GJ_Y:CGFloat {
        get{
            return self.frame.origin.y
        }
    }
    
    var GJ_W:CGFloat {
        get{
            return self.frame.size.width
        }
    }
    
    var GJ_H:CGFloat {
        get{
            return self.frame.size.height
        }
    }
    
}
