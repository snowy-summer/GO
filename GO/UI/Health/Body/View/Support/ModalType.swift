//
//  ModalType.swift
//  GO
//
//  Created by 최승범 on 5/19/25.
//

import Foundation

enum ModalType: Identifiable {
    case add
    case edit
    
    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit:
            return "edit"
        }
    }
}
