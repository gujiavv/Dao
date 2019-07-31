//
//  MBProgressHUD+MJ.swift
//  LuGu
//
//  Created by odianyun on 2019/7/5.
//  Copyright © 2019 odianyun. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
extension MBProgressHUD {
    func showSuccessText(_ message:String) -> MBProgressHUD{
        let v = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to: v!, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.detailsLabel.text = message
        hud.detailsLabel.textColor = UIColor.black
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
        return hud
    }
}
