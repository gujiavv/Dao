//
//  CategoryLevel3ViewController.swift
//  LuGu
//
//  Created by odianyun on 2019/9/11.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import Moya
class CategoryLevel3ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    var model:[String:Any]!
    var modelValueList:[AnswerModel]?
    private var tableView:UITableView!
    private var searchTF:UITextField!
    private var searchView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = model["name"] as? String
        view.backgroundColor = UIColor("f6f6f6", a: 1)
        setUI()
        requestCategoryLevel3DataWithkeyword("")
    }
    
    func setUI(){
        
        searchView = UIView()
        searchView.backgroundColor = .white
        self.view.addSubview(searchView)
        searchView.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.view)
            if #available(iOS 11, *){
                make?.top.equalTo()(self.view.mas_safeAreaLayoutGuideTop)
            }else{
                make?.top.equalTo()(self.mas_topLayoutGuideBottom)
            }
            make?.height.equalTo()(50)
        }
        
        searchTF = UITextField()
        searchTF.backgroundColor = .white
        searchTF.layer.cornerRadius = 4
        searchTF.placeholder = "搜索题目"
        searchTF.textAlignment = .center
        searchTF.layer.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        searchTF.layer.borderWidth = 1/2
        self.view.addSubview(searchTF)
        searchTF.addTarget(self, action: #selector(changeTextFieldValue), for: .editingChanged)
        searchTF.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.offset()(20)
            make?.right.equalTo()(self.view)?.offset()(-20)
            make?.height.equalTo()(32)
            make?.centerY.equalTo()(searchView.mas_centerY)
        }
        
        
        tableView = UITableView(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.view)
            make?.top.equalTo()(self.searchView.mas_bottom)?.offset()(1)
            if #available(iOS 11, *){
                make?.bottom.equalTo()(self.view.mas_safeAreaLayoutGuideBottom)
            }else{
                make?.bottom.equalTo()(self.mas_bottomLayoutGuideBottom)
            }
            
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        tableView.separatorColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.estimatedRowHeight  = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreentWidth, height: 1))
        tableView .register(QuestionTableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    @objc func changeTextFieldValue(){
        requestCategoryLevel3DataWithkeyword(self.searchTF.text ?? "")
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true )
    }
    
//    - (void)textFieldDidBeginEditing:(UITextField *)textField;
    
    //MARK UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelValueList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! QuestionTableViewCell
        cell.selectionStyle = .none
        let model:AnswerModel = (self.modelValueList?[indexPath.item])!
        model.num = indexPath.item + 1
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:AnswerModel = (self.modelValueList?[indexPath.item])!
        let vc = AnswerViewController()
        vc.answerData = model;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestCategoryLevel3DataWithkeyword(_ keyword:String) {
        let provider = MoyaProvider<HttpRequest>()
        provider.request(.categoryLevel3(subCategoryId:(self.model["id"] as? Int)!,pageNum:1,pageSize:10, question:keyword)) { (Result) in
            switch Result {
            case let .success(response):
                do {
                    let jsonString = try response.mapJSON()
                    let modelData = JsonUtil.dictionaryToModel(jsonString as! [String : Any],QuestionModel.self) as? QuestionModel
                    self.modelValueList = modelData?.value.list
                    self.tableView.reloadData()
                }catch {
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
