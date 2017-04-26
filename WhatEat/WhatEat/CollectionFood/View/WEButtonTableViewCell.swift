//
//  WEButtonTableViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/18.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

typealias buttonAciton = (UIButton)->()

class WEButtonTableViewCell: UITableViewCell {

    let x:CGFloat = 15
    let y:CGFloat = 10
    let line:CGFloat = 5
    
    var block: buttonAciton?
    
    let button: UIButton = {
        let temButton = UIButton()
        temButton.setBackgroundImage(UIImage(named:"bg_btn_blue"), for: .normal)
        temButton.setTitle("保存", for: .normal)
        temButton.setTitleColor(UIColor.white, for: .normal)
        return temButton
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            button.addTarget(self, action: #selector(submitButtonAction(sender:)), for: .touchUpInside)
            self.contentView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.center.equalTo(self.contentView)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WEButtonTableViewCell {
    func submitButtonAction(sender: UIButton) {
        print("保存") 
        if self.block != nil {
            self.block!(sender)
        }
    }
}
