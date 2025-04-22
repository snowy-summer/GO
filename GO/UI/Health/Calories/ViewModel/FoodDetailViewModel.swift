//
//  FoodDetailViewModel.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import Foundation

protocol FoodDetailViewModelProtocol: ViewModelAble {
    
    var breakfast: FoodCaloriesDetailUIData { get }
    var lunch: FoodCaloriesDetailUIData { get }
    var dinner: FoodCaloriesDetailUIData { get }
    var snack: FoodCaloriesDetailUIData { get }
    
    var goalCalories: Int { get }
    var goalCarbs: Int { get }
    var goalProtein: Int { get }
    var goalFat: Int { get }
    
    var day: String { get }
    
    var totalCalories: Int { get }
    var totalCarbs: Int { get }
    var totalProtein: Int { get }
    var totalFat: Int { get }
    
    var remainCalories: Int { get }
    
    var isBreakfastExpanded: Bool { get }
    var isLunchExpanded: Bool { get }
    var isDinnerExpanded: Bool { get }
    var isSnackExpanded: Bool { get }
}

final class FoodDetailViewModel: FoodDetailViewModelProtocol {
    
    var todayUIData: DayFoodCaloriesUIData?
    
    @Published var breakfast: FoodCaloriesDetailUIData = FoodCaloriesDetailUIData(type: .breakfast)
    @Published var lunch: FoodCaloriesDetailUIData = FoodCaloriesDetailUIData(type: .lunch)
    @Published var dinner: FoodCaloriesDetailUIData = FoodCaloriesDetailUIData(type: .dinner)
    @Published var snack: FoodCaloriesDetailUIData = FoodCaloriesDetailUIData(type: .snack)
    
    @Published var goalCalories: Int = UserDefaultsManager.shared.foodCaloriesGoal
    @Published var goalCarbs: Int = UserDefaultsManager.shared.foodCarbsGoal
    @Published var goalProtein: Int = UserDefaultsManager.shared.foodProteinGoal
    @Published var goalFat: Int = UserDefaultsManager.shared.foodFatGoal
    
    @Published var day: String = ""
    
    @Published var totalCalories: Int = 0
    @Published var totalCarbs: Int = 0
    @Published var totalProtein: Int = 0
    @Published var totalFat: Int = 0
    
    @Published var remainCalories: Int = 0
    
    @Published var isBreakfastExpanded: Bool = false
    @Published var isLunchExpanded: Bool = false
    @Published var isDinnerExpanded: Bool = false
    @Published var isSnackExpanded: Bool = false
    
    private let foodCaloriesUseCase: FoodCaloriesUseCaseProtocol
    
    enum Intent {
        case fetchData
    }
    
    init(foodCaloriesUseCase: FoodCaloriesUseCaseProtocol = FoodCaloriesUseCase()) {
        self.foodCaloriesUseCase = foodCaloriesUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchData:
            todayUIData = foodCaloriesUseCase.getTodayUIData()
            
            guard let todayUIData = todayUIData else {
                LogManager.log("데이터가 없습니다.")
                return
            }
            
            updateFoods(from: todayUIData)
            updateGoals(from: todayUIData)
            updateTotals(from: todayUIData)
            updateDate(from: todayUIData)
           
        }
    }
    
}

extension FoodDetailViewModel {
    
    private func updateFoods(from data: DayFoodCaloriesUIData) {
        if let breakfastData = data.foods.first(where: { $0.type == .breakfast }) {
            breakfast = breakfastData
        }

        if let lunchData = data.foods.first(where: { $0.type == .lunch }) {
            lunch = lunchData
        }

        if let dinnerData = data.foods.first(where: { $0.type == .dinner }) {
            dinner = dinnerData
        }

        if let snackData = data.foods.first(where: { $0.type == .snack }) {
            snack = snackData
        }
    }
    
    private func updateGoals(from data: DayFoodCaloriesUIData) {
        
        if data.goalIntake.calories > 0 {
            goalCalories = data.goalIntake.calories
        }
        if data.goalIntake.carbs > 0 {
            goalCarbs = data.goalIntake.carbs
        }
        if data.goalIntake.protein > 0 {
            goalProtein = data.goalIntake.protein
        }
        if data.goalIntake.fat > 0 {
            goalFat = data.goalIntake.fat
        }
    }

    private func updateTotals(from data: DayFoodCaloriesUIData) {
        totalCalories = foodCaloriesUseCase.getTotal(for: .calories, from: data.foods)
        totalCarbs = foodCaloriesUseCase.getTotal(for: .carbs, from: data.foods)
        totalProtein = foodCaloriesUseCase.getTotal(for: .protein, from: data.foods)
        totalFat = foodCaloriesUseCase.getTotal(for: .fat, from: data.foods)
        
        remainCalories = goalCalories - totalCalories
    }

    private func updateDate(from data: DayFoodCaloriesUIData) {
        day = data.date
    }
}


