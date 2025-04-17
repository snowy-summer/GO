//
//  WeightChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

protocol WeightChartUseCaseProtocol {
    func fetchChartData() -> [WeightChartData]
}

final class WeightChartUseCase: WeightChartUseCaseProtocol {
    private let WeightRepository: WeightRepositoryProtocol = MockWeightRepository()
    private let dateManager: DateManager = DateManager.shared
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    
        /// 몸무게 데이터 받아오기
    func fetchChartData() -> [WeightChartData] {
        let weight = WeightRepository.fetchWeightRecentSeven()
        return convertToChartData(for: weight)
    }
    
    /// 몸무게 변환
    private func convertToChartData(for weight: [WeightData]) -> [WeightChartData] {
        
        var weightList: [WeightChartData] = []
        
        for data in weight {
            let chartData = WeightChartData(weight: data.weight, date: dateManager.getDateString(date: data.date, format: "yy.MM.dd"))
            weightList.append(chartData)
        }
        return weightList
    }
    
    
    
}
