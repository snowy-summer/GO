//
//  StepsChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol StepsChartUseCaseProtocol {
    func fetchChartData() -> [InformationChartData]
    func getDateRange() -> String
}

struct StepsChartUseCase: StepsChartUseCaseProtocol {
    private let stepsRepository: StepsRepositoryProtocol
    private let dateManager: DateManager = .shared
    private let healthManager: HealthInformationManager = HealthInformationManager()

    init(repository: StepsRepositoryProtocol = MockStepsRepository()) {
        self.stepsRepository = repository
    }

    func fetchChartData() -> [InformationChartData] {
        let steps = stepsRepository.fetchStepsThisWeek()
        return calculatePercent(from: steps)
    }

    /// 차트 요소 퍼센트 계산
    private func calculatePercent(from data: [StepsData]) -> [InformationChartData] {
        let values = data.map { $0.steps }
        let percents = healthManager.calculateStepsPercent(for: values)

        return zip(data, percents).map { item, percent in
            InformationChartData(
                text: dateManager.weekdayString(from: item.date, style: .narrow),
                rawValue: item.steps,
                percent: percent,
                isToday: dateManager.isSameWeekday(item.date, Date())
            )
        }
    }
    
    /// 차트 기간 가지고오기
    func getDateRange() -> String {
        let list = stepsRepository.fetchStepsThisWeek()
        let firstDate = list.first?.date ?? Date()
        let lastDate = list.last?.date ?? Date()
        
        return dateManager.formattedDateRange(from: firstDate, to: lastDate)
        
    }
    
}
