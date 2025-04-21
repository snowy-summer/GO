//
//  NutrientType.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import SwiftUI

enum NutrientType {
    case calories
    case carbs
    case protein
    case fat
    
    var label: String {
        switch self {
        case .calories:
            return "Calories"
        case .carbs:
            return "Carbs"
        case .protein:
            return "Protein"
        case .fat:
            return "Fat"
        }
    }
    
    var color: Color {
        switch self {
        case .calories:
            return .calories
        case .carbs:
            return .carbs
        case .protein:
            return .protein
        case .fat:
            return .fat
        }
    }
}
