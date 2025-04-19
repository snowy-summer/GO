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
    
    var minWeight: Double = 0
    var maxWeight: Double = 0
    
    
    private let muscleMessChartUseCase: MuscleMessChartUseCaseProtocol
    
    enum Intent {
        case fetchBodyFatMass
    }
    
    init(muscleMessChartUseCase: MuscleMessChartUseCaseProtocol = MuscleMessChartUseCase()) {
        self.muscleMessChartUseCase = muscleMessChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchBodyFatMass:
            weightList = muscleMessChartUseCase.fetchChartData()
            minWeight = (weightList.map { $0.muscleMass }.min() ?? 0) - 2
            maxWeight = (weightList.map { $0.muscleMass }.max() ?? 0) + 2
            recentBodyFatMass = weightList.last?.bodyFatMass ?? 0
            duration = muscleMessChartUseCase.getDateRange()
        }
    }
    
    
}
