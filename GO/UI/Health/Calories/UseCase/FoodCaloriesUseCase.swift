//
//  FoodCaloriesUseCase.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol FoodCaloriesUseCaseProtocol {
    func getFoodCaloriesChartData() -> FoodCaloriesChartData
    func calculateCaloriesPercent(for calories: [FoodCaloriesData]) -> FoodCaloriesChartData
}

final class FoodCaloriesUseCase: FoodCaloriesUseCaseProtocol {
    
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    private let dateManager: DateManager = DateManager.shared
    private let caloriesManager: CaloriesManager = CaloriesManager()
    private let caloriesRepository: FoodCaloriesRepositoryProtocol = MockFoodCaloriesRepository()
    
        /// 칼로리 차트 데이터를 받아오기. Repository에서 오늘 음식 칼로리 목록을 받아오고 퍼센트 계산을 진행
    func getFoodCaloriesChartData() -> FoodCaloriesChartData {
        let calories = caloriesRepository.fetchFoodCaloriesToday()
        return calculateCaloriesPercent(for: calories)
    }
    
    /// 칼로리 퍼센트 계산
    func calculateCaloriesPercent(for calories: [FoodCaloriesData]) -> FoodCaloriesChartData {
        
        let caloriesRawValue = calories.map { $0.calories }
        let totalCalories = caloriesRawValue.reduce(0, +)
        let goalCalories = userData.foodCaloriesGoal
        
        let rawPercent = CGFloat(totalCalories) / CGFloat(goalCalories)
        let percent = min(rawPercent, 1.0) * 0.5
        
        return FoodCaloriesChartData(rawValue: totalCalories,
                                     percent: percent,
                                     goal: goalCalories)
    }
    
    
}
