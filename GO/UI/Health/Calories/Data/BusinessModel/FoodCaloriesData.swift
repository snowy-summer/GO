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
    let goalIntake: GoalIntake
}

struct FoodCaloriesData: Codable, Identifiable {
    let id: UUID
    
    let name: String
    let calories: Int
    let carbs: Int
    let protein: Int
    let fat: Int
    let image: Data?
    
    let goalIntake: GoalIntake
    
    let date: Date
    let type: String
}

struct GoalIntake: Codable {
    var calories: Int
    var carbs: Int
    var protein: Int
    var fat: Int
}

extension DayFoodCaloriesData {
    func toUIModel() -> DayFoodCaloriesUIData {
        let uiFoods = foods.compactMap { food in
            let mealType = MealType(rawValue: food.type)
            
            return FoodCaloriesDetailUIData(
                id: food.id,
                name: food.name,
                calories: food.calories,
                carbs: food.carbs,
                protein: food.protein,
                fat: food.fat,
                image: food.image,
                goalIntake: food.goalIntake,
                date: food.date,
                type: mealType
            )
        }
        
        return DayFoodCaloriesUIData(
            id: id,
            date: DateManager.shared.getDateString(date: date, format: "yyyy.MM.dd"),
            foods: uiFoods,
            goalIntake: goalIntake
        )
    }
}
