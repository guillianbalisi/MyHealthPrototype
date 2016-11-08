//
//  DashboardTableViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-14.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class DashboardTableViewController: UITableViewController, ORKPieChartViewDataSource {
    // MARK: Properties
    
    enum PieChartSegment: Int {
        case Completed, Remaining
    }
    
    var activityCounter = ActivityCounter()
    var activityCompletionPercentage: CGFloat {
        get {
            return min((CGFloat(activityCounter.counter)/3)*100,100)
        }
    }
    
    @IBOutlet var pieChart: ORKPieChartView!
    
    var allCharts: [UIView] {
        return [pieChart]
    }
        
    // MARK: UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        pieChart.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController as! MyHealthTabBarController
        activityCounter = tbvc.activityCounter
        
        pieChart.title = NSLocalizedString("Activity Completion", comment: "")
        pieChart.showsTitleAboveChart = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        pieChart.text  = dateFormatter.string(from: Date())
        
        // Set the data source for each graph
        pieChart.dataSource = self
        
        // Set the table view to automatically calculate the height of cells.
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animate any visible charts
        let visibleCells = tableView.visibleCells
        let visibleAnimatableCharts = visibleCells.flatMap { animatableChartInCell($0) }
        
        for chart in visibleAnimatableCharts {
            chart.animateWithDuration(0.5)
        }
        
    }
    
    // MARK: Pie chart data source
    
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
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Animate charts as they're scrolled into view.
        if let animatableChart = animatableChartInCell(cell) {
            animatableChart.animateWithDuration(0.5)
        }
    }
    
    // MARK: Convenience
    
    func animatableChartInCell(_ cell: UITableViewCell) -> AnimatableChart? {
        for chart in allCharts {
            guard let animatableChart = chart as? AnimatableChart , chart.isDescendant(of: cell) else { continue }
            return animatableChart
        }
        
        return nil
    }

}
