//
//  MuscleMessChartViewModel.swift
//  GO
//
//  Created by 최승범 on 4/18/25.
//

import Foundation

protocol MuscleMessChartViewModelProtocol: ViewModelAble {
    
}


final class MuscleMessChartViewModel: MuscleMessChartViewModelProtocol {
    
    @Published var weightList: [WeightChartData] = []
    @Published var duration: String = ""
    
    @Published var recentMuscleMess: Double = 0
    @Published var goalMuscleMess: Double = UserDefaultsManager.shared.weightGoal
    
    var minWeight: Double = 0
    var maxWeight: Double = 0
    
    
    private let muscleMessChartUseCase: MuscleMessChartUseCaseProtocol
    
    enum Intent {
        case fetchMuscleMess
    }
    
    init(muscleMessChartUseCase: MuscleMessChartUseCaseProtocol = MuscleMessChartUseCase()) {
        self.muscleMessChartUseCase = muscleMessChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchMuscleMess:
            weightList = muscleMessChartUseCase.fetchChartData()
            minWeight = (weightList.map { $0.muscleMess }.min() ?? 0) - 2
            maxWeight = (weightList.map { $0.muscleMess }.max() ?? 0) + 2
            recentMuscleMess = weightList.last?.muscleMess ?? 0
            duration = muscleMessChartUseCase.getDateRange()
        }
    }
    
    
}
