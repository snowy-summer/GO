//
//  HeartRateChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol HeartRateChartUseCaseProtocol {
    func fetchHeartRateChartData() -> [InformationChartData]
    func calculateHeartRatePercent(for rates: [HeartRateData]) -> [InformationChartData]
}

final class HeartRateChartUseCase: HeartRateChartUseCaseProtocol {
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    private let dateManager: DateManager = DateManager.shared
    private let healtManager: HealthInformationManager = HealthInformationManager()
    private let heartRateRepository: HeartRateRepositoryProtocol = MockHeartRateRepository()
    
        /// 심장 박동수 차트 데이터를 받아오기. Repository에서 이번주 심장 박동수 받아오고 퍼센트 계산을 진행
    func fetchHeartRateChartData() -> [InformationChartData] {
        let heartRates = heartRateRepository.fetchHeartRateThisWeek()
        return calculateHeartRatePercent(for: heartRates)
    }
    
    /// 심장 박동수 퍼센트 계산
    func calculateHeartRatePercent(for rates: [HeartRateData]) -> [InformationChartData] {
        
        let heartRateRawValue = rates.map { $0.heartRate }
        let percentList = healtManager.calculateHeartRatePercent(for: heartRateRawValue)
                                                                 
        
        let heartRateUIData = zip(rates, percentList).map { (rate, percent) in
            InformationChartData(text: dateManager.weekdayString(from: rate.date,
                                                                 style: .narrow),
                                 rawValue: rate.heartRate,
                                 percent: percent,
                                 isToday: dateManager.isSameWeekday(rate.date, Date()))
        }
        
        return heartRateUIData
    }
    
    
}
