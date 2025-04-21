//
//  FoodCaloriesUIData.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import Foundation

struct FoodCaloriesDetailUIData: Identifiable {
    let id: UUID
    
    let calories: Int
    let carbs: Int
    let protein: Int
    let fat: Int
    let image: Data?
    
    let date: Date
    let type: MealType
}

struct DayFoodCaloriesUIData {
    let id: UUID
    
    let date: String
    
    let foods: [FoodCaloriesDetailUIData]
    let goalCalories: Int
    let goalCarbs: Int
    let goalProtein: Int
    let goalFat: Int
}

struct FoodCaloriesChartData: Identifiable {
    let id: UUID
    let rawValue: Int
    let percent: CGFloat
    let goal: Int
}



extension DayFoodCaloriesUIData {
    func toDataModel() -> DayFoodCaloriesData {
        
        let rawFoods = foods.map { food in
            FoodCaloriesData(
                id: food.id,
                calories: food.calories,
                carbs: food.carbs,
                protein: food.protein,
                fat: food.fat,
                image: food.image,
                date: food.date,
                type: food.type.label
            )
        }

        return DayFoodCaloriesData(
            id: id,
            date: DateManager.shared.getDate(from: date),
            foods: rawFoods,
            goalCalories: goalCalories,
            goalCarbs: goalCarbs,
            goalProtein: goalProtein,
            goalFat: goalFat
        )
    }
}
