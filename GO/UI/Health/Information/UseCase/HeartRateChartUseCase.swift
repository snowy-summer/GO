//
//  HeartRateChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol HeartRateChartUseCaseProtocol {
    func fetchChartData() -> [InformationChartData]
    func getDateRange() -> String
}

final class HeartRateChartUseCase: HeartRateChartUseCaseProtocol {
    private let heartRateRepository: HeartRateRepositoryProtocol = MockHeartRateRepository()
    private let dateManager: DateManager = DateManager.shared
    private let healthManager: HealthInformationManager = HealthInformationManager()
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    
        /// 심장 박동수 차트 데이터를 받아오기. Repository에서 이번주 심장 박동수 받아오고 퍼센트 계산을 진행
    func fetchChartData() -> [InformationChartData] {
        let heartRates = heartRateRepository.fetchHeartRateThisWeek()
        return calculatePercent(for: heartRates)
    }
    
    /// 심장 박동수 퍼센트 계산
    private func calculatePercent(for rates: [HeartRateData]) -> [InformationChartData] {
        
        let heartRateRawValue = rates.map { $0.heartRate }
        let percentList = healthManager.calculateHeartRatePercent(for: heartRateRawValue)
                                                                 
        
        let heartRateUIData = zip(rates, percentList).map { (rate, percent) in
            InformationChartData(text: dateManager.weekdayString(from: rate.date,
                                                                 style: .narrow),
                                 rawValue: rate.heartRate,
                                 percent: percent,
                                 isToday: dateManager.isSameWeekday(rate.date, Date()))
        }
        
        return heartRateUIData
    }
    
    /// 차트 기간 가지고오기
    func getDateRange() -> String {
        let list = heartRateRepository.fetchHeartRateThisWeek()
        let firstDate = list.first?.date ?? Date()
        let lastDate = list.last?.date ?? Date()
        
        return dateManager.formattedDateRange(from: firstDate, to: lastDate)
        
    }
    
    
}
