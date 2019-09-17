//
//  AnswerViewController.swift
//  LuGu
//
//  Created by odianyun on 2019/9/12.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import WebKit
class AnswerViewController: UIViewController,WKNavigationDelegate,WKUIDelegate{

    var answerData: AnswerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        title = "掌上题库"
        setupUI()
    }
    
    func setupUI(){
        self.questionLabel .mas_makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make?.top.equalTo()(self.view.mas_safeAreaLayoutGuideTop)?.offset()(24)
            } else {
                make?.top.equalTo()(self.mas_topLayoutGuideBottom)?.offset()(24)
            }
            make?.left.equalTo()(self.view)?.offset()(16)
        }
        
        self.questionNumber .mas_makeConstraints { (make) in
            make?.left.equalTo()(self.questionLabel.mas_right)?.offset()(16)
            make?.right.equalTo()(self.view.mas_right)?.offset()(-16)
            make?.top.equalTo()(self.view)?.offset()(16)
        }
        
        self.answerWebView .mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(10)
            make?.right.equalTo()(self.view)?.offset()(-10)
            make?.top.equalTo()(self.questionLabel.mas_bottom)?.offset()(16)
            make?.height.equalTo()(40)
        }
        
        self.importantClause .mas_makeConstraints { (make) in
            make?.left.equalTo()(self.answerWebView)
            make?.right.equalTo()(self.answerWebView)
            make?.top.equalTo()(self.answerWebView.mas_bottom)?.offset()(20)
        }
        
        self.previousBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.answerWebView.mas_left)?.offset()(16)
            make?.width.equalTo()(kScreentWidth/3)
            make?.height.equalTo()(44)
            make?.top.equalTo()(self.importantClause.mas_bottom)?.offset()(32)
        }
        
        self.nextBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.answerWebView.mas_right)?.offset()(-16)
            make?.width.equalTo()(kScreentWidth/3)
            make?.height.equalTo()(44)
            make?.top.equalTo()(self.previousBtn.mas_top)
        }
        
        self.questionLabel.text = self.answerData.question
        self.questionNumber.text = "（第99题）"
        self.answerWebView.loadHTMLString(self.answerData.answer!, baseURL: nil)
//        self.answerWebView.text = self.answerData.answer
    }
    
    //问题
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        self.view.addSubview(label)
        return label
    }()
    
    lazy var questionNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        self.view.addSubview(label)
        return label
    }()
    
    //答案
    lazy var answerWebView: WKWebView = {
        let preference = WKPreferences()
        preference.minimumFontSize = 15
        
        let userContent = WKUserContentController()
        let js = String("var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);")
        let userScript = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        userContent.addUserScript(userScript)
        
        let config = WKWebViewConfiguration()
        config.preferences = preference
        config.userContentController = userContent
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        webView.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        return webView
    }()
    
    //特别说明
    lazy var importantClause: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "特别声明：本文内容来源网络，版权归原作者所有。如果有侵权请与我们联系，我们将及时处理"
        label.numberOfLines = 0
        label.textColor = .lightGray
        self.view.addSubview(label)
        return label
    }()
    
    //上一题
    lazy var previousBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("上一题", for: .normal)
        self.view.addSubview(button)
        button.layer.cornerRadius = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1/2
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    //下一题
    lazy var nextBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("下一题", for: .normal)
        self.view.addSubview(button)
        button.layer.cornerRadius = 2
        button.backgroundColor = UIColor("00a6c9", a: 1)
        return button
    }()
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.style.backgroundColor=\"#f6f6f6\"", completionHandler: nil)
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            if let tempHeight:Double = result as? Double {
                webView.mas_updateConstraints { (make) in
                     make?.height.equalTo()(tempHeight)
                }
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
