//
//  HealthDataCategory.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

enum HealthDataCategory: CaseIterable {
    case heartRate
    case sleepTime
    case stepCount
    case waterConsumption
    
    var data: ImageTextData {
        switch self {
        case .heartRate:
            return ImageTextData(text: "120", imageName: "heartRate")
        case .sleepTime:
            return ImageTextData(text: "Information", imageName: "person.text.rectangle")
        case .stepCount:
            return ImageTextData(text: "Calories", imageName: "carrot")
        case .waterConsumption:
            return ImageTextData(text: "Work Outs", imageName: "dumbbell")
        }
    }
}
