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
    //员工号
    private var mobileBtn:UIButton?
    private var accountBtn:UIButton?
    private var topArrowVw:UIImageView?
    private var isMobileLogin = true
    
    private var scrollVw:UIScrollView?
    private var mobileTF:LoginTextField?
    private var accountTF:LoginTextField?
    private var passwordTF:LoginTextField?
    private var orgTF:LoginTextField?
    private var verificationCodeTF:LoginTextField?
    
    private var wxBtn:UIButton?
    private var contactBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }
}

extension LoginViewController {
    private func setupUI(){
        view.backgroundColor = UIColor.white
        let y = setupTopView()
        setupCenterView(y)
        setupBottomView()
    }
    
    //头部区域
    private func setupTopView() -> CGFloat{
        let topViewH = 220/667*kScreentHeight
        let topView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreentWidth, height: topViewH))
        topView.isUserInteractionEnabled = true
        topView.image = UIImage.init(named: "backView")
        self.view.addSubview(topView)
        
        let iconView = UIImageView(image: UIImage.init(named: "AresIcon_White"))
        iconView.center = CGPoint(x: topView.center.x, y: topView.center.y)
        topView.addSubview(iconView)
        
        mobileBtn = UIButton(type: .custom)
        var btnX:CGFloat = 0
        let btnH:CGFloat = 52
        let btnW:CGFloat = kScreentWidth/2
        let btnY:CGFloat = topViewH - btnH
        mobileBtn!.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        mobileBtn!.setTitle("手机账号登录", for: .normal)
        mobileBtn!.titleLabel?.font = UIFont.boldSystemFont(ofSize:16)
        mobileBtn!.addTarget(self, action: #selector(mobileAccountBtnClicked(_:)), for: .touchUpInside)
        mobileBtn!.tag = 0
        topView.addSubview(mobileBtn!)
        
        btnX = kScreentWidth/2
        accountBtn = UIButton(type: .custom)
        accountBtn!.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        accountBtn!.setTitle("员工账号登录", for: .normal)
        accountBtn!.titleLabel?.font = UIFont.boldSystemFont(ofSize:16)
        accountBtn!.addTarget(self, action: #selector(mobileAccountBtnClicked(_:)), for: .touchUpInside)
        accountBtn!.alpha = 0.8
        accountBtn!.tag = 1
        topView.addSubview(accountBtn!)
        
        let topArrowVwW:CGFloat = 16
        let topArrowVwH:CGFloat = 8
        let topArrowVwX:CGFloat = 0
        let topArrowVwY:CGFloat = topViewH - topArrowVwH
        topArrowVw = UIImageView(frame: CGRect(x: topArrowVwX, y: topArrowVwY, width: topArrowVwW, height: topArrowVwH))
        topArrowVw?.image = UIImage(named: "loginArrow")
        topView.addSubview(topArrowVw!)
        topArrowVw?.center.x = mobileBtn!.center.x;
        return topViewH
    }
    
    //手机号登录
    @objc private func mobileAccountBtnClicked(_ btn: UIButton?) {
        
        guard let scrollVw = scrollVw,let mobileBtn = mobileBtn,let accountBtn = accountBtn,let btn = btn  else {
            return
        }
        //员工账号登录
        if btn.tag == 1 {
        
            accountBtn.alpha = 1
            accountBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            mobileBtn.alpha = 0.8
            mobileBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            scrollVw.contentOffset.x = kScreentWidth
            topArrowVw?.center.x = accountBtn.center.x
            
        //手机验证码登录
        }else if (btn.tag == 0){
            
            mobileBtn.alpha = 1
            mobileBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            accountBtn.alpha = 0.8
            accountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            scrollVw.contentOffset.x = 0
            topArrowVw?.center.x = mobileBtn.center.x
        }
    }
    
    //中间区域
    private func setupCenterView(_ y:CGFloat){
        scrollVw = UIScrollView(frame: CGRect(x: 0, y: y, width: kScreentWidth, height: 200))
        scrollVw!.showsHorizontalScrollIndicator = false
        scrollVw!.contentSize = CGSize(width: kScreentWidth * 2, height: 0)
        scrollVw!.isPagingEnabled = false
        scrollVw!.delegate = self
        view.addSubview(scrollVw!)
        
        let mobileView = setupMobileView()
        scrollVw!.addSubview(mobileView)
        
        let accountView = setupAccountView()
        scrollVw!.addSubview(accountView)
    }
    
    //普通账号登录
    private func setupAccountView() -> UIView {
        
        let accountView = UIView(frame: CGRect(x: kScreentWidth, y: 0, width: kScreentWidth, height: 174))
        let x:CGFloat = 40
        let w:CGFloat = kScreentWidth - 2*x
        let h:CGFloat = 40
        orgTF = LoginTextField(frame: CGRect(x: x, y: 30, width: w, height: h))
        orgTF!.placeholderStr = "请输入公司代码"
        orgTF!.delegate = self
        accountView.addSubview(orgTF!)
        
        accountTF = LoginTextField(frame: CGRect(x: x, y: orgTF!.frame.maxY + 20, width: w, height: h))
        accountTF!.placeholderStr = "请输入账号"
        accountTF!.delegate = self
        accountView.addSubview(accountTF!)
        
        passwordTF = LoginTextField(frame: CGRect(x: x, y: accountTF!.frame.maxY + 20, width: w, height: h))
        passwordTF!.placeholderStr = "请输入密码"
        passwordTF!.delegate = self
        accountView.addSubview(passwordTF!)
        
        return accountView
    }
    
    //手机验证码登录
    private func setupMobileView() -> UIView {
        
        let mobileView = UIView(frame: CGRect(x: 0, y: 0, width: kScreentWidth, height: 174))
        let x:CGFloat = 40
        let w:CGFloat = kScreentWidth - 2*x
        let h:CGFloat = 40
        mobileTF = LoginTextField(frame: CGRect(x: x, y: 30, width: w, height: h))
        mobileTF?.placeholderStr = "请输入手机号"
        mobileTF?.keyboardType = .phonePad
        mobileTF?.delegate = self
        mobileView.addSubview(mobileTF!)
        
        verificationCodeTF = LoginTextField(frame: CGRect(x: x, y: mobileTF!.frame.maxY + 20, width: w, height: h))
        verificationCodeTF!.placeholderStr = "请输入验证码"
        verificationCodeTF!.delegate = self
        verificationCodeTF!.keyboardType = .numberPad
        mobileView.addSubview(verificationCodeTF!)
        
        let tipLabel = UILabel(frame: CGRect(x: x, y: verificationCodeTF!.frame.maxY + 20 , width: w, height: h));
        tipLabel.text = "* 未注册的手机号验证后自动创建账户"
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        mobileView.addSubview(tipLabel)
        return mobileView
    }
    //底部区域
    private func setupBottomView(){
        let btnX:CGFloat = 40
        let btnW:CGFloat = (kScreentWidth - 2*btnX - 15)/2
        let btnH:CGFloat = 40
        let btnY:CGFloat = kScreentHeight - 50 - btnH
        
        wxBtn = UIButton(frame: CGRect(x: btnX, y: btnY, width: btnW, height: btnH))
        wxBtn!.backgroundColor = UIColor.init("#70BF62",a:0.1)
        wxBtn!.setTitle("微信登录", for: .normal)
        wxBtn!.addTarget(self, action: #selector(wxLoginAction(_:)), for: .touchUpInside)
        wxBtn!.setTitleColor(UIColor.init("#70BF62", a: 1), for: .normal)
        wxBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(wxBtn!)
        
        contactBtn = UIButton(type: .custom)
        contactBtn!.frame = CGRect(x: wxBtn!.frame.maxX + 15, y: btnY, width: btnW, height: btnH)
        contactBtn!.backgroundColor = UIColor.init("#00A6C9",a:0.1)
        contactBtn!.setTitle("联系客服", for: .normal)
        contactBtn!.addTarget(self, action: #selector(contactServer(_:)), for: .touchUpInside)
        contactBtn!.setTitleColor(UIColor.init("#00A6C9", a: 1), for: .normal)
        contactBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(contactBtn!)
        
        let loginBtn:UIButton = UIButton(type: .custom)
        loginBtn.frame = CGRect(x: btnX, y: btnY - 30 - btnH, width: kScreentWidth - 2*btnX, height: btnH)
        loginBtn.backgroundColor = UIColor.init("#00A6C9",a:0.1)
        loginBtn.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.init("#00A6C9", a: 1), for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(loginBtn)
        
    }
    
    //账号登录
    @objc private func loginAction(_ btn: UIButton?){
        let m = MBProgressHUD.init().showSuccessText("账号不能为空")
        
    }
    
    //微信登录
    @objc private func wxLoginAction(_ btn: UIButton?){
        MBProgressHUD.hide(for: self.view, animated: false)
    }
    //联系客服
    @objc private func contactServer(_ btn: UIButton?){
        MBProgressHUD.hide(for: self.view, animated: false)
    }
}


extension LoginViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resetTopArrowVwCenterX()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetTopArrowVwCenterX()
    }
    
    //重置topArrowVwCenterX
    private func resetTopArrowVwCenterX(){
        guard let accountBtn = accountBtn,let mobileBtn = mobileBtn  ,let topArrowVw = topArrowVw ,let scrollVw = scrollVw else {
            return
        }
        let distance = accountBtn.center.x - mobileBtn.center.x
        topArrowVw.center.x = mobileBtn.center.x + (scrollVw.contentOffset.x * distance)/kScreentWidth
    }
}
