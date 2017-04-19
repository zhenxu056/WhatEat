//
//  WECollectionFoodTableViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/19.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WECollectionFoodTableViewCell: UITableViewCell {
    
    let picImage: UIImageView = {
        let temImage = UIImageView()
        temImage.clipsToBounds = true
        temImage.layer.borderWidth = 1
        temImage.layer.borderColor = UIColor.gray.cgColor
        temImage.layer.cornerRadius = 10
        return temImage
    }()
    
    let titleLabel: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 15)
        temLabel.textColor = UIColor.black
        temLabel.text = "土豆丝"
        temLabel.numberOfLines = 1
        return temLabel
    }()
    
    let desclabel: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.gray
        temLabel.text = "这道菜非常的好吃，非常香甜.这道菜非常的好吃，非常香甜.这道菜非常的好吃，非常香甜.这道菜非常的好吃，非常香甜.这道菜非常的好吃，非常香甜.这道菜非常的好吃，非常香甜"
        temLabel.numberOfLines = 2
        return temLabel
    }()
    
    let timelabel: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.black
        temLabel.text = "2017.3.4 10:20"
        return temLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            self.contentView.addSubview(titleLabel)
            self.contentView.addSubview(desclabel)
            self.contentView.addSubview(picImage)
            self.contentView.addSubview(timelabel)
            picImage.snp.makeConstraints({ (make) in
                make.left.equalTo(10)
                make.centerY.equalTo(self.contentView.snp.centerY)
                make.size.equalTo(CGSize(width: 80, height: 80))
            })
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(picImage.snp.right).offset(10)
                make.top.equalTo(13)
                make.right.equalTo(-10)
            })
            desclabel.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(7)
                make.left.equalTo(picImage.snp.right).offset(10)
                make.right.equalTo(-10)
            })
            timelabel.snp.makeConstraints({ (make) in
                make.right.equalTo(-12)
                make.bottom.equalTo(-5)
                make.top.greaterThanOrEqualTo(desclabel.snp.bottom).offset(5)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
