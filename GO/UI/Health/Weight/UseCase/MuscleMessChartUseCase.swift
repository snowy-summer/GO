//
//  MuscleMessChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/18/25.
//

import Foundation

protocol MuscleMessChartUseCaseProtocol {
    func fetchChartData() -> [WeightChartData]
    func getDateRange() -> String
}

final class MuscleMessChartUseCase: MuscleMessChartUseCaseProtocol {
    private let WeightRepository: WeightRepositoryProtocol = MockWeightRepository()
    private let dateManager: DateManager = DateManager.shared
    private let userData: UserDefaultsManager = UserDefaultsManager.shared
    
    /// 골격근량 데이터 받아오기
    func fetchChartData() -> [WeightChartData] {
        let weight = WeightRepository.fetchWeightRecentSeven()
        return convertToChartData(for: weight)
    }
    
    /// 차트 데이터 변환
    private func convertToChartData(for weight: [WeightData]) -> [WeightChartData] {
        
        var weightList: [WeightChartData] = []
        
        for data in weight {
            let chartData = WeightChartData(weight: data.weight,
                                            muscleMess: data.muscleMess,
                                            bodyFatMess: data.bodyFatMess,
                                            date: dateManager.getDateString(date: data.date, format: "yy.MM.dd"))
            weightList.append(chartData)
        }
        return weightList
    }
    
    func getDateRange() -> String {
        let list = WeightRepository.fetchWeightRecentSeven()
        let firstDate = list.first?.date ?? Date()
        let lastDate = list.last?.date ?? Date()
        
        return dateManager.formattedDateRange(from: firstDate, to: lastDate)
        
    }
    
}
