//
//  UserDefaultsManager.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let defaults = UserDefaults.standard

    var wrappedValue: T {
        get { defaults.object(forKey: key) as? T ?? defaultValue }
        set { defaults.setValue(newValue, forKey: key) }
    }
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}

    @UserDefault(key: "burnCaloriesGoal", defaultValue: 600)
    var burnCaloriesGoal: Int

    @UserDefault(key: "foodCaloriesGoal", defaultValue: 2400)
    var foodCaloriesGoal: Int
    
    @UserDefault(key: "weightGoal", defaultValue: 70)
    var weightGoal: Double
    
    @UserDefault(key: "userHeight", defaultValue: 170)
    var userHeight: Double
    
    @UserDefault(key: "gender", defaultValue: "male")
    var gender: String
}
