//
//  EligibilityTask.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-18.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import ResearchKit

public var EligibilityTask: ORKTask {
    // Intro step
    let introStep = ORKInstructionStep(identifier: "EligibilityTask")
    introStep.title = NSLocalizedString("Eligibility Task Example", comment: "")
    
    // Form step
    let formStep = ORKFormStep(identifier: "EligibilityForm")
    formStep.title = NSLocalizedString("Eligibility", comment: "")
    formStep.isOptional = false
    
    // Form items
    let answerFormat = ORKBooleanAnswerFormat()
    
    let formItem01 = ORKFormItem(identifier: "AgeEligibleStep", text: "Are you over 18 years of age?", answerFormat: answerFormat)
    formItem01.isOptional = false
    let formItem02 = ORKFormItem(identifier: "EnglishEligibleStep", text: "Can you read and understand English?", answerFormat: answerFormat)
    formItem02.isOptional = false
    
    formStep.formItems = [
        formItem01,
        formItem02,
    ]
    
    // Ineligible step
    let ineligibleStep = ORKInstructionStep(identifier: "IneligibleStep")
    ineligibleStep.title = "You are ineligible to join the study"
    
    // Eligible step
    let eligibleStep = ORKCompletionStep(identifier: "EligibleStep")
    eligibleStep.title = "You are eligible to join the study"
    
    // Create the task
    let eligibilityTask = ORKNavigableOrderedTask(identifier: "EligibilityTask", steps: [
        introStep,
        formStep,
        ineligibleStep,
        eligibleStep
        ])
    
    // Build navigation rules.
    var resultSelector = ORKResultSelector(stepIdentifier: "EligibilityForm", resultIdentifier: "AgeEligibleStep")
    let predicateFormItem01 = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
    
    resultSelector = ORKResultSelector(stepIdentifier: "EligibilityForm", resultIdentifier: "EnglishEligibleStep")
    let predicateFormItem02 = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
    
    let predicateEligible = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateFormItem01, predicateFormItem02])
    let predicateRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [ (predicateEligible, "EligibleStep") ])
    
    eligibilityTask.setNavigationRule(predicateRule, forTriggerStepIdentifier: "EligiblityForm")
    
    // Add end direct rules to skip unneeded steps
    let directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
    eligibilityTask.setNavigationRule(directRule, forTriggerStepIdentifier: "IneligibleStep")
    
    return eligibilityTask
}
