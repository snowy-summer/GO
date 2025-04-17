//
//  ViewModelAble.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol ViewModelAble: AnyObject, ObservableObject {
    associatedtype Intent
    func action(_ intent: Intent)
}
