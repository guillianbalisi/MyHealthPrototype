//
//  OnboardingViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController {
    //MARK: Initialization
    
    @IBOutlet weak var joinStudyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinStudyButton.tintColor = UIColor.init(colorLiteralRed: 190.0, green: 0, blue: 0, alpha: 1.0)
        joinStudyButton.backgroundColor = UIColor.clear
        joinStudyButton.layer.cornerRadius = 5
        joinStudyButton.layer.borderWidth = 0.9
        joinStudyButton.layer.borderColor = UIColor.init(colorLiteralRed: 180.0, green: 0, blue: 0, alpha: 1.0).cgColor
        
        UIView.appearance().tintColor = UIColor.init(colorLiteralRed: 180.0, green: 0, blue: 0, alpha: 1.0)
    }
    
    // MARK: IB actions    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let consentDocument = ConsentDocument()
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        
        let investigatorShortDescription = "PHRI"
        let investigatorLongDescription = "PHRI"
        let localizedLearnMoreHTMLContent = "Choose to share with PHRI only or with PHRI and other institutions such as McMaster University."
        let sharingConsentStep = ORKConsentSharingStep(identifier: "SharingConsentStep", investigatorShortDescription: investigatorShortDescription, investigatorLongDescription: investigatorLongDescription, localizedLearnMoreHTMLContent: localizedLearnMoreHTMLContent)
        
        let healthDataStep = HealthDataStep(identifier: "Health")
        
        let signature = consentDocument.signatures!.first!
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        
        reviewConsentStep.text = "Review the consent form."
        reviewConsentStep.reasonForConsent = "Consent to join the Developer Health Research Study."
        
        let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
        passcodeStep.text = "Now you will create a passcode to identify yourself to the app and protect access to information you've entered."
        
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Welcome aboard."
        completionStep.text = "Thank you for joining this study."
        
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, sharingConsentStep, reviewConsentStep, healthDataStep, passcodeStep, completionStep])
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = self
        
        present(taskViewController, animated: true, completion: nil)
    }
}

extension OnboardingViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            performSegue(withIdentifier: "unwindToStudy", sender: nil)
            
        case .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
        }
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
        if step is HealthDataStep {
            let healthStepViewController = HealthDataStepViewController(step: step)
            return healthStepViewController
        }
        
        return nil
    }
}
