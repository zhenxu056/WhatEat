//
//  WEDrawFoodListModel.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 2017/4/24.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEDrawFoodListModel: NSObject {
    var foodName: String = ""
    var idStr: String = ""
    var desc: String = ""
    var isSelect: Bool = false
    
    class func dictToModel(dic: [String: AnyObject]) -> WEDrawFoodListModel {
        let  model = WEDrawFoodListModel()
        guard let foodName = dic["foodName"] ,  let idStr = dic["id"],  let desc = dic["describe"], let isSelect = dic["isSelect"]  else {
            print("数据解析错误")
            return model
        }
        model.foodName = foodName as! String
        model.idStr = idStr as! String
        model.desc = desc as! String
        model.isSelect = isSelect as! Bool
        return model
    }
    
}
