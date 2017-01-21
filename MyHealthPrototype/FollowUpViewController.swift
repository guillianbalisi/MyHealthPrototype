//
//  FollowUpViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2017-01-11.
//  Copyright © 2017 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class FollowUpViewController: UIViewController {
    
    var hasPresented = false
    
    override func viewDidLoad() {
        UIView.appearance().tintColor = UIColor.init(colorLiteralRed: 180.0/255, green: 0, blue: 0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if hasPresented == false {
            hasPresented = true
            
            let followUp1QuestionStepTitle = "Did you download the Smoke Free app?"
            let followUp1QuestionStep = ORKQuestionStep(identifier: "FollowUp1QuestionStep", title: followUp1QuestionStepTitle, answer: ORKBooleanAnswerFormat())
            followUp1QuestionStep.isOptional = false
            
            let followUp2QuestionStepTitle = "How many times per week did you use the app?"
            let followUp2Choices = [
                ORKTextChoice(text: "0", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "1-5", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "6-10", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "10-20", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "More than 20", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
                ]
            let followUp2AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: followUp2Choices)
            let followUp2QuestionStep = ORKQuestionStep(identifier: "FollowUp2QuestionStep", title: followUp2QuestionStepTitle, answer: followUp2AnswerFormat)
            followUp2QuestionStep.isOptional = false
            
            let smokeQuestionStepTitle = "Are you currently smoking cigarettes?"
            let smokeQuestionStep = ORKQuestionStep(identifier: "SmokeQuestionStep", title: smokeQuestionStepTitle, answer: ORKBooleanAnswerFormat())
            smokeQuestionStep.isOptional = false
            
            let quitSmokeQuestionStepTitle = "Did you smoke any cigarettes, even one puff, in the last 7 days?"
            let quitSmokeQuestionStep = ORKQuestionStep(identifier: "QuitSmokeQuestionStep", title: quitSmokeQuestionStepTitle, answer: ORKBooleanAnswerFormat())
            quitSmokeQuestionStep.isOptional = false
            
            let completionStep = ORKCompletionStep(identifier: "RCTCompletionStep")
            completionStep.title = "Thank you!"
            completionStep.text = "You have completed the Smoking Cessation App Study."
            completionStep.detailText = "You can continue to use MyHealth PHRI, and we may ask you to join further studies in the future."
            
            let orderedTask = ORKOrderedTask(identifier: "JoinRCT", steps: [followUp1QuestionStep, followUp2QuestionStep, smokeQuestionStep, quitSmokeQuestionStep,completionStep])
            let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
            taskViewController.delegate = self
            
            present(taskViewController, animated: true, completion: nil)
        }
    }
    
}

extension FollowUpViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            performSegue(withIdentifier: "unwindToStudy", sender: nil)
            
        case .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
        }
    }
    
}
