//
//  WEFoodDrawViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEFoodDrawViewController: WEBaseMainViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "抽啥吃"
        setUI()
    } 
}


extension WEFoodDrawViewController {
    func setUI() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let viewSize:CGSize = self.view.bounds.size
        drawView.initView(array: ["苹果","香蕉","菠萝","橘子"])
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
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WEDrawFoodCollectionViewCell", for: indexPath) as! WEDrawFoodCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
}
