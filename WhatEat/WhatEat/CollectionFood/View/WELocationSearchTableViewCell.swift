//
//  WELocationSearchTableViewCell.swift
//  WhatEat
//
//  Created by RuiTong_MAC on 2017/4/26.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WELocationSearchTableViewCell: UITableViewCell { 
    
    let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.textColor = UIColor.black
        field.font = UIFont.systemFont(ofSize: 14)
        field.placeholder = "请输入地址"
        return field
    }()
    
    let button: UIButton = {
        let temButton = UIButton()
        temButton.setBackgroundImage(UIImage(named:"bg_btn_blue"), for: .normal)
        temButton.setTitle("保存", for: .normal)
        temButton.setTitleColor(UIColor.white, for: .normal)
        return temButton
    }()
    
    let label: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.black
        temLabel.text = "位置："
        return temLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            
            self.contentView.addSubview(label)
            self.contentView.addSubview(textField)
            self.contentView.addSubview(button)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView)
                make.left.equalTo(10)
            })
            textField.snp.makeConstraints({ (make) in
                make.left.equalTo(60)
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
                make.right.equalTo(-50)
            })
            button.snp.makeConstraints({ (make) in
                make.left.equalTo(textField.snp.right)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.right.equalTo(5)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
