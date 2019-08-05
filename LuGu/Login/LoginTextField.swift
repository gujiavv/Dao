//
//  LoginTextField.swift
//  LuGu
//
//  Created by odianyun on 2019/7/1.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bottomLineView)
        clearButtonMode = .whileEditing
        textColor = UIColor.init(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        font = UIFont.systemFont(ofSize: 15)
        tintColor = UIColor.init(red: 0/255, green: 166/255, blue: 201/255, alpha: 1)
        addSubview(bottomLineView)
        bottomLineView.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been implement")
    }
    
    private lazy var bottomLineView:UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.init(red: 227/255, green: 227.255, blue: 227/255, alpha: 1)
        return vw
    }()
    
    var isEditingOfTF:Bool = false {
        didSet{
            bottomLineView.backgroundColor = isEditingOfTF ? UIColor.init(red: 61/255, green: 61/255, blue: 61/255, alpha: 1) : UIColor.init(red: 227/255, green: 227.255, blue: 227/255, alpha: 1);
        }
    }
    
    var placeholderStr:String?{
        didSet{
            guard placeholderStr != nil else {
                return
            }
            let placeholserColor = UIColor.init(red: 147/255, green: 151/255, blue: 162/255, alpha: 1)
            attributedPlaceholder = NSAttributedString(string: placeholderStr!, attributes: [NSAttributedString.Key.foregroundColor : placeholserColor,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        }
    }
    
}
