//
//  WaterChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol WaterChartUseCaseProtocol {
    func fetchChartData() -> [WaterChartData]
    func calculatePercent(from data: [WaterData]) -> [WaterChartData]
}

struct WaterChartUseCase: WaterChartUseCaseProtocol {
    private let repository: WaterRepositoryProtocol
    private let dateManager: DateManager = .shared
    private let healthManager: HealthInformationManager = HealthInformationManager()

    init(repository: WaterRepositoryProtocol = MockWaterRepository()) {
        self.repository = repository
    }

    func fetchChartData() -> [WaterChartData] {
        let waterList = repository.fetchWaterThisWeek()
        return calculatePercent(from: waterList)
    }

    func calculatePercent(from data: [WaterData]) -> [WaterChartData] {
        let values = data.map { $0.amount }
        let percents = healthManager.calculateWaterPercent(for: values)

        return zip(data, percents).map { item, percent in
            WaterChartData(
                text: dateManager.weekdayString(from: item.date, style: .narrow),
                rawValue: item.amount,
                percent: percent,
                isToday: dateManager.isSameWeekday(item.date, Date())
            )
        }
    }
}
