//
//  FoodCaloriesRepository.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol FoodCaloriesRepositoryProtocol {
    func fetchFoodCaloriesToday() -> [FoodCaloriesData]
}

final class MockFoodCaloriesRepository: FoodCaloriesRepositoryProtocol {
    func fetchFoodCaloriesToday() -> [FoodCaloriesData] {
        let dateManager = DateManager.shared
        return [
            FoodCaloriesData(calories: 720, date: dateManager.getDate(from: "2025.04.13"), type: "lunch"),
            FoodCaloriesData(calories: 1100, date: dateManager.getDate(from: "2025.04.13"), type: "dinner"),
            FoodCaloriesData(calories: 110, date: dateManager.getDate(from: "2025.04.13"), type: "snack")
            ]
    }
}
