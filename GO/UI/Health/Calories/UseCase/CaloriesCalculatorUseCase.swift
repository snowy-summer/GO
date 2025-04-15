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
    private let dateManager: DateManager = DateManager.shared
    private let caloriesManager: CaloriesManager = CaloriesManager()
    private let caloriesRepository: CaloriesRepositoryProtocol = MockCaloriesRepository()
    
        /// 칼로리 차트 데이터를 받아오기. Repository에서 이번주 칼로리 목록을 받아오고 퍼센트 계산을 진행
    func getCaloriesChartData() -> [CaloriesChartData] {
        let calories = caloriesRepository.fetchCaloriesThisWeek()
        return calculateCaloriesPercent(for: calories)
    }
    
    /// 칼로리 퍼센트 계산
    func calculateCaloriesPercent(for calories: [CaloriesData]) -> [CaloriesChartData] {
        
        let caloriesRawValue = calories.map { $0.calories }
        let goalCalories = userData.caloriesGoal
        
        let percentList = caloriesManager.calculateCaloriesPercent(for: caloriesRawValue,
                                                                   goal: goalCalories)
        
        let caloriesUIData = zip(calories, percentList).map { (entry, percent) in
            CaloriesChartData(text: dateManager.weekdayString(from: entry.date, style: .narrow),
                              rawValue: entry.calories,
                              percent: percent,
                              isToday: dateManager.isSameWeekday(entry.date, Date()))
        }
        
        return caloriesUIData
    }
    
    
}


