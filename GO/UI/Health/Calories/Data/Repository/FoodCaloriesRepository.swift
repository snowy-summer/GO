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
                name: "시리얼 100g",
                calories: 720,
                carbs: 50,
                protein: 30,
                fat: 18,
                image: nil,
                goalIntake: GoalIntake(calories: 700, carbs: 54, protein: 23, fat: 12),
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Breakfast"
            ),
            FoodCaloriesData(
                id: UUID(),
                name: "파스타",
                calories: 820,
                carbs: 65,
                protein: 28,
                fat: 22,
                image: nil,
                goalIntake: GoalIntake(calories: 700, carbs: 54, protein: 23, fat: 12),
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Lunch"
            ),
            FoodCaloriesData(
                id: UUID(),
                name: "갈비찜",
                calories: 610,
                carbs: 40,
                protein: 22,
                fat: 20,
                image: nil,
                goalIntake: GoalIntake(calories: 700, carbs: 54, protein: 23, fat: 12),
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Dinner"
            ),
            FoodCaloriesData(
                id: UUID(),
                name: "스콘",
                calories: 190,
                carbs: 22,
                protein: 5,
                fat: 6,
                image: nil,
                goalIntake: GoalIntake(calories: 200, carbs: 54, protein: 23, fat: 12),
                date: dateManager.getDate(from: "2025.04.13"),
                type: "Snack"
            )
        ]
        let dayData = DayFoodCaloriesData(id: UUID(),
                                          date: dateManager.getDate(from: "2025.04.13"),
                                          foods: mockData,
                                          goalIntake: GoalIntake(calories: 2500, carbs: 190, protein: 120, fat: 87))
        return dayData
    }
}
