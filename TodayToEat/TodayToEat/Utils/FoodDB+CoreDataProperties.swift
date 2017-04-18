//
//  FoodDB+CoreDataProperties.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/18.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import Foundation
import CoreData


extension FoodDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodDB> {
        return NSFetchRequest<FoodDB>(entityName: "FoodDB");
    }

    @NSManaged public var creatTime: String? 
    @NSManaged public var desc: String?
    @NSManaged public var name: String?

}
