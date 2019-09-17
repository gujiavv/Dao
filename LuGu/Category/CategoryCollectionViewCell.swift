//
//  CategoryCollectionViewCell.swift
//  LuGu
//
//  Created by odianyun on 2019/9/9.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import Kingfisher
class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prictureVm.frame = CGRect(x: (kScreentWidth/3 - kCellImageWidth)/2, y:(frame.size.height-kCellImageWidth)/2, width: kCellImageWidth, height: kCellImageWidth);
        nameLabel.frame = CGRect(x: 0, y:prictureVm.frame.size.height + prictureVm.frame.origin.y + 10, width: self.GJ_W, height:15);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var prictureVm:UIImageView = {
        let vm = UIImageView()
        vm.contentMode = .scaleAspectFill
        vm.clipsToBounds = true
        vm.image = UIImage(named: "我的牙银")
        self.addSubview(vm)
        return vm
    }()
    
    private lazy var nameLabel:UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.text = "test"
        name.textColor = UIColor.init("3d3d3d", a: 1)
        self.addSubview(name)
        return name
    }()
    
    
    var model:[String:Any]? {
        didSet{
            guard model != nil else {
                return
            }
            let img = model?["icon"] as? String ?? ""
            let name = model?["name"] as? String ?? ""
            self.prictureVm.kf.setImage(with: URL(string: img))
            self.nameLabel.text = name
        }
    }
    
    
}
