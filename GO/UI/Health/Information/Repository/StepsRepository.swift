//
//  StepsRepository.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation
protocol StepsRepositoryProtocol {
    func fetchStepsThisWeek() -> [StepsData]
}

final class MockStepsRepository: StepsRepositoryProtocol {
    func fetchStepsThisWeek() -> [StepsData] {
        let dateManager = DateManager.shared
        return [
            StepsData(steps: 8652, date: dateManager.getDate(from: "2025.04.13")), // 일
            StepsData(steps: 2042, date: dateManager.getDate(from: "2025.04.14")), // 월
            StepsData(steps: 10048, date: dateManager.getDate(from: "2025.04.15")), // 화
            StepsData(steps: 2842, date: dateManager.getDate(from: "2025.04.16")), // 수
            StepsData(steps: 5654, date: dateManager.getDate(from: "2025.04.17")), // 목
            StepsData(steps: 3000, date: dateManager.getDate(from: "2025.04.18")), // 금
            StepsData(steps: 3948, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
