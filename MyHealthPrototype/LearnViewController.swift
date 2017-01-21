//
//  LearnViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-25.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class LearnViewController: UITableViewController {
    let titles = ["General information",
                  "Why is this research being done?",
                  "Participating in other studies",
                  "Risk to privacy",
                  "How many people will participate in this study?",
                  "Potential benefits to society",
                  "Will I be paid to participate in this study?",
                  "Will there be any costs?",
                  "What happens if I have a research-related injury?",
                  "If I have questions or problems, who can I contact?",
                  ]
    
    let information = [
        "The MyHealth PHRI study uses a smartphone application to help researchers learn more about the effectiveness of smartphone applications to reduce the risk of cardiovascular problems such as heart attacks and strokes. During the study, we will collect data from participants about their health using the smartphone application. The principal investigator is Itzhak Gabizon, and the study sponsor (the organization responsible for the study) is the Population Health Research Institute, Hamilton, ON, Canada.",
        "Many people use smartphone applications to help them improve and maintain their health. However, we have very little evidence about whether these applications really do improve health. MyHealth PHRI will help connect you to applications based on your current health, and will collect data to see wheteher these applications work. In this way, we hope to produce high quality evidence to determine which applications work best to improve health.",
        "Based on the information you provide, you may be asked to participate in studies comparing specific apps. For examplie, if you are a smoker, you may be asked to participate in a study comparing two smoking cessation applications. You will only be enrolled in other studies if you specifically consent to doing so in a separate consent process.",
        "For the purposes of ensuring the proper monitoring of the research study, it is possible that a member of the Hamilton Integrated Research Ethics Board and representatives of the Population Health Research Institute may consult your research data and medical records. However, no records which identify you by name or initials will be allowed to leave the secure databases. By giving consent, you authorize such access.",
        "The number of participants in this study will depend on how many people download and use the MyHealth PHRI app. We hope to enroll 5000 participants in the first two years.",
        "Your participation will help researchers understand which applications are effective at improving heart health. This will allow more people to use the best applications for health, and will allow software developers to make future apps more effective. We hope that data from this study will help improve heart health for everyone.",
        "You will not be paid to use MyHealth PHRI. However, if you are eligible for and choose to enrol in studies through MyHealth PHRI, you may receive reimbursement for your time and data usage.",
        "Participation in this study will involve data transmission using your smartphone. This may incur costs from your cellular service provider.",
        "If you are injured as a direct result of taking part in this study, all necessary medical treatment will be made available to you at no cost.  Financial compensation for such things as lost wages, disability or discomfort due to this type of injury is not routinely available.   However, if you consent to participation in this study it does not mean that you waive any legal rights you may have under the law, nor does it mean that you are releasing the investigator(s), institution(s) and/or sponsor from their legal and professional responsibilities.",
        "If you have any questions about the research now or later, or if you think you have a research-related injury, please contact Itzhak Gabizon at itzhak.gabizon@phri.ca. If you have any questions about your rights as a research participant, please call the Office of the Chair, Hamilton Integrated Research Ethics Board at 905-521-2100 x 42013."
        ]
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        UIView.appearance().tintColor = UIColor.init(colorLiteralRed: 180.0/255, green: 0, blue: 0, alpha: 1.0)
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "learnCell", for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myStep = ORKInstructionStep(identifier: "intro")
        myStep.title = titles[indexPath.row]
        myStep.detailText = information[indexPath.row]
        let task = ORKOrderedTask(identifier: "task", steps: [myStep])
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
}

extension LearnViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Handle results using taskViewController.result
        if(reason != ORKTaskViewControllerFinishReason.failed){
            taskViewController.delegate = self
            taskViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
