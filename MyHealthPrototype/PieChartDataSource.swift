//
//  PieChartDataSource.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-14.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import ResearchKit

class PieChartDataSource: NSObject, ORKPieChartViewDataSource {
    // MARK: Types
    
    enum PieChartSegment: Int {
        case Completed, Remaining
    }
    
    var activityCompletionPercentage: CGFloat = 67
    
    // MARK: ORKPieChartViewDataSource
    
    func numberOfSegments(in pieChartView: ORKPieChartView ) -> Int {
        return 2
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
        switch PieChartSegment(rawValue: index)! {
        case .Completed:
            return activityCompletionPercentage
        case .Remaining:
            return 100 - activityCompletionPercentage
        }
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, colorForSegmentAt index: Int) -> UIColor {
        switch PieChartSegment(rawValue: index)! {
        case .Completed:
            return UIColor.init(colorLiteralRed: 180.0, green: 0, blue: 0, alpha: 1.0)
        case .Remaining:
            return UIColor.lightGray
        }
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, titleForSegmentAt index: Int) -> String {
        switch PieChartSegment(rawValue: index)! {
        case .Completed:
            return NSLocalizedString("Completed", comment: "")
        case .Remaining:
            return NSLocalizedString("Remaining", comment: "")
        }
    }
}
