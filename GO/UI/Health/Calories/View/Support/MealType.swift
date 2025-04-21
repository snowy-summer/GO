//
//  MealType.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import Foundation

enum MealType {
    case breakfast
    case lunch
    case dinner
    case snack
    
    init(rawValue: String) {
        switch rawValue {
        case "Breakfast":
            self = .breakfast
        case "Lunch":
            self = .lunch
        case "Dinner":
            self = .dinner
        case "Snack":
            self = .snack
        default:
            self = .snack
        }
    }
    
    var label: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .snack:
            return "Snack"
        }
    }
}
