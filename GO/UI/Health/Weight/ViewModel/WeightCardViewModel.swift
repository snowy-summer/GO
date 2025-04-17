//
//  WeightCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol WeightCardViewModelProtocol: ViewModelAble {
    var weightList: [WeightChartData] { get }
    var duration: String { get }
    var recentWeight: Double { get }
    var goalWeight: Double { get }
}

final class WeightCardViewModel: WeightCardViewModelProtocol {
    
    @Published var weightList: [WeightChartData] = []
    @Published var duration: String = ""
    
    @Published var recentWeight: Double = 0
    @Published var goalWeight: Double = UserDefaultsManager.shared.weightGoal
    
    var minWeight: Double = 0
    var maxWeight: Double = 0
    
    private let weightChartUseCase: WeightChartUseCaseProtocol
    
    enum Intent {
        case fetchWeight
    }
    
    init(weightChartUseCase: WeightChartUseCaseProtocol = WeightChartUseCase()) {
        self.weightChartUseCase = weightChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchWeight:
            weightList = weightChartUseCase.fetchChartData()
            minWeight = (weightList.map { $0.weight }.min() ?? 0) - 2
            maxWeight = (weightList.map { $0.weight }.max() ?? 0) + 2
            duration = weightChartUseCase.getDateRange()
        }
    }
    
}

