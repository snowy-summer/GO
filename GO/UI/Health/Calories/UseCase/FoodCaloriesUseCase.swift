//
//  FoodCaloriesUseCase.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol FoodCaloriesUseCaseProtocol {
    func getFoodCaloriesChartData() -> FoodCaloriesChartData
    func getTodayUIData() -> DayFoodCaloriesUIData
    func getTotal(for type: NutrientType, from data: [FoodCaloriesDetailUIData]) -> Int
}

final class FoodCaloriesUseCase: FoodCaloriesUseCaseProtocol {
    
    private let dateManager: DateManager = DateManager.shared
    private let caloriesManager: CaloriesManager = CaloriesManager()
    private let caloriesRepository: FoodCaloriesRepositoryProtocol = MockFoodCaloriesRepository()
    
        /// 칼로리 차트 데이터를 받아오기. Repository에서 오늘 음식 칼로리 목록을 받아오고 퍼센트 계산을 진행
    func getFoodCaloriesChartData() -> FoodCaloriesChartData {
        let calories = caloriesRepository.fetchFoodCaloriesToday()
        return calculateCaloriesPercent(for: calories)
    }
    
    func getTodayUIData() -> DayFoodCaloriesUIData {
        let dayData = caloriesRepository.fetchFoodCaloriesToday()
        return dayData.toUIModel()
    }
    
    func getTotal(for type: NutrientType,
                  from data: [FoodCaloriesDetailUIData]) -> Int {
        switch type {
        case .carbs:
            return data.map { $0.carbs }.reduce(0, +)
        case .protein:
            return data.map { $0.protein }.reduce(0, +)
        case .fat:
            return data.map { $0.fat }.reduce(0, +)
        case .calories:
            return data.map { $0.calories }.reduce(0, +)
        }
    }
    
    /// 칼로리 퍼센트 계산
    private func calculateCaloriesPercent(for dayData: DayFoodCaloriesData) -> FoodCaloriesChartData {

        let caloriesRawValue = dayData.foods.map { $0.calories }
        let totalCalories = caloriesRawValue.reduce(0, +)
        let goalCalories = dayData.goalCalories
        
        let rawPercent = CGFloat(totalCalories) / CGFloat(goalCalories)
        let percent = min(rawPercent, 1.0) * 0.5
        
        return FoodCaloriesChartData(id: dayData.id,
                                     rawValue: totalCalories,
                                     percent: percent,
                                     goal: goalCalories)
    }
    
}
