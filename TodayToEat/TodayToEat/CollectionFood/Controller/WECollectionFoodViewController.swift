//
//  WECollectionFoodViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WECollectionFoodViewController: WEBaseMainViewController {
    
    lazy var tableView: UITableView =  {
        let temTableView = UITableView(frame: self.view.bounds)
        temTableView.delegate = self
        temTableView.dataSource = self
        return temTableView
    }()
    
    lazy var rightBarItem: UIBarButtonItem = {
        let temRightBarItem = UIBarButtonItem(title: "删除", style: UIBarButtonItemStyle.plain, target: self, action:#selector(rightBarItemAction(sender:)))
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
        print("我要删除")
    }
}

extension WECollectionFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInd = "cell"
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: cellInd)
        cell.textLabel?.text = "现在在第\(indexPath.row)个"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        print("你点击了    \(cell!.textLabel!.text)")
    }
}
