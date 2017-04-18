//
//  WEFoodModel.swift
//  TodayToEat
//
//  Created by 陈振旭 on 2017/4/15.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEFoodModel: NSObject {
    var foodName: String = ""
    var idStr: String = ""
    var desc: String = "" 
    
    class func dictToModel(dic: [String: AnyObject]) -> WEFoodModel {
        let  model = WEFoodModel()
        guard let foodName = dic["foodName"] ,  let idStr = dic["id"],  let desc = dic["describe"]  else {
            print("数据解析错误")
            return model
        }
        model.foodName = foodName as! String
        model.idStr = idStr as! String
        model.desc = desc as! String
        return model
    }
    
    
}

