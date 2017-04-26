//
//  WEFoodTextViewTableViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/18.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEFoodTextViewTableViewCell: UITableViewCell {

    let x:CGFloat = 10
    let y:CGFloat = 10
    let line:CGFloat = 5
    
    let textView: SZTextView = {
        let text = SZTextView()
        text.placeholder = "请输入对此物品的备注或描述……"
        text.textColor = UIColor.black
        text.font = UIFont.systemFont(ofSize: 14)
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 10.0
        text.layer.borderColor = UIColor.gray.cgColor
        text.isScrollEnabled = false
        return text
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            self.contentView.addSubview(textView)
            textView.snp.makeConstraints({ (make) in
                make.topMargin.equalTo(0)
                make.leftMargin.equalTo(0)
                make.rightMargin.equalTo(0)
                make.bottomMargin.equalTo(0) 
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

} 
