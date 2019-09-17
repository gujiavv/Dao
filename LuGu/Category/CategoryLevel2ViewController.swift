//
//  CategoryLevel2ViewController.swift
//  LuGu
//
//  Created by odianyun on 2019/9/10.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import Moya
class CategoryLevel2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var model:[String:Any]!
    var tableView:UITableView!
    private var modelData:CategoryData?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = model["name"] as? String
        view.backgroundColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        self.setupUI()
        self.requestCategoryLevel2Data()
    }
    
    func setupUI(){
        tableView = UITableView(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        tableView.separatorColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreentWidth, height: 1))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.modelData?.list[indexPath.row]
        let vc = CategoryLevel3ViewController.init()
        vc.model = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = nil
        cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        if(cell == nil){
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cellID")
        }
        cell?.selectionStyle = .none
        let dict = self.modelData?.list[indexPath.item]
        cell?.textLabel?.text = dict?["name"] as? String
        cell?.textLabel?.textColor = UIColor("3d3d3d", a: 1)
        return cell!
    }
    
    //MARK 请求二级分类数据
    func requestCategoryLevel2Data(){
        let provider = MoyaProvider<HttpRequest>()
        provider.request(.categoryLevel2(categoryId: self.model?["id"] as! Int)) { (Result) in
            switch Result {
            case let .success(response):
                do {
                    let jsonString = try response.mapJSON()
                    self.modelData = JsonUtil.dictionaryToModel(jsonString as! [String : Any],CategoryData.self) as? CategoryData
                    self.tableView.reloadData()
                } catch{
                    
                }
            case let .failure(error):
                print(error)
            }
            }
        }
}
