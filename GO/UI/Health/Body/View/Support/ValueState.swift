//
//  ValueState.swift
//  GO
//
//  Created by 최승범 on 4/19/25.
//

import SwiftUI

enum ValueState: CaseIterable {
    case over
    case normal
    case under
    
    var color: Color {
        switch self {
        case .over:
            return .over
        case .normal:
            return .normal
        case .under:
            return .yellow
        }
    }
    
    var title: String {
        switch self {
        case .over:
            return "Over"
        case .normal:
            return "Normal"
        case .under:
            return "Under"
        }
    }
}
