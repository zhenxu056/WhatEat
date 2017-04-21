//
//  WETabBarViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WETabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }

}

extension WETabBarViewController {
    func initVC() {
        let firstVC = UIStoryboard(name: "FoodMenu", bundle: nil).instantiateInitialViewController()
        let secondVC = UIStoryboard(name: "FoodDraw", bundle: nil).instantiateInitialViewController()
        let otherVC = UIStoryboard(name: "Collection", bundle: nil).instantiateInitialViewController()
        
        let vcArray = [firstVC, secondVC, otherVC]
        var rootControlArray = [UIViewController]()
        for controller in vcArray {
            rootControlArray.append(controller!)
        }
        
        let item1 : UITabBarItem = UITabBarItem (title: "菜单", image: UIImage(named: "tabbar_home"), selectedImage: UIImage(named: "tabbar_home_selected"))
        rootControlArray[0].tabBarItem = item1
        
        let item2 : UITabBarItem = UITabBarItem (title: "抽", image: UIImage(named: "tabbar_sort"), selectedImage: UIImage(named: "tabbar_sort_selected"))
        rootControlArray[1].tabBarItem = item2
        
        let item3 : UITabBarItem = UITabBarItem (title: "收集", image: UIImage(named: "tabbar_other"), selectedImage: UIImage(named: "tabbar_other_selected"))
        rootControlArray[2].tabBarItem = item3
        
        self.viewControllers = rootControlArray 
        
        self.selectedIndex = 1
    }
}
