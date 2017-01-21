//
//  ResearchContainerViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class ResearchContainerViewController: UIViewController {
    
    // MARK: Propertues
    
    var hasPresentedRCT = false
    var hasPresentedFollowUp = false
    
    var contentHidden = false {
        didSet {
            guard contentHidden != oldValue && isViewLoaded else { return }
            childViewControllers.first?.view.isHidden = contentHidden
        }
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            toStudy()
        }
        else {
            toOnboarding()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if hasPresented == false {
//            let delegate = UIApplication.shared.delegate as! AppDelegate
//            var presentFromNotification = delegate.presentFromNotification
//            print("In VC: \(presentFromNotification)")
//            if presentFromNotification == true {
//                if hasCompletedRCT == false {
//                    toRCT()
//                    hasPresented = true
//                }
//            }
//        }
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let presentFrom = delegate.presentFrom
        
        if hasPresentedRCT == false && hasPresentedFollowUp == false {
            if presentFrom == "RCT" {
                hasPresentedRCT = true
                toRCT()
            }
        }
        
        if hasPresentedRCT == true && hasPresentedFollowUp == false {
            if presentFrom == "FollowUp" {
                hasPresentedFollowUp = true
                toFollowUp()
            }
        }
    }
    
    // MARK: Unwind segues
    
    @IBAction func unwindToStudy(_ segue: UIStoryboardSegue) {
        toStudy()
    }
    
        @IBAction func unwindToWithdrawl(_ segue: UIStoryboardSegue) {
            toWithdrawl()
        }
    
    // MARK: Transitions

    func toRCT() {
        performSegue(withIdentifier: "toRCT", sender: self)
    }
    
    func toOnboarding() {
        performSegue(withIdentifier: "toOnboarding", sender: self)
    }
    
    func toStudy() {
        performSegue(withIdentifier: "toStudy", sender: self)
    }
    
    func toWithdrawl() {
        let viewController = WithdrawViewController()
        viewController.delegate = self

        present(viewController, animated: true, completion: nil)
    }
    
    func toFollowUp() {
        performSegue(withIdentifier: "toFollowUp", sender: self)
    }

}

extension ResearchContainerViewController: ORKTaskViewControllerDelegate {

    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check if the user has finished the `WithdrawViewController`.
        if taskViewController is WithdrawViewController {
            /*
             If the user has completed the withdrawl steps, remove them from
             the study and transition to the onboarding view.
             */
            if reason == .completed {
                ORKPasscodeViewController.removePasscodeFromKeychain()
                toOnboarding()
            }

            // Dismiss the `WithdrawViewController`.
            dismiss(animated: true, completion: nil)
        }
    }
}
