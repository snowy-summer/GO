//
//  StepsChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol StepsChartUseCaseProtocol {
    func fetchChartData(for period :StepsFetchPeriod) async throws -> [InformationChartData]
    func getDateRange() -> String
}

struct StepsChartUseCase: StepsChartUseCaseProtocol {
    private let stepsRepository: StepsRepositoryProtocol
    private let dateManager: DateManager = .shared
    
    init(repository: StepsRepositoryProtocol = StepsRepository()) {
        self.stepsRepository = repository
    }
    
    func fetchChartData(for period :StepsFetchPeriod) async throws -> [InformationChartData] {
        let (start, end) = dateManager.getDateRange(for: period)
        let stepsData = try await stepsRepository.fetchSteps(start: start, end: end)
        return calculatePercent(from: stepsData)
    }
    
    private func calculatePercent(from data: [StepsData]) -> [InformationChartData] {
        let values = data.map { $0.steps }
        let percents = HealthChartCalculator.calculateStepsPercent(for: values)
        
        return zip(data, percents).map { item, percent in
            InformationChartData(
                text: dateManager.weekdayString(from: item.date, style: .narrow),
                rawValue: item.steps,
                percent: percent,
                isToday: dateManager.isSameWeekday(item.date, Date()),
                distance: item.distance
            )
        }
    }
    /// 차트 기간 가지고오기
    func getDateRange() -> String {
        let (start, end) = dateManager.getDateRange(for: .thisWeek)
        
        return dateManager.formattedDateRange(from: start, to: end)
        
    }
}



