//
//  FoodCaloriesCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol FoodCaloriesCardViewModelProtocol: ViewModelAble {
    var calories: FoodCaloriesChartData { get }
    var percent: CGFloat { get }
}

final class FoodCaloriesCardViewModel: FoodCaloriesCardViewModelProtocol {
    
    @Published var calories: FoodCaloriesChartData = FoodCaloriesChartData(rawValue: 0, percent: 0, goal: 0)
    @Published var percent: CGFloat = 0
    
    private let caloriesUseCase: FoodCaloriesUseCaseProtocol
    
    enum Intent {
        case fetchCalories
    }
    
    init(caloriesUseCase: FoodCaloriesUseCaseProtocol = FoodCaloriesUseCase()) {
        self.caloriesUseCase = caloriesUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchCalories:
            calories = caloriesUseCase.getFoodCaloriesChartData()
            percent = calories.percent
        }
    }
    
}

