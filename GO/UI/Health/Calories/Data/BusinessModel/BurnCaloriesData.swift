//
//  BurnCaloriesData.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct BurnCaloriesData: Codable {
    let calories: Int
    let date: Date
}

struct FoodCaloriesData: Codable {
    let calories: Int
    let date: Date
    let type: String
}
