//
//  ConsentDocument.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import ResearchKit

class ConsentDocument : ORKConsentDocument {
    //MARK: Properties
    
    let information = [
        "This simple walkthrough will explain the research study, the impact it may have on your life and will allow you to provide your consent to participate.",
        "Collected data may allow researchers, as well as you, to understand patterns and details about health.",
        "Your data will be encrypted and sent to a secure database, with your name replaced by a random code.",
        "Your coded study data will be used for research by McMaster University and may be shared with other researchers approved by McMaster University.",
        "Your participation in this study will take 10-15 minutes every three months to answer questions related to your health You are welcome to explore and take advantage of other features of MyHealth PHRI as much or as little as you would like.",
        "You will be asked to answer survey questions about health and lifestyle factors.",
        "We will ask you to complete active tasks that may require physical activity. The MyHealth PHRI app will ask you to do 2 activities: answer surveys about your risk factors and blood tests to calculate your risk of having a heart attack, and if you are able, perform a 6-minute walk test.",
        "You may withdraw your consent and discontinue participation at any time. We will not collect or store any new data if you choose to withdraw. To withdraw from the study, simply select Leave Study on the profile tab."
    ]
    
    
    //MARK: Initialization
    
    override init() {
        super.init()

        title = NSLocalizedString("Consent Form", comment: "")
        
        let sectionTypes: [ORKConsentSectionType] = [
            .overview,
            .dataGathering,
            .privacy,
            .dataUse,
            .timeCommitment,
            .studySurvey,
            .studyTasks,
            .withdrawing
        ]
        
        sections = zip(sectionTypes, information).map { sectionType, information in
            let section = ORKConsentSection(type: sectionType)
            
            let localizedInformation = NSLocalizedString(information, comment: "")
            let localizedSummary = localizedInformation.components(separatedBy: ".")[0] + "."
            
            section.summary = localizedSummary
            section.content = localizedInformation
            
            return section
        }
        
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipation")
        addSignature(signature)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ORKConsentSectionType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .overview:
            return "Overview"
            
        case .dataGathering:
            return "DataGathering"
            
        case .privacy:
            return "Privacy"
            
        case .dataUse:
            return "DataUse"
            
        case .timeCommitment:
            return "TimeCommitment"
            
        case .studySurvey:
            return "StudySurvey"
            
        case .studyTasks:
            return "StudyTasks"
            
        case .withdrawing:
            return "Withdrawing"
            
        case .custom:
            return "Custom"
            
        case .onlyInDocument:
            return "OnlyInDocument"
        }
    }
}
