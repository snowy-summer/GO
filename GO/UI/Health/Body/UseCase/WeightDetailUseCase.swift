//
//  WeightDetailUseCase.swift
//  GO
//
//  Created by 최승범 on 4/19/25.
//

import Foundation

protocol WeightDetailUseCaseProtocol {
    func fetchChartData() -> [WeightChartData]
    func evaluateWeightState(data: WeightChartData) -> ValueState
    func evaluateMuscleMassState(data: WeightChartData) -> ValueState
    func evaluateBodyFatState(data: WeightChartData) -> ValueState
}

final class WeightDetailUseCase: WeightDetailUseCaseProtocol {
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
            let chartData = WeightChartData(weight: data.weight,
                                            muscleMass: data.muscleMass,
                                            bodyFatMass: data.bodyFatMass,
                                            date: dateManager.getDateString(date: data.date, format: "yy.MM.dd"))
            weightList.append(chartData)
        }
        return weightList
    }
    
    ///  키, 정보에 따라서 적정 체중 판단 -> Over, Normal, Under
    func evaluateWeightState(data: WeightChartData) -> ValueState {
        let height = userData.userHeight
        let weight = data.weight
        
        guard height > 0 else { return .normal } // 예외 처리
        
        let heightMeter = height / 100.0
        let bmi = weight / (heightMeter * heightMeter)
        
        switch bmi {
        case ..<18.5:
            return .under
        case 18.5...24.9:
            return .normal
        default:
            return .over
        }
    }
    
    ///  키, 몸무게에 따라서 적정 근육량 판단 -> Over, Normal, Under
    
    func evaluateMuscleMassState(data: WeightChartData) -> ValueState {
        let weight = data.weight
        let muscleMass = data.muscleMass
        let gender = Gender(rawValue: userData.gender) ?? .male
        
        guard weight > 0 else { return .normal }
        
        let ratio = muscleMass / weight
        
        switch gender {
        case .male:
            switch ratio {
            case ..<0.33:
                return .under
            case 0.33...0.39:
                return .normal
            default:
                return .over
            }
        case .female:
            switch ratio {
            case ..<0.24:
                return .under
            case 0.24...0.30:
                return .normal
            default:
                return .over
            }
        }
    }
    ///  키, 몸무게에 따라서 적정 체지방량 판단 -> Over, Normal, Under
    func evaluateBodyFatState(data: WeightChartData) -> ValueState {
        let weight = data.weight
        let bodyFatMass = data.bodyFatMass
        let bodyFatPercent = (bodyFatMass / weight) * 100
        let gender = Gender(rawValue: userData.gender) ?? .male
        
        switch gender {
        case .male:
            switch bodyFatPercent {
            case ..<10:
                return .under
            case 10...20:
                return .normal
            default:
                return .over
            }
        case .female:
            switch bodyFatPercent {
            case ..<18:
                return .under
            case 18...28:
                return .normal
            default:
                return .over
            }
        }
    }
    
}
