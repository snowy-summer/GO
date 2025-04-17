//
//  BurnCaloriesCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol BurnCaloriesCardViewModelProtocol: ViewModelAble {
    var calories: [BurnCaloriesChartData] { get }
    var duration: String { get }
    var todayCalories: Int { get }
    var averageCalories: Int { get }
}

final class BurnCaloriesCardViewModel: BurnCaloriesCardViewModelProtocol {
    
    @Published var calories: [BurnCaloriesChartData] = []
    @Published var duration: String = "13 - 19 April 2025"
    
    @Published var todayCalories: Int = 0
    @Published var averageCalories: Int = 0
    
    @Published var isAnimating: Bool = false
    
    private let caloriesUseCase: BurnCaloriesCalculatorUseCaseProtocol
    
    enum Intent {
        case fetchCalories
        case animationOn
    }
    
    init(caloriesUseCase: BurnCaloriesCalculatorUseCaseProtocol = BurnCaloriesCalculatorUseCase()) {
        self.caloriesUseCase = caloriesUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchCalories:
            calories = caloriesUseCase.getBurnCaloriesChartData()
            isAnimating = false
            
        case .animationOn:
            isAnimating = true
        }
    }
    
}

