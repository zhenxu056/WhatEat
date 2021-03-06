//
//  AppDelegate.swift
//  WhatEat
//
//  Created by RuiTong_MAC on 2017/4/24.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //百度API秘钥Key
    fileprivate let BMAPIKEY = "82wA5GkIIB65u3jywEa1XRbGiA39Zock"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initRootViewController()
        initBaiDuMapCof()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

extension AppDelegate: BMKGeneralDelegate {
    //初始化登录
    func initRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let rootVC = WETabBarViewController()
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
    //配置百度信息
    func initBaiDuMapCof() {
        let mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = mapManager.start(BMAPIKEY, generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        } else {
            print("manager start")
        }
    }
}

