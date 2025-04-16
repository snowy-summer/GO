//
//  SleepRepository.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol SleepTimeRepositoryProtocol {
    func fetchSleepTimeThisWeek() -> [SleepTimeData]
}

final class MockSleepTimeRepository: SleepTimeRepositoryProtocol {
    func fetchSleepTimeThisWeek() -> [SleepTimeData] {
        let dateManager = DateManager.shared
        return [
            SleepTimeData(time: Time(hour: 7, minute: 28), date: dateManager.getDate(from: "2025.04.13")), // 일
            SleepTimeData(time: Time(hour: 8, minute: 26), date: dateManager.getDate(from: "2025.04.14")), // 월
            SleepTimeData(time: Time(hour: 6, minute: 32), date: dateManager.getDate(from: "2025.04.15")), // 화
            SleepTimeData(time: Time(hour: 3, minute: 48), date: dateManager.getDate(from: "2025.04.16")), // 수
            SleepTimeData(time: Time(hour: 6, minute: 12), date: dateManager.getDate(from: "2025.04.17")), // 목
            SleepTimeData(time: Time(hour: 5, minute: 28), date: dateManager.getDate(from: "2025.04.18")), // 금
            SleepTimeData(time: Time(hour: 7, minute: 53), date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
