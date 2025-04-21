//
//  FoodDetailViewModel.swift
//  GO
//
//  Created by 최승범 on 4/21/25.
//

import Foundation

protocol FoodDetailViewModelProtocol: ViewModelAble {
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
    var isLunchfastExpanded: Bool { get }
    var isDinnerExpanded: Bool { get }
    var isSnackExpanded: Bool { get }
}

final class FoodDetailViewModel: FoodDetailViewModelProtocol {
    
    var todayUIData: DayFoodCaloriesUIData?
    
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
    @Published var isLunchfastExpanded: Bool = false
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
            
            updateGoals(from: todayUIData)
            updateTotals(from: todayUIData)
            updateDate(from: todayUIData)
           
        }
    }
    
}

extension FoodDetailViewModel {
    private func updateGoals(from data: DayFoodCaloriesUIData) {
        if data.goalCalories > 0 {
            goalCalories = data.goalCalories
        }
        if data.goalCarbs > 0 {
            goalCarbs = data.goalCarbs
        }
        if data.goalProtein > 0 {
            goalProtein = data.goalProtein
        }
        if data.goalFat > 0 {
            goalFat = data.goalFat
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


