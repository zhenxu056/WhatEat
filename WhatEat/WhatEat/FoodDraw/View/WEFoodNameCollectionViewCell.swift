//
//  WEFoodNameCollectionViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 2017/4/21.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEFoodNameCollectionViewCell: UICollectionViewCell {
    let title: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.gray
        temLabel.textAlignment = .center
        temLabel.sizeToFit()
        return temLabel
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "lable_jinji")
        return imageView
    }() 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) { 
            self.contentView.addSubview(imageView)
            self.contentView.addSubview(title)
            imageView.snp.makeConstraints({ (make) in
                make.center.equalTo(self.contentView)
                make.size.equalTo(self.contentView.bounds.size)
            })
            title.snp.makeConstraints({ (make) in
                make.center.equalTo(self.contentView)
                make.size.equalTo(self.contentView.bounds.size)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
