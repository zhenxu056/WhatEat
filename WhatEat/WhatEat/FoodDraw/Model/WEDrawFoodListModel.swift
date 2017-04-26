//
//  WEDrawFoodListModel.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 2017/4/24.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEDrawFoodListModel: JKDBModel {
    var name: String = ""
    var idStr: String = ""
    var desc: String = ""
    var longitude: String = ""
    var latitude: String = ""
    var imageUrl: String = ""
    var creatTime: String = ""
    var isSelect: Bool = false
    
    class func dictToModel(dic: [String: AnyObject]) -> WEFoodModel {
        let  model = WEFoodModel()
        if let foodName = dic["foodName"] {
            model.name = foodName as! String
        } else {
            model.name = ""
        }
        if let idStr = dic["id"] {
            model.idStr = idStr as! String
        } else {
            model.idStr = ""
        }
        if let desc = dic["describe"] {
            model.desc = desc as! String
        } else {
            model.desc = ""
        }
        if let longitude = dic["longitude"] {
            model.longitude = longitude as! String
        } else {
            model.longitude = ""
        }
        if let imageUrl = dic["imageUrl"] {
            model.imageUrl = imageUrl as! String
        } else {
            model.imageUrl = ""
        }
        if let isSelect = dic["isSelect"] {
            model.isSelect = isSelect as! Bool
        } else {
            model.isSelect = false
        }
        
        let timeStr: String?
        let date = NSDate()
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        timeStr = formatter.string(from: date as Date)
        
        model.creatTime = timeStr ?? "未知"
        
        return model
    }
    
}
