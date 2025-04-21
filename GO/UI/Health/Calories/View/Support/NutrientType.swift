//
//  NutrientType.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import SwiftUI

enum NutrientType {
    case carbs
    case protein
    case fat
    
    var label: String {
        switch self {
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
        case .carbs:
            return .carbs
        case .protein:
            return .protein
        case .fat:
            return .fat
        }
    }
}
