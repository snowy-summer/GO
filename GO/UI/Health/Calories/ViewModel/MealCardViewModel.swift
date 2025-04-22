//
//  MealCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/22/25.
//

import Foundation

protocol MealCardViewModelProtocol: ViewModelAble {
    
}

final class MealCardViewModel: ObservableObject {
    let type: MealType
    let data: FoodCaloriesDetailUIData

    @Published var isExpanded: Bool = false

    @Published var goalCalories: Int = 0
    @Published var goalCarbs: Int = 0
    @Published var goalProtein: Int = 0
    @Published var goalFat: Int = 0

    @Published var isCaloriesState: ValueState = .under
    @Published var isCarbsState: ValueState = .under
    @Published var isProteinState: ValueState = .under
    @Published var isFatState: ValueState = .under
    var remainCalories: String = ""
    var remainCarbs: String = ""
    var remainProtein: String = ""
    var remainfat: String = ""

    @Published var caloriesPercent: Double = 0
    @Published var carbsPercent: Double = 0
    @Published var proteinPercent: Double = 0
    @Published var fatPercent: Double = 0

    init(type: MealType, data: FoodCaloriesDetailUIData) {
        self.type = type
        self.data = data
        action(.calculate)
    }

    enum Intent {
        case calculate
    }

    func action(_ intent: Intent) {
        switch intent {
        case .calculate:
            goalCalories = data.goalIntake.calories
            goalCarbs = data.goalIntake.carbs
            goalProtein = data.goalIntake.protein
            goalFat = data.goalIntake.fat

            isCaloriesState = updateValueState(of: data.calories,
                                               goal: goalCalories)
            isCarbsState = updateValueState(of: data.carbs,
                                            goal: goalCarbs)
            isProteinState = updateValueState(of: data.protein,
                                              goal: goalProtein)
            isFatState = updateValueState(of: data.fat,
                                          goal: goalFat)
            
            remainCalories = updateRemainValue(of: data.calories,
                                               goal: goalCalories)
            
            remainCarbs = updateRemainValue(of: data.carbs,
                                            goal: goalCarbs)
            remainProtein = updateRemainValue(of: data.protein,
                                              goal: goalProtein)
            remainfat = updateRemainValue(of: data.fat,
                                          goal: goalFat)

            caloriesPercent = percent(of: data.calories, goal: goalCalories)
            carbsPercent = percent(of: data.carbs, goal: goalCarbs)
            proteinPercent = percent(of: data.protein, goal: goalProtein)
            fatPercent = percent(of: data.fat, goal: goalFat)
        }
    }

    private func percent(of value: Int, goal: Int) -> Double {
        guard goal > 0 else { return 0 }
        return Double(value) / Double(goal)
    }
    
    private func updateValueState(of value: Int, goal: Int) -> ValueState {
        if value > goal {
            return .over
        } else if value == goal {
            return .normal
        } else {
            return .under
        }
    }
    
    private func updateRemainValue(of value: Int, goal: Int) -> String {
        if value > goal {
            return "+ \(value - goal) g"
        } else if value == goal {
            return " 0 g"
        } else {
            return "- \(goal - value) g"
        }
    }
}
