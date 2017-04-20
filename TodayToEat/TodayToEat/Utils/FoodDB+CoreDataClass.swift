//
//  FoodDB+CoreDataClass.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/18.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import Foundation
import CoreData

@objc(FoodDB)
public class FoodDB: NSManagedObject {
    // Insert code here to add functionality to your managed object subclass
    /*
     一般涉及到的情况有：增删改，单对象查询，分页查询（所有，条件查询，排序），对象是否存在，批量增加，批量修改
     */
    
    /// 判断对象是否存在, obj参数是当前属性的字典
    class func exsitsObject(obj:[String:String]) -> Bool {
        
        //获取管理数据对象的上下文
        let context = ZXStoreManager.shared.managedObjectContext
        //声明一个数据请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodDB")
        
        //组合过滤参数
        let desc = obj["desc"]
        let name = obj["name"]
        let creatTime = obj["creatTime"]
        
        
        //方式一
        let predicate1 = NSPredicate(format: "desc = %@", desc!)
        let predicate2 = NSPredicate(format: "name = %@", name!)
        let predicate3 = NSPredicate(format: "creatTime = %@", creatTime!)
        //合成过滤条件
        //or ,and, not , 意思是：或与非，懂数据库的同学应该就很容易明白
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1,predicate2,predicate3])
        //let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2])
        fetchRequest.predicate = predicate
        
        //方式二
        //fetchRequest.predicate = NSPredicate(format: "stuId = %@ or name = %@", stuId!, name!)
        //fetchRequest.predicate = NSPredicate(format: "stuId = %@ and name = %@", stuId!, name!)
        
        do{
            let fetchObjects:[AnyObject]? = try context.fetch(fetchRequest)
            
            return (fetchObjects?.count)! > 0 ? true : false
        }catch {
            fatalError("exsitsObject \(error)")
        }
        
        return false
    }
    
    /// 添加对象, obj参数是当前属性的字典
    class func insertObject(obj: [String:String]) -> Bool {
        
        //如果存在对象了就返回
        if exsitsObject(obj: obj) {
            return false
        }
        
        //获取管理的数据上下文 对象
        let context = ZXStoreManager.shared.managedObjectContext
        
        //创建学生对象
        let food = NSEntityDescription.insertNewObject(forEntityName: "FoodDB", into: context) as! FoodDB
        
//        //对象赋值
//        let sexStr:String
//        if obj["sex"] == "男"{
//            sexStr = "1"
//        }else{
//            sexStr = "0"
//        }
        let numberFMT = NumberFormatter()
        numberFMT.numberStyle = .none
        food.desc = obj["desc"]
        food.name = obj["name"]
        food.creatTime = obj["creatTime"]
        
        //保存
        do {
            try context.save()
            print("保存成功！")
            return true
        } catch {
            fatalError("不能保存：\(error)")
        }
        return false
    }
    
    /// 删除对象
    class func deleteObject(obj: FoodDB) -> Bool{
        
        //获取管理的数据上下文 对象
        let context = ZXStoreManager.shared.managedObjectContext
        
        //方式一: 比如说列表已经是从数据库中获取的对象，直接调用CoreData默认的删除方法
        context.delete(obj)
        ZXStoreManager.shared.saveContext()
        
        //方式二：通过obj参数比如：id,name ,通过这样的条件去查询一个对象一个，把这个对象从数据库中删除
        //代码：略
        
        return true
    }
    
    /// 更新对象
    class func updateObject(obj:[String: String]) -> Bool {
        //obj参数说明：当前对象的要更新的字段信息，唯一标志是必须的，其他的是可选属性
        let context = ZXStoreManager.shared.managedObjectContext
        
        let oid = obj["name"]
        let student:FoodDB = self.fetchObjectByName(name: oid!)! as! FoodDB
        
        //遍历参数，然后替换相应的参数
        let numberFMT = NumberFormatter()
        numberFMT.numberStyle = .none
        
        for key in obj.keys {
            switch key {
            case "name":
                student.name = obj["name"]
            case "creatTime":
                student.creatTime = obj["creatTime"]
            case "desc":
                student.desc = obj["desc"]
            default:
                print("如果有其他参数需要修改，类似")
            }
        }
        
        //执行更新操作
        do {
            try context.save()
            print("更新成功！")
            return true
        } catch {
            fatalError("不能保存：\(error)")
        }
        
        return false
    }
    
    /// 查询对象
    class func fetchObjects(pageIndex:Int, pageSize:Int) -> [AnyObject]? {
        //获取管理的数据上下文 对象
        let context = ZXStoreManager.shared.managedObjectContext
        
        //声明数据的请求
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodDB")
        fetchRequest.fetchLimit = pageSize //每页大小
        fetchRequest.fetchOffset = pageIndex * pageSize //第几页
        
        //设置查询条件:参考exsitsObject
        //let predicate = NSPredicate(format: "id= '1' ", "")
        //fetchRequest.predicate = predicate
        
        //设置排序
        //按学生ID降序
        let stuIdSort = NSSortDescriptor(key: "creatTime", ascending: false)
        //按照姓名升序
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors:[NSSortDescriptor] = [stuIdSort,nameSort]
        fetchRequest.sortDescriptors = sortDescriptors
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.fetch(fetchRequest)
            
            //遍历查询的结果
            for info:FoodDB in fetchedObjects as! [FoodDB]{
                print("creatTime=\(info.creatTime!)")
                print("name=\(info.name!)")
                print("name=\(info.name!)")
                print("-------------------")
            }
            
            return fetchedObjects
        }
        catch {
            fatalError("不能保存：\(error)")
        }
        return nil
    }
    
    /// 根据ID查询当个对象
    class func fetchObjectByName(name:String) -> AnyObject?{
        
        //获取上下文对象
        let context = ZXStoreManager.shared.managedObjectContext
        
        //创建查询对象
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodDB")
        
        //构造参数
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        //执行代码并返回结果
        do{
            let results:[AnyObject]? = try context.fetch(fetchRequest)
            
            if (results?.count)! > 0 {
                return results![0]
            }
        }catch{
            fatalError("查询当个对象致命错误：\(error)")
        }
        
        return nil
    }
}


