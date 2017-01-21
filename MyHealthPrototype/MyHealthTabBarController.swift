//
//  MyHealthTabBarController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-22.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit

class MyHealthTabBarController: UITabBarController {
    var activityCounter = ActivityCounter()
    
    override func viewDidLoad() {
        self.tabBar.tintColor = UIColor.init(colorLiteralRed: 180.0/255, green: 0, blue: 0, alpha: 1.0)
    }
}
