//
//  FoodCaloriesUIData.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import Foundation

struct FoodCaloriesDetailUIData: Identifiable {
    let id: UUID
    
    let name: String
    
    let calories: Int
    let carbs: Int
    let protein: Int
    let fat: Int
    let image: Data?
    
    var goalIntake: GoalIntake
    
    let date: Date
    let type: MealType
    
    
    init(id: UUID = UUID(),
         name: String = "",
         calories: Int = 0,
         carbs: Int = 0,
         protein: Int = 0,
         fat: Int = 0,
         image: Data? = nil,
         goalIntake: GoalIntake = GoalIntake(calories: 0, carbs: 0, protein: 0, fat: 0),
         date: Date = Date(),
         type: MealType) {
        self.id = id
        self.name = name
        self.calories = calories
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
        self.image = image
        self.goalIntake = goalIntake
        self.date = date
        self.type = type
    }
}

struct DayFoodCaloriesUIData {
    let id: UUID
    
    let date: String
    
    var foods: [FoodCaloriesDetailUIData]
    let goalIntake: GoalIntake
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
                name: food.name,
                calories: food.calories,
                carbs: food.carbs,
                protein: food.protein,
                fat: food.fat,
                image: food.image,
                goalIntake: food.goalIntake,
                date: food.date,
                type: food.type.label
            )
        }

        return DayFoodCaloriesData(
            id: id,
            date: DateManager.shared.getDate(from: date),
            foods: rawFoods,
            goalIntake: goalIntake
        )
    }
}
