//
//  WELocationSearchViewController.swift
//  WhatEat
//
//  Created by RuiTong_MAC on 2017/4/26.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WELocationSearchViewController: WEBaseMainViewController {

    lazy var rightBarItem: UIBarButtonItem = {
        let temRightBarItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action:#selector(rightBarItemAction(sender:)))
        temRightBarItem.tintColor = UIColor.white
        return temRightBarItem
    }()
    lazy var leftBarItem: UIBarButtonItem = {
        let temRightBarItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action:#selector(leftBarItemAction(sender:)))
        temRightBarItem.tintColor = UIColor.white
        return temRightBarItem
    }()
    
    var annotationImage: UIImageView?
    var geocodeSearch: BMKGeoCodeSearch!
    var selectAnnotation:BMKPointAnnotation = BMKPointAnnotation()
    var block: sendBMKPointAnnotation?
    
    var mapView: BMKMapView = {
        let mapView = BMKMapView(frame: UIScreen.main.bounds)
        mapView.viewWillAppear()
        mapView.mapType = UInt(BMKMapTypeStandard)
        mapView.isZoomEnabled = true
        mapView.showMapScaleBar = true
        mapView.zoomLevel = 17.0
        return mapView
    }()
    
    var locService: BMKLocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择位置"
        addUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        mapView.delegate = self
        locService?.delegate = self
        mapView.viewWillAppear()
        geocodeSearch.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
        mapView.delegate = nil // 不用时，置nil
        locService?.delegate = nil
        geocodeSearch.delegate = nil
    }
    
}

//百度地图
extension WELocationSearchViewController: BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate {
    func didUpdate(_ userLocation: BMKUserLocation!) {
        let region = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: - BMKMapViewDelegate
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let AnnotationViewID = "renameMark"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationViewID) as! BMKPinAnnotationView?
        if annotationView == nil {
            annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
            // 设置颜色
            annotationView!.pinColor = UInt(BMKPinAnnotationColorRed)
            // 从天上掉下的动画
            annotationView!.animatesDrop = true
            // 设置是否可以拖拽
            annotationView!.isDraggable = true
        }
        annotationView?.annotation = annotation
        return annotationView
    }
    
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        
    }
    
    /**
     *返回反地理编码搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetReverseGeoCodeResult error: \(error)")
        
        if error == BMK_SEARCH_NO_ERROR {
            let item = BMKPointAnnotation()
            item.coordinate = result.location
            item.title = result.address
            print(result.address)
            selectAnnotation = item
            
            if self.block != nil {
                self.block!(selectAnnotation)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}

extension WELocationSearchViewController {
    func addUI() {
        
        self.navigationItem.rightBarButtonItem = rightBarItem
        self.navigationItem.leftBarButtonItem = leftBarItem
        self.view.addSubview(mapView) 
        geocodeSearch = BMKGeoCodeSearch()
        
        locService = BMKLocationService()
        locService?.startUserLocationService()
        
        mapView.showsUserLocation = false//先关闭显示的定位图层
        mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        mapView.showsUserLocation = true//显示定位图层
        
        
        let locationView = WESearchLocationView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        locationView.block = { item in
            let region = BMKCoordinateRegionMake(item.coordinate, BMKCoordinateSpanMake(0.01, 0.01))
            self.mapView.setRegion(region, animated: true)
        }
        self.view.addSubview(locationView) 
        
        let point = UIScreen.main.bounds.size
        annotationImage = UIImageView(frame: CGRect(x: point.width/2-10, y: point.height/2-20, width: 40, height: 40))
        annotationImage?.image = UIImage(named: "myPin_red")
        self.view.addSubview(annotationImage!)
    }
}

extension WELocationSearchViewController {
    func rightBarItemAction(sender: UIBarButtonItem) {
        let pint = annotationImage?.center
        let location: CLLocationCoordinate2D = mapView.convert(pint!, toCoordinateFrom: mapView)
        
        let reverseGeocodeSearchOption = BMKReverseGeoCodeOption()
        reverseGeocodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let flag = geocodeSearch.reverseGeoCode(reverseGeocodeSearchOption)
        if flag {
            print("反geo 检索发送成功")
        } else {
            print("反geo 检索发送失败")
        }
    }
    
    func leftBarItemAction(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
