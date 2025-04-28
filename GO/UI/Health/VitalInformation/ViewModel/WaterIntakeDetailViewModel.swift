//
//  WaterIntakeDetailViewModel.swift
//  GO
//
//  Created by 최승범 on 4/28/25.
//

import Foundation

final class WaterIntakeDetailViewModel: ObservableObject {
    @Published var todayWater: Double = 3.0
    @Published var goalWater: Double = 2.0
    @Published var weeklyWaterData: [WaterChartData] = []
    @Published var isAnimating: Bool = false
    
    private let waterChartUseCase: WaterChartUseCaseProtocol = WaterChartUseCase()
    
    var isGoalReached: Bool {
        todayWater >= goalWater
    }
    
    var weeklyAverage: Double {
        guard !weeklyWaterData.isEmpty else { return 0 }
        let total = weeklyWaterData.map { $0.rawValue }.reduce(0, +)
        return total / Double(weeklyWaterData.count)
    }
    
    enum Intent {
        case fetchWaterData
        case addWater(amount: Double)
        case animationOn
        
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchWaterData:
            weeklyWaterData = waterChartUseCase.fetchChartData()
        
        case .addWater(let amount):
            todayWater += amount
            
        case .animationOn:
            isAnimating = true
        }
    }
}
