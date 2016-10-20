//
//  HealthClientType.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import HealthKit

protocol HealthClientType {
    var healthStore: HKHealthStore? { get set }
}

extension UIViewController {
    
    func injectHealthStore(_ healthStore: HKHealthStore) {
        if var client = self as? HealthClientType {
            client.healthStore = healthStore
        }
        
        for childViewController in childViewControllers {
            childViewController.injectHealthStore(healthStore)
        }
    }
}
