//
//  UIColor+Extension.swift
//  LuGu
//
//  Created by odianyun on 2019/7/5.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    convenience init(rgb:CGFloat){
        self.init(red:rgb/255.0,green:rgb/255.0,blue:rgb/255.0,alpha:1)
    }
    
    convenience init?(_ hexString:String,a:CGFloat){
        // hexString可能有前缀：##、#、0x、0X
        
        // 1. 讲字符串转成大写
        var hexTempString = hexString.uppercased()
        
        // 2. 判断字符串是否有前缀：0X/##/#
        if hexTempString.hasPrefix("0X") || hexTempString.hasPrefix("##") {
            hexTempString = (hexTempString as NSString).substring(from: 2)
        }
        if hexTempString.hasPrefix("#") {
            hexTempString = (hexTempString as NSString).substring(from: 1)
        }
        
        // 3. 判断字符串的长度是否等于6
        guard hexTempString.count == 6 else {
            return nil
        }
        
        // 4. 获取RGB对应的16进制
        var range = NSRange.init(location: 0, length: 2)
        let rHex = (hexTempString as NSString).substring(with: range)
        range.location = 2
        let gHex = (hexTempString as NSString).substring(with: range)
        range.location = 4
        let bHex = (hexTempString as NSString).substring(with: range)
        
        // 5. 将16进制转换成数值
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        guard Scanner(string: rHex).scanHexInt32(&r) == true else {
            return nil
        }
        guard Scanner(string: gHex).scanHexInt32(&g) == true else {
            return nil
        }
        guard Scanner(string: bHex).scanHexInt32(&b) == true else {
            return nil
        }
        
        self.init(CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: a)
    }
}
