//
//  WithdrawViewController.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-13.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

class WithdrawViewController: ORKTaskViewController {
    // MARK: Initialization
    
    override func viewDidLoad() {
        UIView.appearance().tintColor = UIColor.init(colorLiteralRed: 180.0, green: 0, blue: 0, alpha: 1.0)
    }
    
    init() {
        let instructionStep = ORKInstructionStep(identifier: "WithdrawlInstruction")
        instructionStep.title = NSLocalizedString("Are you sure you want to withdraw?", comment: "")
        instructionStep.text = NSLocalizedString("Withdrawing from the study will reset the app to the state it was in prior to you originally joining the study.", comment: "")
        
        let completionStep = ORKCompletionStep(identifier: "Withdraw")
        completionStep.title = NSLocalizedString("We appreciate your time.", comment: "")
        completionStep.text = NSLocalizedString("Thank you for your contribution to this study. We are sorry that you could not continue.", comment: "")
        
        let withdrawTask = ORKOrderedTask(identifier: "Withdraw", steps: [instructionStep, completionStep])
        
        super.init(task: withdrawTask, taskRun: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
