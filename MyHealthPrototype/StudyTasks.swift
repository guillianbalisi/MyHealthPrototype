//
//  StudyTasks.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import ResearchKit

struct StudyTasks {
    
    static let walkingTask: ORKOrderedTask = {
        return ORKOrderedTask.fitnessCheck(withIdentifier: "WalkingTask",
                                                             intendedUseDescription: "Test your fitness level",
                                                             walkDuration: 360 as TimeInterval,
                                                             restDuration: 30 as TimeInterval,
                                                             options: ORKPredefinedTaskOption())
    }()
    
    static let surveyTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        // Instruction Step
        
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Demographic Data and Risk Factor Survey"
        instructionStep.text = "Please answer the following questions to the best of your ability. It's okay to skip a question if you don't know the answer."
        
        steps += [instructionStep]
        
        // Demographic Data
        
        let ageQuestionStepTitle = "How old are you?"
        let ageAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "years")
        let ageQuestionStep = ORKQuestionStep(identifier: "AgeQuestionStep", title: ageQuestionStepTitle, answer: ageAnswerFormat)
        
        steps += [ageQuestionStep]
        
        let sexQuestionStepTitle = "What is your gender?"
        let sexTextChoices = [
            ORKTextChoice(text: "Male", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Female", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let sexAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: sexTextChoices)
        let sexQuestionStep = ORKQuestionStep(identifier: "SexQuestionStep", title: sexQuestionStepTitle, answer: sexAnswerFormat)
        
        steps += [sexQuestionStep]
        
        let raceQuestionStepTitle = "What is your race?"
        let raceTextChoices = [
            ORKTextChoice(text: "Caucasian", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "African Descent", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Asian", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let raceAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: raceTextChoices)
        let raceQuestionStep = ORKQuestionStep(identifier: "RaceQuestionStep", title: raceQuestionStepTitle, answer: raceAnswerFormat)

        steps += [raceQuestionStep]
        
        let heightQuestionStepTitle = "What is your height in centimetres?"
        let heightAnswerFormat = ORKNumericAnswerFormat(style: .decimal, unit: "cm")
        let heightQuestionStep = ORKQuestionStep(identifier: "HeightQuestionStep", title: heightQuestionStepTitle, answer: heightAnswerFormat)
        
        steps += [heightQuestionStep]
        
        let weightQuestionStepTitle = "What is your weight in kilograms?"
        let weightAnswerFormat = ORKNumericAnswerFormat(style: .decimal, unit: "kg")
        let weightQuestionStep = ORKQuestionStep(identifier: "WeightQuestionStep", title: weightQuestionStepTitle, answer: weightAnswerFormat)
        
        steps += [weightQuestionStep]
        
        let wakeQuestionStepTitle = "What time do you usually wake up?"
        let wakeAnswerFormat = ORKTimeOfDayAnswerFormat()
        let wakeQuestionStep = ORKQuestionStep(identifier: "WakeQuestionStep", title: wakeQuestionStepTitle, answer: wakeAnswerFormat)
        
        steps += [wakeQuestionStep]
        
        let sleepQuestionStepTitle = "What time do you usually go to sleep?"
        let sleepAnswerFormat = ORKTimeOfDayAnswerFormat()
        let sleepQuestionStep = ORKQuestionStep(identifier: "SleepQuestionStep", title: sleepQuestionStepTitle, answer: sleepAnswerFormat)
        
        steps += [sleepQuestionStep]
        
        // Risk Factor Survey
        
        let diabetesQuestionStepTitle = "Do you have diabetes?"
        let diabetesAnswerFormat = ORKBooleanAnswerFormat()
        let diabetesQuestionStep = ORKQuestionStep(identifier: "DiabetesQuestionStep", title: diabetesQuestionStepTitle, answer: diabetesAnswerFormat)
        
            let diaMedQuestionStepTitle = "Do you take medications for your diabetes?"
            let diaMedAnswerFormat = ORKBooleanAnswerFormat()
            let diaMedQuestionStep = ORKQuestionStep(identifier: "DiaMedQuestionStep", title: diaMedQuestionStepTitle, answer: diaMedAnswerFormat)
        
                let diaYesQuestionStepTitle = "Please choose all medication that apply:"
                let diaMedTextChoices = [
                    ORKTextChoice(text: "Insulin", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "Oral hypoglycemic agents", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                    ORKTextChoice(text: "Diabetes pills", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
                ]
                let diaYesAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: diaMedTextChoices)
                let diaYesQuestionStep = ORKQuestionStep(identifier: "DiaYesQuestionStep", title: diaYesQuestionStepTitle, answer: diaYesAnswerFormat)
        
        let highBloodQuestionStepTitle = "Do you have high blood pressure?"
        let highBloodAnswerFormat = ORKBooleanAnswerFormat()
        let highBloodQuestionStep = ORKQuestionStep(identifier: "HighBloodQuestionStep", title: highBloodQuestionStepTitle, answer: highBloodAnswerFormat)
        
            let highBloodMedQuestionStepTitle = "Do you take medications for your blood pressure?"
            let highBloodMedAnswerFormat = ORKBooleanAnswerFormat()
            let highBloodMedQuestionStep = ORKQuestionStep(identifier: "HighBloodMedQuestionStep", title: highBloodMedQuestionStepTitle, answer: highBloodMedAnswerFormat)
        
        let sysQuestionStepTitle = "What is your most recent systolic blood pressure (top number)?"
        let sysAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "mm Hg")
        let sysQuestionStep = ORKQuestionStep(identifier: "SysQuestionStep", title: sysQuestionStepTitle, answer: sysAnswerFormat)
        
        let diasQuestionStepTitle = "What is your most recent diastolic blood pressure (bottom number)?"
        let diasAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "mm Hg")
        let diasQuestionStep = ORKQuestionStep(identifier: "DiasQuestionStep", title: diasQuestionStepTitle, answer: diasAnswerFormat)
        
        let smokeQuestionStepTitle = "Do you currently smoke?"
        let smokeAnswerFormat = ORKBooleanAnswerFormat()
        let smokeQuestionStep = ORKQuestionStep(identifier: "SmokeQuestionStep", title: smokeQuestionStepTitle, answer: smokeAnswerFormat)
        
            let smokeYes1QuestionStepTitle = "How many cigarettes do you smoke in a day?"
            let smokeYes1AnswerFormat = ORKNumericAnswerFormat(style: .integer)
            let smokeYes1QuestionStep = ORKQuestionStep(identifier: "SmokeYes1QuestionStep", title: smokeYes1QuestionStepTitle, answer: smokeYes1AnswerFormat)
            
                let smokeYes2QuestionStepTitle = "Have you tried quitting in the past?"
                let smokeYes2AnswerFormat = ORKBooleanAnswerFormat()
                let smokeYes2QuestionStep = ORKQuestionStep(identifier: "SmokeYes2QuestionStep", title: smokeYes2QuestionStepTitle, answer: smokeYes2AnswerFormat)
            
                    let smokeYes3QuestionStepTitle = "Are you currently interested or attempting to quit smoking?"
                    let smokeYes3AnswerFormat = ORKBooleanAnswerFormat()
                    let smokeYes3QuestionStep = ORKQuestionStep(identifier: "SmokeYes3QuestionStep", title: smokeYes3QuestionStepTitle, answer: smokeYes3AnswerFormat)
        
            let smokeNo1QuestionStepTitle = "Have you smoked in the past?"
            let smokeNo1AnswerFormat = ORKBooleanAnswerFormat()
            let smokeNo1QuestionStep = ORKQuestionStep(identifier: "SmokeNo1QuestionStep", title: smokeNo1QuestionStepTitle, answer: smokeNo1AnswerFormat)
        
                let smokeNo2QuestionStepTitle = "How long ago did you quit smoking?"
                let smokeNo2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "months")
                let smokeNo2QuestionStep = ORKQuestionStep(identifier: "SmokeNo2QuestionStep", title: smokeNo2QuestionStepTitle, answer: smokeNo2AnswerFormat)
        
        let alcoholQuestionStepTitle = "Do you consume alcohol?"
        let alcoholAnswerFormat = ORKBooleanAnswerFormat()
        let alcoholQuestionStep = ORKQuestionStep(identifier: "AlcoholQuestionStep", title: alcoholQuestionStepTitle, answer: alcoholAnswerFormat)
        
            let alcoholYesQuestionStepTitle = "On average, how many beverages containing alcohol do you consume in a day?"
            let alcoholYesAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "beverages")
            let alcoholYesQuestionStep = ORKQuestionStep(identifier: "AlcoholYesQuestionStep", title: alcoholYesQuestionStepTitle, answer: alcoholYesAnswerFormat)
        
        let cholQuestionTitle = "What is your most recent HDL cholesterol level?"
        let cholAnswerFormat = ORKNumericAnswerFormat(style: .decimal, unit: "mmol/L")
        let cholQuestionStep = ORKQuestionStep(identifier: "CholQuestionStep", title: cholQuestionTitle, answer: cholAnswerFormat)
        
        steps += [diabetesQuestionStep,
                  diaMedQuestionStep,
                  diaYesQuestionStep,
                  highBloodQuestionStep,
                  highBloodMedQuestionStep,
                  sysQuestionStep,
                  diasQuestionStep,
                  smokeQuestionStep,
                  smokeYes1QuestionStep,
                  smokeYes2QuestionStep,
                  smokeYes3QuestionStep,
                  smokeNo1QuestionStep,
                  smokeNo2QuestionStep,
                  alcoholQuestionStep,
                  alcoholYesQuestionStep,
                  cholQuestionStep]
        
        // RULES
        
        let task = ORKNavigableOrderedTask(identifier: "Task", steps: steps)
        
        let diabetesPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "DiabetesQuestionStep"), expectedAnswer: false)
        let diabetesRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(diabetesPredicate, "HighBloodQuestionStep")])
        
        task.setNavigationRule(diabetesRule, forTriggerStepIdentifier: "DiabetesQuestionStep")
        
        let diaMedPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "DiaMedQuestionStep"), expectedAnswer: false)
        let diaMedRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(diaMedPredicate, "HighBloodQuestionStep")])
        
        task.setNavigationRule(diaMedRule, forTriggerStepIdentifier: "DiaMedQuestionStep")
        
        let highBloodPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "HighBloodQuestionStep"), expectedAnswer: false)
        let highBloodRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(resultPredicate: highBloodPredicate, destinationStepIdentifier: "SysQuestionStep")])
        
        task.setNavigationRule(highBloodRule, forTriggerStepIdentifier: "HighBloodQuestionStep")
        
        let smoke1Predicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "SmokeQuestionStep"), expectedAnswer: false)
        let smoke1Rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(resultPredicate: smoke1Predicate, destinationStepIdentifier: "SmokeNo1QuestionStep")])
        
        task.setNavigationRule(smoke1Rule, forTriggerStepIdentifier: "SmokeQuestionStep")
        
        let smoke2Predicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "SmokeNo1QuestionStep"), expectedAnswer: false)
        let smoke2Rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(resultPredicate: smoke2Predicate, destinationStepIdentifier: "AlcoholQuestionStep")])
        
        task.setNavigationRule(smoke2Rule, forTriggerStepIdentifier: "SmokeNo1QuestionStep")
        
        let alcoholPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "AlcoholQuestionStep"), expectedAnswer: false)
        let alcoholRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(resultPredicate: alcoholPredicate, destinationStepIdentifier: "CholQuestionStep")])
        
        task.setNavigationRule(alcoholRule, forTriggerStepIdentifier: "AlcoholQuestionStep")
        
        // Summary step
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Thank you."
        summaryStep.text = "We appreciate your time."
        
        steps += [summaryStep]
        
        return task
    }()
    
    static let questionnaireTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        // Instruction Step
        
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Short IPAQ"
        instructionStep.text = "Physical activity over the last 7 days."
        
        steps += [instructionStep]
        
        let vigorous1QuestionStepTitle = "During the last 7 days, on how many days did you do vigorous physical activities?"
        let vigorous1AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "day(s)")
        let vigorous1QuestionStep = ORKQuestionStep(identifier: "Vigorous1QuestionStep", title: vigorous1QuestionStepTitle, answer: vigorous1AnswerFormat)
        
        steps += [vigorous1QuestionStep]
        
        let vigorous2QuestionStepTitle = "How much time did you usually spend doing vigorous physical activities on one of those days?"
        let vigorous2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes")
        let vigorous2QuestionStep = ORKQuestionStep(identifier: "Vigorous2QuestionStep", title: vigorous2QuestionStepTitle, answer: vigorous2AnswerFormat)
        
        steps += [vigorous2QuestionStep]

        let moderate1QuestionStepTitle = "During the last 7 days, on how many days did you do moderate physical activities?"
        let moderate1AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "day(s)")
        let moderate1QuestionStep = ORKQuestionStep(identifier: "Moderate1QuestionStep", title: moderate1QuestionStepTitle, answer: moderate1AnswerFormat)
        
        steps += [moderate1QuestionStep]
        
        let moderate2QuestionStepTitle = "How much time did you usually spend doing moderate physical activities on one of those days?"
        let moderate2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes")
        let moderate2QuestionStep = ORKQuestionStep(identifier: "Moderate2QuestionStep", title: moderate2QuestionStepTitle, answer: moderate2AnswerFormat)
        
        steps += [moderate2QuestionStep]
        
        let walking1QuestionStepTitle = "During the last 7 days, on how many days did you do walk for at least 10 minutes at a time?"
        let walking1AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "day(s)")
        let walking1QuestionStep = ORKQuestionStep(identifier: "Walking1QuestionStep", title: walking1QuestionStepTitle, answer: walking1AnswerFormat)
        
        steps += [walking1QuestionStep]
        
        let walking2QuestionStepTitle = "How much time did you usually spend walking on one of those days?"
        let walking2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes")
        let walking2QuestionStep = ORKQuestionStep(identifier: "Walking2QuestionStep", title: walking2QuestionStepTitle, answer: walking2AnswerFormat)
        
        steps += [walking2QuestionStep]
        
        let sittingQuestionStepTitle = "During the last 7 days, how much time did you usually spend sitting or laying down on a week day?"
        let sittingAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "hours")
        let sittingQuestionStep = ORKQuestionStep(identifier: "SittingQuestionStep", title: sittingQuestionStepTitle, answer: sittingAnswerFormat)
        
        steps += [sittingQuestionStep]
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Thank you."
        summaryStep.text = "We appreciate your time."
        
        steps += [summaryStep]
        
        let task = ORKOrderedTask(identifier: "QuestionnaireTask", steps: steps)
        
        return task
        
    }()
        
        /***
        var form = ORKFormStep(identifier: "Form", title: "Short IPAQ", text: "Physical activity over the last 7 days")
        var items = [ORKFormItem]()
        
        let vigorousSection = ORKFormItem(sectionTitle: "Vigorous Activities")
        
        items += [vigorousSection]
        
        let vigorous1FormTitle = "During the last 7 days, on how many days did you do vigorous physical activities?"
        let vigorous1AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "day(s)")
        let vigorous1FormStep = ORKFormItem(identifier: "Vigorous1FormStep", text: vigorous1FormTitle, answerFormat: vigorous1AnswerFormat)
        
        items += [vigorous1FormStep]
        
        let vigorous2FormTitle = "How much time did you usually spend doing vigorous physical activities on one of those days?"
        let vigorous2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes")
        let vigorous2FormStep = ORKFormItem(identifier: "Vigorous2FormStep", text: vigorous2FormTitle, answerFormat: vigorous2AnswerFormat)
        
        items += [vigorous2FormStep]
        
        let moderateSection = ORKFormItem(sectionTitle: "Moderate Activities")
        
        items += [moderateSection]
        
        let moderate1FormTitle = "During the last 7 days, on how many days did you do moderate physical activities?"
        let moderate1AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "day(s)")
        let moderate1FormStep = ORKFormItem(identifier: "Moderate1FormStep", text: moderate1FormTitle, answerFormat: moderate1AnswerFormat)
        
        items += [moderate1FormStep]
        
        let moderate2FormTitle = "How much time did you usually spend doing moderate physical activities on one of those days?"
        let moderate2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes")
        let moderate2FormStep = ORKFormItem(identifier: "Moderate2FormStep", text: moderate2FormTitle, answerFormat: moderate2AnswerFormat)
        
        items += [moderate2FormStep]
        
        let walkingSection = ORKFormItem(sectionTitle: "Walking")
        
        items += [walkingSection]
        
        let walking1FormTitle = "During the last 7 days, on how many days did you do walk for at least 10 minutes at a time?"
        let walking1AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "day(s)")
        let walking1FormStep = ORKFormItem(identifier: "Walking1FormStep", text: walking1FormTitle, answerFormat: walking1AnswerFormat)
        
        items += [walking1FormStep]
        
        let walking2FormTitle = "How much time did you usually spend walking on one of those days?"
        let walking2AnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes")
        let walking2FormStep = ORKFormItem(identifier: "Walking2FormStep", text: walking2FormTitle, answerFormat: walking2AnswerFormat)
        
        items += [walking2FormStep]
        
        let sittingSection = ORKFormItem(sectionTitle: "Sitting")
        
        items += [sittingSection]
        
        let sittingFormTitle = "During the last 7 days, how much time did you usually spend sitting or laying down on a week day?"
        let sittingAnswerFormat = ORKNumericAnswerFormat(style: .integer, unit: "hours")
        let sittingFormStep = ORKFormItem(identifier: "SittingFormStep", text: sittingFormTitle, answerFormat: sittingAnswerFormat)
        
        items += [sittingFormStep]
        
        form.formItems = items
        form.isOptional = false
        
        let task = ORKNavigableOrderedTask(identifier: "FormTask", steps: [form])
        
        return task
        ***/
}
