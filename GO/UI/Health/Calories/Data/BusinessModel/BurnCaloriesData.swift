//
//  BurnCaloriesData.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct BurnCaloriesData: Codable {
    var calories: Int
    var date: Date
}

struct FoodCaloriesData: Codable {
    var calories: Int
    var date: Date
    var type: String
}
