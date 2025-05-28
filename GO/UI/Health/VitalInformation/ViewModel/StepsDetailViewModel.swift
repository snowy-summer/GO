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
    @Published var todayDistance: Double = 0.0
    @Published var todayPercent: Double = 0.0
    @Published var isAnimating: Bool = false
    @Published var averageStepsValue: Int = 0
    @Published var averageStepsPercent: Double = 0.0
    
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
                    let stepsData = try await stepsChartUseCase.fetchChartData(for: .thisWeek)
//                    todayValue()
                    let todayData = try await stepsChartUseCase.fetchChartData(for: .today).first
                    
                    await MainActor.run {
                        stepsChartDataList = stepsData
                        todaySteps = todayData?.rawValue ?? 0
                        // 당일 걸음수가 목표 걸음수를 넘는다면 리워드 지급
                        // 리워드가 지급이 되어있는지 확인, 지급이 안되어 있다면 지급
                        
                        todayDistance = todayData?.distance ?? 0.0
                        todayPercent = todayData?.percent ?? 0.0
                        duration = stepsChartUseCase.getDateRange()
                        averageSteps()
                    }
                    
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
    
    private func averageSteps() {
        averageStepsValue = stepsChartDataList.map { $0.rawValue }.reduce(0, +) / stepsChartDataList.count
        let maxSteps = stepsChartDataList.map { $0.rawValue }.max() ?? 0
        averageStepsPercent = Double(averageStepsValue) / Double(maxSteps)
    }
}
