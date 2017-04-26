//
//  WEFoodMenuViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEFoodMenuViewController: WEBaseMainViewController, BMKMapViewDelegate {
    var _mapView: BMKMapView? //百度地图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "吃啥找啥"
        setMapView()
        
        let addNumber: (Int, Int) -> Int = {
            (a:Int, b:Int) -> Int in
            return a+b
        }
        print(addNumber(3,5))
        addBlock(frist: 3, second: 4) { (a, b, sum) in
            print("\(a)+\(b)=\(sum)")
        }
    }
    
    
    func addBlock(frist:Int, second: Int, completion:(_ a: Int, _ b: Int, _ sum: Int)-> ()){
        let sum = frist + second
        completion(frist,second,sum)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillDisappear()
        _mapView?.delegate = nil // 不用时，置nil
    }
 
}

//百度地图
extension WEFoodMenuViewController {
    func setMapView() {
        _mapView = BMKMapView(frame: UIScreen.main.bounds)
        _mapView?.viewWillAppear()
        _mapView?.mapType = UInt(BMKMapTypeSatellite)
        _mapView?.delegate = self // 此处记得不用的时候需要置nil，否则影响内存的释放
        self.view.addSubview(_mapView!)
    }
    
}
