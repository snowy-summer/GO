//
//  HealthViewCategoryListType.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import SwiftUI

enum HealthViewCategoryListType: CaseIterable {
    case dashboard
    case bodyInformation
    case calories
    case workouts
    case vitalInformation
    
    
    var data: ImageTextData {
        switch self {
        case .dashboard:
            return ImageTextData(text: "Dashboard", imageName: "house")
        case .bodyInformation:
            return ImageTextData(text: "Body Information", imageName: "person.text.rectangle")
        case .calories:
            return ImageTextData(text: "Calories", imageName: "carrot")
        case .workouts:
            return ImageTextData(text: "Work Outs", imageName: "dumbbell")
        case .vitalInformation:
            return ImageTextData(text: "Vital Information", imageName: "person.text.rectangle")
        }
    }
    
}
