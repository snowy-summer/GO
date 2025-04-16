//
//  FetchSleepTimeUseCase.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol FetchSleepTimeUseCaseProtocol {
    func fetchSleepTimeChartData() -> [SleepTimeChartData]
    func calculateSleepTimePercent(for rates: [SleepTimeData]) -> [SleepTimeChartData]
}

final class FetchSleepTimeUseCase: FetchSleepTimeUseCaseProtocol {
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    private let dateManager: DateManager = DateManager.shared
    private let healtManager: HealthInformationManager = HealthInformationManager()
    private let sleepTimeRepository: SleepTimeRepositoryProtocol = MockSleepTimeRepository()
    
    /// 수면 시간 차트 데이터를 받아오기. Repository에서 이번주 수면 시간 받아오고 퍼센트 계산을 진행
    func fetchSleepTimeChartData() -> [SleepTimeChartData] {
        let sleepTime = sleepTimeRepository.fetchSleepTimeThisWeek()
        return calculateSleepTimePercent(for: sleepTime)
    }
    
    /// 수면 시간 퍼센트 계산
    func calculateSleepTimePercent(for times: [SleepTimeData]) -> [SleepTimeChartData] {
        
        let timeRawValue = times.map { $0.time }
        let percentList = healtManager.calculateSleepTimePercent(for: timeRawValue)
        
        
        let timeUIData = zip(times, percentList).map { (time, percent) in
            SleepTimeChartData(text: dateManager.weekdayString(from: time.date,
                                                               style: .narrow),
                               rawValue: time.time,
                               percent: percent,
                               isToday: dateManager.isSameWeekday(time.date, Date()))
        }
        
        return timeUIData
    }
    
    
}
