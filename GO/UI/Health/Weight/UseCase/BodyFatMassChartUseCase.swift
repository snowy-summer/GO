//
//  BodyFatMassChartUseCase.swift
//  GO
//
//  Created by 최승범 on 4/19/25.
//

import Foundation

protocol BodyFatMassChartUseCaseProtocol {
    func fetchChartData() -> [WeightChartData]
    func getDateRange() -> String
    func getRecentBodyFatMassPercent(from dataList:[WeightChartData]) -> Double 
}

final class BodyFatMassChartUseCase: BodyFatMassChartUseCaseProtocol {
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
                                            muscleMass: data.muscleMass,
                                            bodyFatMass: data.bodyFatMass,
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
    
    func getRecentBodyFatMassPercent(from dataList:[WeightChartData]) -> Double {
        guard let bodyFatMass = dataList.last?.bodyFatMass,
              let weight = dataList.last?.weight else {
            LogManager.log("WeightChart데이터에 값이 존재하지 않습니다")
            return 0.0
        }
        
        return bodyFatMass / weight * 100
    }
    
}
