//
//  MuscleMassChartViewModel.swift
//  GO
//
//  Created by 최승범 on 4/18/25.
//

import Foundation

protocol MuscleMassChartViewModelProtocol: ViewModelAble {
    var weightList: [WeightChartData] { get }
    var duration: String { get }
    var recentMuscleMass: Double { get }
    var goalMuscleMass: Double { get }
    var minWeight: Double { get }
    var maxWeight: Double { get }
}


final class MuscleMassChartViewModel: MuscleMassChartViewModelProtocol {
    
    @Published var weightList: [WeightChartData] = []
    @Published var duration: String = ""
    
    @Published var recentMuscleMass: Double = 0
    @Published var goalMuscleMass: Double = UserDefaultsManager.shared.weightGoal
    
    var minWeight: Double = 0
    var maxWeight: Double = 0
    
    
    private let muscleMessChartUseCase: MuscleMessChartUseCaseProtocol
    
    enum Intent {
        case fetchMuscleMass
    }
    
    init(muscleMessChartUseCase: MuscleMessChartUseCaseProtocol = MuscleMessChartUseCase()) {
        self.muscleMessChartUseCase = muscleMessChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchMuscleMass:
            weightList = muscleMessChartUseCase.fetchChartData()
            minWeight = (weightList.map { $0.muscleMass }.min() ?? 0) - 2
            maxWeight = (weightList.map { $0.muscleMass }.max() ?? 0) + 2
            recentMuscleMass = weightList.last?.muscleMass ?? 0
            duration = muscleMessChartUseCase.getDateRange()
        }
    }
    
    
}
