//
//  WELocationSearchTableViewCell.swift
//  WhatEat
//
//  Created by RuiTong_MAC on 2017/4/26.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WELocationSearchTableViewCell: UITableViewCell {

    let locationlabel: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.black
        temLabel.text = " "
        return temLabel
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
            self.contentView.addSubview(locationlabel)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView)
                make.left.equalTo(10)
            })
            locationlabel.snp.makeConstraints({ (make) in
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
 
