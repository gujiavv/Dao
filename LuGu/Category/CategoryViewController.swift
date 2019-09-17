//
//  CategoryViewController.swift
//  LuGu
//
//  Created by odianyun on 2019/9/9.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import Moya
//import Alamofire
class CategoryViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    private var collectionView:UICollectionView!
    private var cetegoryCell:CategoryCollectionViewCell?
    private var model:CategoryData?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "掌上题库"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor("3d3d3d", a: 1)!]
        navigationController?.navigationBar.barTintColor = UIColor.white
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor.lightGray
        let layout = UICollectionViewFlowLayout.init()
        let cellWidth = (kScreentWidth-3)/3
        layout.itemSize =  CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.bounces = true
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CategoryCollectionViewCell.self))
        //请求一级分类名称
        requestCategoryList()
    }
    
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell
        cell.model = self.model?.list[indexPath.item]
        return cell;
    }
    
    //MARK:UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.model?.list[indexPath.item]
        let vc = CategoryLevel2ViewController.init()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestCategoryList(){

        let provide = MoyaProvider<HttpRequest>()
        provide.request(.categoryLevel1) { (Result) in
            switch Result {
            case let .success(response):
                //数据解析
                do {
                    let jsonString = try response.mapJSON()
                    self.model = JsonUtil.dictionaryToModel(jsonString as! [String : Any],CategoryData.self) as? CategoryData
                    self.collectionView.reloadData()
                } catch {
                    print(error)
                }
            
            case let .failure(error):
                print(error)
            }
        }
    }
}

/**
 //        Alamofire.request("http://47.100.6.61:8800/api/category/v1/getCategorys", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
 //            print(response.result)
 //        }
 */
