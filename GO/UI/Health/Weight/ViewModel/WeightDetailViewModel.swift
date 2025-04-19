//
//  WeightDetailViewModel.swift
//  GO
//
//  Created by 최승범 on 4/19/25.
//

import Foundation

protocol WeightDetailViewModelProtocol: ViewModelAble {
    var weightList: [WeightChartData] { get }
    var day: String { get }
    
    var recentWeight: Double { get }
    var recentWeightState: BodyState { get }
    
    var recentMuscleMass: Double { get }
    var recentMuscleMassState: BodyState { get }
    
    var recentBodyFatPercent: Double { get }
    var recentBodyFatState: BodyState { get }
    
    var isExpanded: Bool { get }
}

final class WeightDetailViewModel: WeightDetailViewModelProtocol {
    
    var weightList: [WeightChartData] = []
    @Published var day: String = ""
    
    @Published var recentWeight: Double = 0
    var recentWeightState: BodyState = .normal
    
    @Published var recentMuscleMass: Double = 0
    var recentMuscleMassState: BodyState = .normal
    
    @Published var recentBodyFatPercent: Double = 0
    var recentBodyFatState: BodyState = .normal
    
    @Published var isExpanded: Bool = false
    
    private let weightDetailUseCase: WeightDetailUseCaseProtocol
    
    enum Intent {
        case fetchData
    }
    
    init(weightDetailUseCase: WeightDetailUseCaseProtocol = WeightDetailUseCase()) {
        self.weightDetailUseCase = weightDetailUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchData:
            weightList = weightDetailUseCase.fetchChartData()
            guard let lastData = weightList.last else {
                LogManager.log("데이터가 없습니다.")
                return
            }
            recentWeight = lastData.weight
            recentWeightState = weightDetailUseCase.evaluateWeightState(data: lastData)
            
            recentMuscleMass = lastData.muscleMass
            recentMuscleMassState = weightDetailUseCase.evaluateMuscleMassState(data: lastData)
            
            recentBodyFatPercent = lastData.bodyFatMass / lastData.weight * 100
            recentBodyFatState = weightDetailUseCase.evaluateBodyFatState(data: lastData)
            
            day = lastData.date
           
        }
    }
    
}

