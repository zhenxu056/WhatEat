//
//  WEAddFoodViewController.swift
//  TodayToEat
//
//  Created by 陈振旭 on 2017/4/15.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEAddFoodViewController: WEBaseMainViewController {

    lazy var contentHeight: CGFloat = 120
    
    lazy var tableView: UITableView =  {
        let temTableView = UITableView(frame: self.view.bounds)
        temTableView.delegate = self
        temTableView.dataSource = self
        temTableView.separatorStyle = .none
        temTableView.backgroundColor = UIColor.clear
        return temTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "添加食物"
        setUI()
    } 
}

extension WEAddFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else if indexPath.section == 2 {
            return contentHeight
        } else if indexPath.section == 3 {
            return 60
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let textField = "WEImageCenterTableViewCell"
            let cell: WEImageCenterTableViewCell = WEImageCenterTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.backgroundColor = UIColor.clear
            cell.controller = self
            cell.block = { sender in
                
            }
            return cell
        } else if indexPath.section == 1 {
            let textField = "WEAddFoodTableViewCell"
            let cell: WEAddFoodTableViewCell = WEAddFoodTableViewCell(style: .subtitle, reuseIdentifier: textField)
            return cell
        } else if indexPath.section == 2 {
            let textField = "WEFoodTextViewTableViewCell"
            let cell: WEFoodTextViewTableViewCell = WEFoodTextViewTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.backgroundColor = UIColor.clear
            cell.textView.delegate = self
            return cell
        } else {
            let textField = "WEButtonTableViewCell"
            let cell: WEButtonTableViewCell = WEButtonTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.backgroundColor = UIColor.clear
            cell.block =  { sender in
                print("我保存了  \(sender.currentTitle!)")
            }
            return cell
        }
    }
}

fileprivate extension WEAddFoodViewController {
    func setUI() {
        self.view.addSubview(tableView)
    }
}

extension WEAddFoodViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        var bounds = textView.bounds
        let width: CGFloat = bounds.width
        let maxSize = CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        var newSize = textView.sizeThatFits(maxSize)
        if newSize.height < 120 {
            newSize.height = 120
            contentHeight = 120
        }
        bounds.size = newSize
        bounds.size.width = width
        textView.bounds = bounds
        contentHeight = newSize.height + 10
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
