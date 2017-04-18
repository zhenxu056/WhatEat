//
//  WEFoodViewModel.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/17.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit 

extension WEFoodViewModel {
    private static var onceToken = [String]()
    public class func once(_ token: String, _ block:@escaping () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if onceToken.contains(token) {
            return
        }
        onceToken.append(token)
        block()
    }
}

class WEFoodViewModel: NSObject {
    
    func getPlistList() -> NSMutableArray {
        let path = getPlistPathFile()
        let temArray  = NSMutableArray(contentsOfFile: path)!
        return temArray
    }
    
    func deletePlist(dModel: WEFoodModel) {
        let array = NSMutableArray(array: getPlistList())
        var index: Int = 0
        for i in 1...array.count {
            let dic:NSDictionary = array[i-1] as! NSDictionary
            if dic["id"] as! String == dModel.idStr {
                print(dic["id"] as! String)
                index = i
                break
            }
        }
        if index != 0 {
            array.removeObject(at: (index - 1))
        } 
        let good: Bool = array.write(toFile: getPlistPathFile(), atomically: true)
        good ? print("删除成功"): print("删除失败")
        
    }
}

fileprivate extension WEFoodViewModel {
    func getPlistPathFile() -> String {
        let data = Bundle.main.path(forResource: "AlreadyFood", ofType: "plist")
        return data!
    }
}
