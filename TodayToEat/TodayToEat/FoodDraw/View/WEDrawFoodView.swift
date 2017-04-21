//
//  WEDrawFoodView.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/19.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEDrawFoodView: UIView {

    
    var array: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) { 
        fatalError("init(coder:) has not been implemented")
    }

    func initView(array: [String], completion: @escaping (_ index:Int)->()) {
        let draw = LotteryRouletteView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height/3.5*2 - 40), prizeArr: array , progress: { currentProgress, totalProgress in
            
        }, completion: { index in 
            completion(index)
        })
        draw?.center = CGPoint(x: UIScreen.main.bounds.width/2.0, y: UIScreen.main.bounds.height/3.5)
        draw?.prizeBgColor = UIColor(colorLiteralRed: 141 / 255.0, green:190 / 255.0, blue:246 / 255.0, alpha: 1)
        draw?.centerBgColor = UIColor.purple
        self.addSubview(draw!)
    }
    
}

