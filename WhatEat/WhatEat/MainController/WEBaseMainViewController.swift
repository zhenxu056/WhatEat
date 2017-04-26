//
//  WEBaseMainViewController.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/7.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

class WEBaseMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let colorArray = [UIColor.red, UIColor.orange, UIColor.gray, UIColor.blue, UIColor.init(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)]
//        let index:Int = Int(arc4random()%4)
        self.view.backgroundColor = colorArray[4]
        
    } 
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
