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
        case .fetchAllData, .fetchStepsData:
            Task {
                do {
                    stepsChartDataList = try await stepsChartUseCase.fetchChartData(for: .thisWeek)
//                    todayValue()
                    todaySteps = try await stepsChartUseCase.fetchChartData(for: .today).first?.rawValue ?? 0
                    duration = stepsChartUseCase.getDateRange()
                } catch {
                    LogManager.log("👟 걸음 데이터를 가지고 오기 실패")
                }
            }
            
        case .animationOn:
            isAnimating = true
        }
    }
}

extension StepsDetailViewModel {
    
//    private func extractTodayValue<T>(from list: [T]) -> T.RawValue where T: HasTodayValue {
//        return list.first(where: { $0.isToday })?.rawValue ?? T.zeroValue
//    }
//    
//    private func todayValue() {
//        todaySteps = extractTodayValue(from: stepsChartDataList)
//    }
    
//    private func getDateRange() {
//        duration = stepsChartUseCase.getDateRange()
//    }
}
