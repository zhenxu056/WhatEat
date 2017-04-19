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
        drawView.backgroundColor = UIColor.orange
        return drawView
    }()
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30, height: 40)
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
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
        
        let viewSize:CGSize = self.view.bounds.size
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}
