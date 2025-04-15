//
//  CaloriesCalculatorUseCase.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol CaloriesCalculatorUseCaseProtocol {
    func getCaloriesChartData() -> [CaloriesChartData]
    func calculateCaloriesPercent(for calories: [CaloriesData]) -> [CaloriesChartData]
}

final class CaloriesCalculatorUseCase: CaloriesCalculatorUseCaseProtocol {
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    private let caloriesManager: CaloriesManager = CaloriesManager()
    private let caloriesRepository: CaloriesRepositoryProtocol = MockCaloriesRepository()
    
    
    func getCaloriesChartData() -> [CaloriesChartData] {
        let calories = caloriesRepository.fetchCaloriesThisWeek()
        return calculateCaloriesPercent(for: calories)
    }
    
    func calculateCaloriesPercent(for calories: [CaloriesData]) -> [CaloriesChartData] {
        
        let caloriesRawValue = calories.map { $0.calories }
        let goalCalories = userData.caloriesGoal
        
        let percentList = caloriesManager.calculateCaloriesPercent(for: caloriesRawValue,
                                                                   goal: goalCalories)
        
        let caloriesUIData = zip(calories, percentList).map { (entry, percent) in
            CaloriesChartData(text: entry.date, rawValue: entry.calories, percent: percent)
        }
        
        return caloriesUIData
    }
    
    
}


