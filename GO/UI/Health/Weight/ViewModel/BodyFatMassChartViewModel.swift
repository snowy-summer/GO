//
//  BodyFatMassChartViewModel.swift
//  GO
//
//  Created by 최승범 on 4/19/25.
//

import Foundation

protocol BodyFatMassChartViewModelProtocol: ViewModelAble {
    
}


final class BodyFatMassChartViewModel: BodyFatMassChartViewModelProtocol {
    
    @Published var weightList: [WeightChartData] = []
    @Published var duration: String = ""
    
    @Published var recentBodyFatMass: Double = 0
    @Published var recentBodyFatMassPercent: Double = 0
    
    var minBodyFat: Double = 0
    var maxBodyFat: Double = 0
    
    
    private let bodyFatMassChartUseCase: BodyFatMassChartUseCaseProtocol
    
    enum Intent {
        case fetchBodyFatMass
    }
    
    init(bodyFatMassChartUseCase: BodyFatMassChartUseCaseProtocol = BodyFatMassChartUseCase()) {
        self.bodyFatMassChartUseCase = bodyFatMassChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchBodyFatMass:
            weightList = bodyFatMassChartUseCase.fetchChartData()
            minBodyFat = (weightList.map { $0.bodyFatMass }.min() ?? 0) - 2
            maxBodyFat = (weightList.map { $0.bodyFatMass }.max() ?? 0) + 2
            recentBodyFatMass = weightList.last?.bodyFatMass ?? 0
            recentBodyFatMassPercent = bodyFatMassChartUseCase.getRecentBodyFatMassPercent(from: weightList)
            duration = bodyFatMassChartUseCase.getDateRange()
        }
    }
    
    
}
