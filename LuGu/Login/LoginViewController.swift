//
//  LoginViewController.swift
//  LuGu
//
//  Created by odianyun on 2019/6/14.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import MBProgressHUD
class LoginViewController: BaseViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        setupUI()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabbarVC") as? UITabBarController
          AppDelegate
//          self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension LoginViewController {
    private func setupUI(){
        view.backgroundColor = UIColor.white
    }
    
    //中间区域
    private func setupCenterView(_ y:CGFloat){
       
    }
    
}



