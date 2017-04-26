//
//  WESelectMenuListView.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 2017/4/21.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit
 

class WESelectMenuListView: UIView,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var block: buttonAciton?
    fileprivate let mainSize: CGSize = UIScreen.main.bounds.size
    let view = UIView()
    var collectionView: UICollectionView?
    var effectView: UIVisualEffectView?
    
    var addDataList: Array<WEDrawFoodListModel> = Array<WEDrawFoodListModel>()
    var dataList: Array<WEFoodModel> = Array<WEFoodModel>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            view.frame = CGRect(x: 0, y: mainSize.height, width: mainSize.width , height: mainSize.height-mainSize.height/2)
            self.addSubview(view)
            let effect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            effectView = UIVisualEffectView(effect: effect)
            effectView?.frame = UIScreen.main.bounds
            self.insertSubview(effectView!, at: 0)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame = CGRect(x: 0, y: self.mainSize.height/2, width: self.mainSize.width , height: self.mainSize.height-self.mainSize.height/2)
            }, completion: { (isCompletion) in
                
            })
            
            addDataList = WEDrawFoodListModel.findAll() as! Array<WEDrawFoodListModel>
            dataList = WEFoodModel.findAll() as! Array<WEFoodModel>
            
            let layout = UICollectionViewFlowLayout() 
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
            collectionView?.delegate = self;
            collectionView?.dataSource = self;
            collectionView?.backgroundColor = UIColor.white
            collectionView?.register(WEFoodNameCollectionViewCell.self, forCellWithReuseIdentifier: "WEFoodNameCollectionViewCell")
            collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headViewSection1")
            collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headViewSection2")
            view.addSubview(collectionView!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return addDataList.count != 0 ? addDataList.count:0
        } else {
            return dataList.count != 0 ? dataList.count:0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WEFoodNameCollectionViewCell", for: indexPath) as! WEFoodNameCollectionViewCell
        if indexPath.section == 0 {
            cell.imageView.image = UIImage.init(named: "lable_type")
            cell.title.text = addDataList[indexPath.row].name
        } else {
            cell.title.text = dataList[indexPath.row].name
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let with:CGFloat = getTexWidth(textStr: addDataList[indexPath.row].name, font: UIFont.systemFont(ofSize: 14), height: 30)+10
            return CGSize(width: with, height: 30)
        } else {
            return CGSize(width: getTexWidth(textStr: dataList[indexPath.row].name, font: UIFont.systemFont(ofSize: 14), height: 30)+10, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.bounds.size.width, height: 50)
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 30)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { 
        if indexPath.section == 0 {
            let head: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headViewSection1", for: indexPath)
            
            let label = UILabel(frame: CGRect(x: 0, y: 5, width: collectionView.bounds.size.width  , height: 50))
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.text = "最多选择8个食物"
            label.textAlignment = .center
            head.addSubview(label)
            
            let cancel = UIButton(type: .system)
            cancel.frame = CGRect(x: 15, y: 10, width: 80, height: 30)
            cancel.setTitle("取消", for: .normal)
            cancel.setBackgroundImage(UIImage.init(named: "lable_teji"), for: .normal)
            cancel.setTitleColor(UIColor.white, for: .disabled)
            cancel.setTitleColor(UIColor.gray, for: .selected)
            cancel.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            cancel.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
            head.addSubview(cancel)
            
            let down = UIButton(type: .system)
            down.frame = CGRect(x: collectionView.bounds.size.width - 100, y: 10, width: 80, height: 30)
            down.setTitle("确定", for: .normal)
            down.setBackgroundImage(UIImage.init(named: "lable_type"), for: .normal)
            down.setTitleColor(UIColor.white, for: .disabled)
            down.setTitleColor(UIColor.gray, for: .selected)
            down.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            down.addTarget(self, action: #selector(downAction(sender:)), for: .touchUpInside)
            head.addSubview(down)
            
            let line = UIView(frame: CGRect(x: 0, y: 49, width: collectionView.bounds.size.width, height: 0.5))
            line.backgroundColor = UIColor.gray
            head.addSubview(line)
            
            return head
        } else {
            let head: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headViewSection2", for: indexPath)
            
            let line = UIView(frame: CGRect(x: 0, y: 1, width: collectionView.bounds.size.width, height: 0.5))
            line.backgroundColor = UIColor.gray
            head.addSubview(line)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: 30))
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.text = "全部食物"
            label.textAlignment = .center
            head.addSubview(label)
            
            let line2 = UIView(frame: CGRect(x: 0, y: 29, width: collectionView.bounds.size.width, height: 0.5))
            line2.backgroundColor = UIColor.gray
            head.addSubview(line2)
            
            return head
        }
    }
    
    func getTexWidth(textStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        let normalText: NSString = textStr as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.width
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let model = addDataList[indexPath.row]
            if model.deleteObject() {
                addDataList.remove(at: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
            } 
        } else {
            if addDataList.count < 8 {
                
                let temModel = dataList[indexPath.row]
                for sum in addDataList {
                    if temModel.name == sum.name {
                        return
                    }
                }
                let model = WEDrawFoodListModel()
                model.name = temModel.name
                model.desc = temModel.desc
                model.creatTime = temModel.creatTime
                model.idStr = temModel.idStr
                model.imageUrl = temModel.imageUrl
                model.latitude = temModel.latitude
                model.longitude = temModel.longitude
                model.isSelect = temModel.isSelect
                
                addDataList.append(model)
                model.save()
                collectionView.insertItems(at: [NSIndexPath.init(row: addDataList.count-1, section: 0) as IndexPath])
            }
        }
    }
} 

extension WESelectMenuListView {
    func cancelAction(sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: self.mainSize.height, width: self.mainSize.width , height: self.mainSize.height-self.mainSize.height/2)
        }, completion: { (isCompletion) in
            self.removeFromSuperview()
        })
    }
    
    func downAction(sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: self.mainSize.height, width: self.mainSize.width , height: self.mainSize.height-self.mainSize.height/2)
        }, completion: { (isCompletion) in
            if self.block != nil {
                self.block!(sender)
            }
            self.removeFromSuperview()
        })
    }
}
