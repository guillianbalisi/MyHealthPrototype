//
//  RCTViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2017-01-10.
//  Copyright © 2017 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class RCTViewController: UIViewController {
    
    var hasPresented = false
        
    override func viewDidLoad() {
        UIView.appearance().tintColor = UIColor.init(colorLiteralRed: 180.0/255, green: 0, blue: 0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if hasPresented == false {
            hasPresented = true
            
            let smokeQuestionStepTitle = "Do you currently smoke?"
            let smokeQuestionStep = ORKQuestionStep(identifier: "SmokeQuestionStep", title: smokeQuestionStepTitle, answer: ORKBooleanAnswerFormat())
            smokeQuestionStep.isOptional = false
            
            let quitSmokeQuestionStepTitle = "Are you interested in participating in a study for people who are trying to quit smoking?"
            let quitSmokeQuestionStep = ORKQuestionStep(identifier: "QuitSmokeQuestionStep", title: quitSmokeQuestionStepTitle, answer: ORKBooleanAnswerFormat())
            quitSmokeQuestionStep.isOptional = false
            
            let instructionStep = ORKInstructionStep(identifier: "InstructionStep")
            instructionStep.title = "Invitation to Participate in a Research Study"
            instructionStep.text = "You are eligible for a study on quitting smoking. The next screens will explain what is involved with this study, so you can decide whether it is right for you."
            
            let consentDocument = RCTConsent()
            let consentStep = ORKVisualConsentStep(identifier: "RCTConsentStep", document: consentDocument)
            
            let signature = consentDocument.signatures!.first!
            
            let reviewConsentStep = ORKConsentReviewStep(identifier: "RCTConsentReviewStep", signature: signature, in: consentDocument)
            
            reviewConsentStep.text = "Review the consent form."
            reviewConsentStep.reasonForConsent = "Consent to join the Randomized Control Trial."
            
            let countdownStep = ORKCountdownStep(identifier: "CountdownStep")
            countdownStep.stepDuration = 5
            countdownStep.shouldUseNextAsSkipButton = false
            countdownStep.text = "Randomization procedure now in progress. Please wait."
            
            let randomStep = ORKInstructionStep(identifier: "RandomStep")
            randomStep.title = "You were randomized to use the Smoke Free app."
            randomStep.text = "Please download the app, install it on your phone, and use the app for the next 6 months. We will ask you about smoking in 1 month and 6 months from now."
            randomStep.image = #imageLiteral(resourceName: "SmokeFreeIcon.png")
            
            let completionStep = ORKCompletionStep(identifier: "RCTCompletionStep")
            completionStep.title = "Welcome aboard."
            completionStep.text = "Thank you for participating in this study."
            
            let orderedTask = ORKOrderedTask(identifier: "JoinRCT", steps: [smokeQuestionStep, quitSmokeQuestionStep, instructionStep, consentStep, reviewConsentStep, countdownStep, randomStep, completionStep])
            let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
            taskViewController.delegate = self
            
            present(taskViewController, animated: true, completion: nil)
        }
    }
    
}

extension RCTViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            performSegue(withIdentifier: "unwindToStudy", sender: nil)
            
        case .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
        }
    }

}
