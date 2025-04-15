//
//  BurnCaloriesCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

final class BurnCaloriesCardViewModel: BurnCaloriesCardViewModelProtocol {
    
    @Published var calories: [CaloriesChartData] = []
    @Published var duration: String = "13 - 19 April 2025"
    
    @Published var todayCalories: Int = 0
    @Published var averageCalories: Int = 0
    
    
    private let caloriesUseCase: CaloriesCalculatorUseCaseProtocol
    
    init(caloriesUseCase: CaloriesCalculatorUseCaseProtocol = CaloriesCalculatorUseCase()) {
        self.caloriesUseCase = caloriesUseCase
    }
    
    
    func fetchCalories() {
        calories = caloriesUseCase.getCaloriesChartData()
    }
    
}

protocol BurnCaloriesCardViewModelProtocol: AnyObject, ObservableObject {

    var calories: [CaloriesChartData] { get }
    var duration: String { get }
    var todayCalories: Int { get }
    var averageCalories: Int { get }
}
