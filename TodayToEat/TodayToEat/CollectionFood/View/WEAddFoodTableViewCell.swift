//
//  WEAddFoodTableViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/18.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEAddFoodTableViewCell: UITableViewCell {
 
    let x:CGFloat = 10
    let y:CGFloat = 10
    let line:CGFloat = 5
    
    let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.textColor = UIColor.black
        field.font = UIFont.systemFont(ofSize: 14)
        field.placeholder = "请输入名称"
        return field
    }()
    
    let label: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.black
        temLabel.text = "名称："
        return temLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            self.contentView.addSubview(label)
            self.contentView.addSubview(textField)
            
            label.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize(width: 70, height: 35))
                make.center.equalTo(self.contentView)
                make.left.equalTo(10)
            })
            textField.snp.makeConstraints({ (make) in
                make.left.equalTo(60)
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
                make.right.equalTo(-10)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
