//
//  FoodCaloriesData.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import Foundation

struct DayFoodCaloriesData: Codable {
    let id: UUID
    let date: Date
    let foods: [FoodCaloriesData]
    let goalCalories: Int
    let goalCarbs: Int
    let goalProtein: Int
    let goalFat: Int
}

struct FoodCaloriesData: Codable, Identifiable {
    let id: UUID
    
    let calories: Int
    let carbs: Int
    let protein: Int
    let fat: Int
    let image: Data?
    
    let date: Date
    let type: String
}

extension DayFoodCaloriesData {
    func toUIModel() -> DayFoodCaloriesUIData {
        let uiFoods = foods.compactMap { food in
            let mealType = MealType(rawValue: food.type)
            
            return FoodCaloriesDetailUIData(
                id: food.id,
                calories: food.calories,
                carbs: food.carbs,
                protein: food.protein,
                fat: food.fat,
                image: food.image,
                date: food.date,
                type: mealType
            )
        }

        return DayFoodCaloriesUIData(
            id: id,
            date: DateManager.shared.getDateString(date: date, format: "yyyy.MM.dd"),
            foods: uiFoods,
            goalCalories: goalCalories,
            goalCarbs: goalCarbs,
            goalProtein: goalProtein,
            goalFat: goalFat
        )
    }
}
