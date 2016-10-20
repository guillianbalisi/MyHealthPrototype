//
//  AnimatableChart.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-13.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import ResearchKit

protocol AnimatableChart {
    func animateWithDuration(_ animationDuration: TimeInterval)
}

extension ORKPieChartView: AnimatableChart {}

