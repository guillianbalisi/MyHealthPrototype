//
//  HKHealthStore+Queries.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import HealthKit

extension HKHealthStore {
    /// Asynchronously fetches the most recent quantity sample of a specified type.
    func mostRecentQauntitySampleOfType(_ quantityType: HKQuantityType, predicate: NSPredicate? = nil, completion: @escaping (HKQuantity?, NSError?) -> Void) {
        let timeSortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: quantityType, predicate: predicate, limit: 1, sortDescriptors: [timeSortDescriptor]) { _, samples, error in
            if let firstSample = samples?.first as? HKQuantitySample {
                completion(firstSample.quantity, nil)
            }
            else {
                completion(nil, error as NSError?)
            }
        }
        
        execute(query)
    }
}
