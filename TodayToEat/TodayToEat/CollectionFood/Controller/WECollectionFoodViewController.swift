//
//  WECollectionFoodViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WECollectionFoodViewController: WEBaseMainViewController {
    
   fileprivate lazy var plistArray = { () -> Array<AnyObject> in
        let data = Bundle.main.path(forResource: "AlreadyFood", ofType: "plist")
        let temArray  = NSMutableArray(contentsOfFile: data!)! as Array
        return temArray
    }()
    
    fileprivate lazy var listArray: NSMutableArray = {
        var array = NSMutableArray()
        for dic in self.plistArray as! [[String: AnyObject]] {
            let model = WEFoodModel.dictToModel(dic: dic)
            array.add(model)
        } 
        return array
    }()
    
    lazy var tableView: UITableView =  {
        let temTableView = UITableView(frame: self.view.bounds)
        temTableView.delegate = self
        temTableView.dataSource = self
        return temTableView
    }()
    
    lazy var rightBarItem: UIBarButtonItem = {
        let temRightBarItem = UIBarButtonItem(title: "添加", style: UIBarButtonItemStyle.plain, target: self, action:#selector(rightBarItemAction(sender:)))
        temRightBarItem.tintColor = UIColor.white
        return temRightBarItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "收集"
        addUI()
    }
}

extension WECollectionFoodViewController {
    func addUI() {
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
}

extension WECollectionFoodViewController {
    func rightBarItemAction(sender: UIBarButtonItem) { 
        let addFoodVC = WEAddFoodViewController()
        self.navigationController?.pushViewController(addFoodVC, animated: true)
        
    }
}

extension WECollectionFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInd = "cell"
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: cellInd)
        let model = listArray[indexPath.row] as! WEFoodModel
        cell.textLabel?.text = "现在在第\(indexPath.row)个  名字叫\(model.foodName)"
        cell.detailTextLabel?.text = model.desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        print("你点击了    \(String(describing: cell!.textLabel!.text))") 
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("我删除了")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
