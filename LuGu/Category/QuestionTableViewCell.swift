//
//  QuestionTableViewCell.swift
//  LuGu
//
//  Created by odianyun on 2019/9/11.
//  Copyright © 2019 odianyun. All rights reserved.
//

import UIKit
import Masonry
class QuestionTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.questionTitle .mas_makeConstraints { (make:MASConstraintMaker!) in
            make?.left.equalTo()(self.mas_left)?.offset()(24)
            make?.top.equalTo()(self.mas_top)?.offset()(16)
            make?.bottom.equalTo()(self.mas_bottom)?.offset()(-16)
            make?.right.equalTo()(self.mas_right)?.offset()(-24)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: AnswerModel? {
        didSet{
            guard model != nil else {
                return;
            }
            let numStr:String = String(model?.num ?? 0)
            self.questionTitle.text =  "\(numStr)、\(model!.question ??  "")"
        }
    }
    
    lazy var questionTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor("3d3d3d", a: 1)
        title.textAlignment = .left
        title.numberOfLines = 0;
        self.addSubview(title)
        return title
    }()

}

/**
 private lazy var prictureVm:UIImageView = {
 let vm = UIImageView()
 vm.contentMode = .scaleAspectFill
 vm.clipsToBounds = true
 vm.image = UIImage(named: "我的牙银")
 self.addSubview(vm)
 return vm
 }()
 */
