//
//  StepsRepository.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation
protocol StepsRepositoryProtocol {
    func fetchSteps(start: Date, end: Date) async throws -> [StepsData]
}

final class StepsRepository: StepsRepositoryProtocol {
    private let healthManager = HealthInformationManager()

    func fetchSteps(start: Date, end: Date) async throws -> [StepsData] {
        let stepsArray = try await healthManager.fetchStepCount(start: start, end: end)
        let distanceArray = try await healthManager.fetchWalkingRunningDistance(start: start, end: end)

        guard stepsArray.count == distanceArray.count else {
            throw HealthError.dataMismatch
        }
        
        var weekData: [StepsData] = []
        var currentDate = start
        
        for (index, steps) in stepsArray.enumerated() {
            let distance = distanceArray[index] / 1000
            weekData.append(StepsData(steps: steps, distance: distance, date: currentDate))
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return weekData
    }
    
}
final class MockStepsRepository: StepsRepositoryProtocol {
    let dateManager = DateManager.shared

    func fetchSteps(start: Date = Date(), end: Date = Date()) async throws-> [StepsData] {
        
        return [
            StepsData(steps: 8652, distance: 1.2, date: dateManager.getDate(from: "2025.04.13")), // 일
            StepsData(steps: 2042, distance: 1.2, date: dateManager.getDate(from: "2025.04.14")), // 월
            StepsData(steps: 10048, distance: 2.5, date: dateManager.getDate(from: "2025.04.15")), // 화
            StepsData(steps: 2842, distance: 1.2, date: dateManager.getDate(from: "2025.04.16")), // 수
            StepsData(steps: 5654, distance: 1.3, date: dateManager.getDate(from: "2025.04.17")), // 목
            StepsData(steps: 3000, distance: 0.5, date: dateManager.getDate(from: "2025.04.18")), // 금
            StepsData(steps: 3948, distance: 1.9, date: dateManager.getDate(from: "2025.04.19"))  // 토
        ]
    }
}
