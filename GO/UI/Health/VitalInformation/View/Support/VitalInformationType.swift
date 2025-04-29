//
//  CardType.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

enum VitalInformationType: CaseIterable {
    case heartRate
    case sleepTime
    case steps
    case water
    
    var image: String {
        switch self {
        case .heartRate:
            return "heartRate"
        case .sleepTime:
            return "moon.zzz.fill"
        case .steps:
            return "shoe.fill"
        case .water:
            return "drop.fill"
        }
    }
    
    var title: String {
        switch self {
        case .heartRate:
            return "Heart Rate"
        case .sleepTime:
            return "Sleep"
        case .steps:
            return "Steps"
        case .water:
            return "Water"
        }
    }
}
