//
//  WEConfigureFile.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/18.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEConfigureFile: NSObject {

    // MARK: - 单利
    static let shared = WEConfigureFile()
    private override init() {
        
    }
    
    let height: CGFloat = UIScreen.main.bounds.height
    let width: CGFloat = UIScreen.main.bounds.width
    
    

}
