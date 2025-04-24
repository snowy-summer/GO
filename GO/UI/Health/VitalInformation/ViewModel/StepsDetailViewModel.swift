//
//  StepsDetailViewModel.swift
//  GO
//
//  Created by 최승범 on 4/24/25.
//

import Foundation

protocol StepsDetailViewModelProtocol: ViewModelAble {
    var stepsChartDataList: [InformationChartData] { get }
    var duration: String { get }
    var todaySteps: Int  { get }
    var isAnimating: Bool { get }
}

final class StepsDetailViewModel: StepsDetailViewModelProtocol {
    
    @Published var stepsChartDataList: [InformationChartData] = []
    
    @Published var duration: String = ""
    
    @Published var todaySteps: Int = 0
    
    @Published var isAnimating: Bool = false
    
    private let stepsChartUseCase: StepsChartUseCaseProtocol
    
    enum Intent {
        case fetchAllData
        case fetchStepsData
        case animationOn
    }
    
    init(stepsChartUseCase: StepsChartUseCaseProtocol = StepsChartUseCase()) {
        self.stepsChartUseCase = stepsChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchAllData:
            stepsChartDataList = stepsChartUseCase.fetchChartData()
            
            todayValue()
            
        case .fetchStepsData:
            stepsChartDataList = stepsChartUseCase.fetchChartData()
            
        case .animationOn:
            isAnimating = true
        }
    }
    
}

extension StepsDetailViewModel {
    
    /// 오늘 데이터의  rawValue만 추출하는 공통 함수
    private func extractTodayValue<T>(from list: [T]) -> T.RawValue where T: HasTodayValue {
        return list.first(where: { $0.isToday })?.rawValue ?? T.zeroValue
    }
    
    private func todayValue() {
        todaySteps = extractTodayValue(from: stepsChartDataList)
    }
    
    private func getDateRange() {
        duration = stepsChartUseCase.getDateRange()
    }
    
}
