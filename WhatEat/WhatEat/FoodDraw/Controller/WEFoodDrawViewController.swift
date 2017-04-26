//
//  WEFoodDrawViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEFoodDrawViewController: WEBaseMainViewController {
    
    
    
    var dataList: Array<WEDrawFoodListModel> = Array<WEDrawFoodListModel>()
    
    let drawView: WEDrawFoodView = {
        let drawView = WEDrawFoodView()
        return drawView
    }()
    
    let collectionView: UICollectionView = {
        var layout = RGPaperLayout()
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height:0), collectionViewLayout: layout)
        collectionView.register(WEDrawFoodCollectionViewCell.self, forCellWithReuseIdentifier: "WEDrawFoodCollectionViewCell")
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    lazy var rightBarItem: UIBarButtonItem = {
        let temRightBarItem = UIBarButtonItem(title: "编辑", style: UIBarButtonItemStyle.plain, target: self, action:#selector(rightBarItemAction(sender:)))
        temRightBarItem.tintColor = UIColor.white
        return temRightBarItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "抽啥吃"
        reloadData()
        setUI()
    } 
}

extension WEFoodDrawViewController {
    func rightBarItemAction(sender: UIBarButtonItem) {
        let window = UIApplication.shared.keyWindow
        let selectMenu: WESelectMenuListView = WESelectMenuListView()
        selectMenu.frame = UIScreen.main.bounds
        selectMenu.block = { sender in
            self.reloadData()
        }
        window?.addSubview(selectMenu) 
    }
}

extension WEFoodDrawViewController {
    func reloadData() {
        dataList = WEDrawFoodListModel.findAll() as! Array<WEDrawFoodListModel>
        collectionView.reloadData() 
    }
    func setUI() {
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let viewSize:CGSize = self.view.bounds.size
        var listName: Array<String> = Array()
        for model in dataList {
            listName.append(model.name)
        }
        drawView.initView(array: listName, completion: { index in
            self.dataList.removeAll()
            self.reloadData()
            let model: WEDrawFoodListModel = self.dataList[index] 
            model.isSelect = true 
            self.dataList[index] = model
            if index == 0 {
                self.collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .left, animated: true)
            } else {
                self.collectionView.scrollToItem(at: IndexPath.init(row: index-1, section: 0), at: .left, animated: true)
            }
            self.collectionView.reloadData()
        })
        self.view.addSubview(drawView)
        
        drawView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(65)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(viewSize.height/3.5*2)
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(drawView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-50)
        }
        
    }
}

extension WEFoodDrawViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WEDrawFoodCollectionViewCell", for: indexPath) as! WEDrawFoodCollectionViewCell
        if indexPath.row != dataList.count {
            let model = dataList[indexPath.row] 
            cell.title.text = model.name
            if model.isSelect {
                cell.layer.borderColor = UIColor.red.cgColor
            } else {
                cell.layer.borderColor = UIColor.black.cgColor
            }
        }
        return cell
    }
}
