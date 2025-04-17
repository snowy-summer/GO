//
//  StepsChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol StepsChartUseCaseProtocol {
    func fetchChartData() -> [InformationChartData]
}

struct StepsChartUseCase: StepsChartUseCaseProtocol {
    private let repository: StepsRepositoryProtocol
    private let dateManager: DateManager = .shared
    private let healthManager: HealthInformationManager = HealthInformationManager()

    init(repository: StepsRepositoryProtocol = MockStepsRepository()) {
        self.repository = repository
    }

    func fetchChartData() -> [InformationChartData] {
        let steps = repository.fetchStepsThisWeek()
        return calculatePercent(from: steps)
    }

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
}
