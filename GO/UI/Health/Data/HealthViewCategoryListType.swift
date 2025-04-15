//
//  HealthViewCategoryListType.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import SwiftUI

enum HealthViewCategoryListType: CaseIterable {
    case dashboard
    case information
    case calories
    case workouts
    
    
    var data: ImageTextData {
        switch self {
        case .dashboard:
            return ImageTextData(text: "Dashboard", imageName: "house")
        case .information:
            return ImageTextData(text: "Information", imageName: "person.text.rectangle")
        case .calories:
            return ImageTextData(text: "Calories", imageName: "carrot")
        case .workouts:
            return ImageTextData(text: "Work Outs", imageName: "dumbbell")
        }
    }
    
}
