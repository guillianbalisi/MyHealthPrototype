//
//  ActivityViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

enum Activity: Int {
    case survey, walking, questionnaire
    
    static var allValues: [Activity] {
        var index = 0
        return Array (
            AnyIterator {
                let returnedElement = self.init(rawValue: index)
                index = index + 1
                return returnedElement
            }
        )
    }
    
    var title: String {
        switch self {
        case .survey:
            return "Survey"
        case .walking:
            return "Fitness Test"
        case .questionnaire:
            return "IPAQ"
        }
    }
    
    var subtitle: String {
        switch self {
        case .survey:
            return "Demographic Data and Risk Factor Survey"
        case .walking:
            return "6 Minute Walk Test"
        case .questionnaire:
            return "International Physical Activity Questionnaire"
        }
    }
}

class ActivityViewController: UITableViewController {
    
    // MARK: Initialization
    
    var activityCounter = ActivityCounter()
    
    override func viewDidLoad() {
        UIView.appearance().tintColor = UIColor.init(colorLiteralRed: 180.0/255, green: 0, blue: 0, alpha: 1.0)
        
    let tbvc = self.tabBarController as! MyHealthTabBarController
    activityCounter = tbvc.activityCounter
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        
        return Activity.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        
        if let activity = Activity(rawValue: (indexPath as NSIndexPath).row) {
            cell.textLabel?.text = activity.title
            cell.detailTextLabel?.text = activity.subtitle
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityCounter.counter += 1
        
        guard let activity = Activity(rawValue: (indexPath as NSIndexPath).row) else { return }
        
        let taskViewController: ORKTaskViewController
        switch activity {
        case .survey:
            taskViewController = ORKTaskViewController(task: StudyTasks.surveyTask, taskRun: NSUUID() as UUID)
            
        case .walking:
            taskViewController = ORKTaskViewController(task: StudyTasks.walkingTask, taskRun: NSUUID() as UUID)
            
        case .questionnaire:
            taskViewController = ORKTaskViewController(task: StudyTasks.questionnaireTask, taskRun: NSUUID() as UUID)
    
        }
        
        taskViewController.delegate = self
        navigationController?.present(taskViewController, animated: true, completion: nil)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
}

extension ActivityViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Handle results using taskViewController.result
        if(reason != ORKTaskViewControllerFinishReason.failed){
            taskViewController.delegate = self
            taskViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
