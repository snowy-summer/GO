//
//  CaloriesCalculatorUseCase.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

final class CaloriesCalculatorUseCase {
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    private let caloriesManager: CaloriesManager = CaloriesManager()
    
    
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
