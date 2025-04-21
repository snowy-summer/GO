//
//  FoodCaloriesRepository.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol FoodCaloriesRepositoryProtocol {
    func fetchFoodCaloriesToday() -> DayFoodCaloriesData
}

final class MockFoodCaloriesRepository: FoodCaloriesRepositoryProtocol {
    func fetchFoodCaloriesToday() -> DayFoodCaloriesData {
        let dateManager = DateManager.shared
        let mockData = [
            FoodCaloriesData(
                id: UUID(),
                calories: 720,
                carbs: 50,
                protein: 30,
                fat: 18,
                image: nil,
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Breakfast"
            ),
            FoodCaloriesData(
                id: UUID(),
                calories: 820,
                carbs: 65,
                protein: 28,
                fat: 22,
                image: nil,
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Lunch"
            ),
            FoodCaloriesData(
                id: UUID(),
                calories: 610,
                carbs: 40,
                protein: 22,
                fat: 20,
                image: nil,
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Dinner"
            ),
            FoodCaloriesData(
                id: UUID(),
                calories: 190,
                carbs: 22,
                protein: 5,
                fat: 6,
                image: nil,
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Snack"
            )
        ]
        let dayData = DayFoodCaloriesData(id: UUID(),
                                          date: dateManager.getDate(from: "2025.04.13"),
                                          foods: mockData,
                                          goalCalories: 2500, goalCarbs: 190, goalProtein: 120, goalFat: 87)
        return dayData
    }
}
