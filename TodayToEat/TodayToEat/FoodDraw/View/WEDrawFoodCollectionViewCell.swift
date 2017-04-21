//
//  WEDrawFoodCollectionViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 2017/4/20.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEDrawFoodCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let title: UILabel = {
        let temLabel = UILabel()
        temLabel.font = UIFont.systemFont(ofSize: 14)
        temLabel.textColor = UIColor.white
        temLabel.text = "菠萝"
        temLabel.textAlignment = .center
        return temLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 10
            self.clipsToBounds = true
            
            self.contentView.addSubview(imageView)
                         
            imageView.image = UIImage.init(named: "timg.jpeg")
            
            let effect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let effectView = UIVisualEffectView(effect: effect) 
            
            effectView.contentView.addSubview(title)
            self.contentView.insertSubview(effectView, at: 1)
            
            effectView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.height.equalTo(self.bounds.height/4)
            })
            
            imageView.snp.makeConstraints({ (make) in 
                make.center.equalTo(self.contentView)
                make.size.equalTo(self.contentView.bounds.size)
            })
            
            title.snp.makeConstraints({ (make) in
                make.left.equalTo(5)
                make.bottom.equalTo(-15)
                make.right.equalTo(-10)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
