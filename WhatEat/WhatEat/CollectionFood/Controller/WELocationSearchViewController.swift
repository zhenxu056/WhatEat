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
    
    var mapView: BMKMapView = {
        let mapView = BMKMapView(frame: UIScreen.main.bounds)
        mapView.viewWillAppear()
        mapView.mapType = UInt(BMKMapTypeStandard)
        mapView.isZoomEnabled = true
        return mapView
    }()
    
    var locService: BMKLocationService?
    var geocodeSearch: BMKGeoCodeSearch!
    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locService?.delegate = self
        geocodeSearch.delegate = self
        mapView.delegate = self
        mapView.viewWillAppear()
        
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
extension WELocationSearchViewController: BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate {
    func didUpdate(_ userLocation: BMKUserLocation!) {
        let region = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
        
        let annotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)
        mapView.addAnnotation(annotation)
        
        mapView.updateLocationData(userLocation)
    }
    
    // MARK: - BMKMapViewDelegate
    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
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
    // MARK: - BMKGeoCodeSearchDelegate
    
    /**
     *返回地址信息搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结BMKGeoCodeSearch果
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetGeoCodeResult error: \(error)")
        
        mapView.removeAnnotations(mapView.annotations)
        if error == BMK_SEARCH_NO_ERROR {
            let item = BMKPointAnnotation()
            item.coordinate = result.location
            item.title = result.address
            mapView.addAnnotation(item)
            mapView.centerCoordinate = result.location
            
            let showMessage = "纬度:\(item.coordinate.latitude)，经度:\(item.coordinate.longitude)"
            print(showMessage)
            let alertView = UIAlertController(title: "正向地理编码", message: showMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}

extension WELocationSearchViewController {
    func addUI() {
        
        self.navigationItem.rightBarButtonItem = rightBarItem
        self.navigationItem.leftBarButtonItem = leftBarItem
        
        self.view.addSubview(mapView)
        locService = BMKLocationService()
        geocodeSearch = BMKGeoCodeSearch()
        locService?.startUserLocationService()
        
        mapView.showsUserLocation = false//先关闭显示的定位图层
        mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        mapView.showsUserLocation = true//显示定位图层
        
        
        let locationView = WESearchLocationView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2))
        locationView.mapView = mapView
        locationView.geocodeSearch = geocodeSearch
        self.view.addSubview(locationView) 
    }
}

extension WELocationSearchViewController {
    func rightBarItemAction(sender: UIBarButtonItem) {
        let geocodeSearchOption = BMKGeoCodeSearchOption()
//        geocodeSearchOption.city = cityField.text
//        geocodeSearchOption.address = addressField.text
        let flag = geocodeSearch.geoCode(geocodeSearchOption)
        if flag {
            print("geo 检索发送成功")
        } else {
            print("geo 检索发送失败")
        }

    }
    
    func leftBarItemAction(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
