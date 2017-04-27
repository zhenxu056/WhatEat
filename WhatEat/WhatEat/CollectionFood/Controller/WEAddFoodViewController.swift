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
    
    var dict:[String: AnyObject] = Dictionary()
    
    lazy var tableView: UITableView =  {
        let temTableView = UITableView(frame: self.view.bounds)
        temTableView.delegate = self
        temTableView.dataSource = self
        temTableView.separatorStyle = .none
        temTableView.backgroundColor = UIColor.clear
        temTableView.keyboardDismissMode = .onDrag
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
        return 5
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
            return 44
        } else if indexPath.section == 3 {
            return contentHeight
        } else if indexPath.section == 4 {
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
            cell.block = { image in
                let data = UIImagePNGRepresentation(image)
                let imageString = data?.base64EncodedString()
                self.dict["imageUrl"] = imageString as AnyObject
            }
            return cell
        } else if indexPath.section == 1 {
            let textField = "WEAddFoodTableViewCell"
            let cell: WEAddFoodTableViewCell = WEAddFoodTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.textField.tag = 100
            cell.textField.delegate = self
            return cell
        }  else if indexPath.section == 2 {
            let textField = "WELocationSearchTableViewCell"
            let cell: WELocationSearchTableViewCell = WELocationSearchTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.textField.tag = 102
            cell.textField.delegate = self
            cell.button.addTarget(self, action: #selector(selectLocationAction(sender:)), for: .touchUpInside)
            return cell
        } else if indexPath.section == 3 {
            let textField = "WEFoodTextViewTableViewCell"
            let cell: WEFoodTextViewTableViewCell = WEFoodTextViewTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.backgroundColor = UIColor.clear
            cell.textView.tag = 101
            cell.textView.delegate = self
            return cell
        } else {
            let textField = "WEButtonTableViewCell"
            let cell: WEButtonTableViewCell = WEButtonTableViewCell(style: .subtitle, reuseIdentifier: textField)
            cell.backgroundColor = UIColor.clear
            cell.block =  { sender in 
                let model = WEFoodModel.dictToModel(dic: self.dict) 
                model.save()
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

fileprivate extension WEAddFoodViewController {
    func setUI() {
        self.view.addSubview(tableView)
    }
    
    @objc func selectLocationAction(sender: UIButton) {
        let serchBar = WELocationSearchViewController()
        let serchNa = WEBaseNavigationController(rootViewController: serchBar)
        serchBar.block = { ann in
            let indexPath = IndexPath(item: 0, section: 2)
            
            let cell = self.tableView.cellForRow(at: indexPath) as! WELocationSearchTableViewCell
            print(ann.title)
            cell.textField.text = ann.title
        }
        self.present(serchNa, animated: true, completion: nil)
    }
}

extension WEAddFoodViewController: UITextViewDelegate, UITextFieldDelegate {
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 101 {
            dict["describe"] = textView.text as AnyObject
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            dict["foodName"] = textField.text as AnyObject
        }
    }
}
