//
//  WaterChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol WaterChartUseCaseProtocol {
    func fetchChartData() -> [WaterChartData]
    func getDateRange() -> String
}

struct WaterChartUseCase: WaterChartUseCaseProtocol {
    private let waterRepository: WaterRepositoryProtocol
    private let dateManager: DateManager = .shared
    private let healthManager: HealthInformationManager = HealthInformationManager()

    init(repository: WaterRepositoryProtocol = MockWaterRepository()) {
        self.waterRepository = repository
    }

    /// 차트 데이터 가지고 오기
    func fetchChartData() -> [WaterChartData] {
        let waterList = waterRepository.fetchWaterThisWeek()
        return calculatePercent(from: waterList)
    }

    /// 차트 요소 퍼센트 계산
    private func calculatePercent(from data: [WaterData]) -> [WaterChartData] {
        let values = data.map { $0.amount }
        let percents = HealthChartCalculator.calculateWaterPercent(for: values)

        return zip(data, percents).map { item, percent in
            WaterChartData(
                text: dateManager.weekdayString(from: item.date, style: .narrow),
                rawValue: item.amount,
                percent: percent,
                isToday: dateManager.isSameWeekday(item.date, Date())
            )
        }
    }
    
    /// 차트 기간 가지고오기
    func getDateRange() -> String {
        let list = waterRepository.fetchWaterThisWeek()
        let firstDate = list.first?.date ?? Date()
        let lastDate = list.last?.date ?? Date()
        
        return dateManager.formattedDateRange(from: firstDate, to: lastDate)
        
    }
}
