//
//  WESearchLocationView.swift
//  WhatEat
//
//  Created by RuiTong_MAC on 2017/4/26.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WESearchLocationView: UIView {

    var tableView: UITableView?
    var geocodeSearch: BMKGeoCodeSearch!
    var mapView: BMKMapView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            self.backgroundColor = UIColor.init(red: 144/255.0, green: 144/255.0, blue: 144/255.0, alpha: 0.7)
            tableView = UITableView(frame: self.bounds, style: .plain)
            tableView?.backgroundColor = UIColor.clear
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "SearchLocation")
            self.addSubview(tableView!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        tableView?.reloadData()
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocation", for: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

 

extension WESearchLocationView: UISearchBarDelegate { 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text!)
    }
}
