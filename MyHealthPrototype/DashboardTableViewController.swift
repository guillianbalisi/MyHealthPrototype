//
//  DashboardTableViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-14.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class DashboardTableViewController: UITableViewController {
    // MARK: Properties
    
    @IBOutlet var pieChart: ORKPieChartView!
    
    var allCharts: [UIView] {
        return [pieChart]
    }
    
    let pieChartDataSource = PieChartDataSource()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.title = NSLocalizedString("Activity Completion", comment: "")
        pieChart.showsTitleAboveChart = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        pieChart.text  = dateFormatter.string(from: Date())
        
        // Set the data source for each graph
        pieChart.dataSource = pieChartDataSource
        
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
