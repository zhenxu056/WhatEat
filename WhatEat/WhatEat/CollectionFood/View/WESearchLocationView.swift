//
//  WESearchLocationView.swift
//  WhatEat
//
//  Created by RuiTong_MAC on 2017/4/26.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

typealias sendBMKPointAnnotation = (BMKPointAnnotation)->()

class WESearchLocationView: UIView {

    var block: sendBMKPointAnnotation?
    var tableView: UITableView?
    fileprivate var poiSearch: BMKPoiSearch!
    fileprivate var dataList:Array<BMKPointAnnotation> = Array()
    fileprivate var currPageIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            self.backgroundColor = UIColor.init(red: 144/255.0, green: 144/255.0, blue: 144/255.0, alpha: 0.7)
            self.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 40)
            tableView = UITableView(frame: self.bounds, style: .plain)
            tableView?.backgroundColor = UIColor.clear
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "SearchLocation")
            self.addSubview(tableView!)
            poiSearch = BMKPoiSearch()
            poiSearch.delegate = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    deinit {
        poiSearch.delegate = nil
    }

}

extension WESearchLocationView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        searchBar.placeholder = "搜索位置"
        searchBar.barStyle = .default
        searchBar.delegate = self
        view.addSubview(searchBar)
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocation", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = dataList[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.block != nil {
            stopAnimate()
            self.block!(dataList[indexPath.row])
        }
    }
}


extension WESearchLocationView: UISearchBarDelegate,BMKPoiSearchDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sendPoiSearchRequest(searchBar: searchBar)
    }
    
    func sendPoiSearchRequest(searchBar: UISearchBar) {
        let citySearchOption = BMKCitySearchOption()
        citySearchOption.pageIndex = Int32(currPageIndex)
        citySearchOption.pageCapacity = 10
        citySearchOption.city = "厦门"
        citySearchOption.keyword = searchBar.text!
        if poiSearch.poiSearch(inCity: citySearchOption) {
            print("城市内检索发送成功！")
        }else {
            print("城市内检索发送失败！")
        }
    }
    
    // MARK: - BMKPoiSearchDelegate
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        print("onGetPoiResult code: \(errorCode)");
        
        if errorCode == BMK_SEARCH_NO_ERROR {
            starAnimate()
            for i in 0..<poiResult.poiInfoList.count {
                let poi = poiResult.poiInfoList[i] as! BMKPoiInfo
                let item = BMKPointAnnotation()
                item.coordinate = poi.pt
                item.title = poi.name
                dataList.append(item)
                print(item.title)
            }
            
        } else if errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD {
            print("检索词有歧义")
        }else if errorCode == BMK_SEARCH_RESULT_NOT_FOUND {
            print("没有找到位置")
        } else {
            // 各种情况的判断……
        }
        tableView?.reloadData()
    }
}

extension WESearchLocationView {
    func starAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.tableView?.frame = self.bounds
        }, completion: { (isCompletion) in
            
        })
    }
    func stopAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 40)
            self.tableView?.frame = self.bounds
        }, completion: { (isCompletion) in
            
        })
    }
}
