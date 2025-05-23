//
//  VitalInformationCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol VitalInformationCardViewModelProtocol: ViewModelAble {
    var heartRateChartDataList: [InformationChartData] { get }
    var sleepTimeChartDataList: [SleepTimeChartData] { get }
    var stepsChartDataList: [InformationChartData] { get }
    var waterChartDataList: [WaterChartData] { get }
    var duration: String { get }
    var todayHeartRate: Int { get }
    var todaySleepTime: Time { get }
    var todayWater: Double { get }
    var todaySteps: Int { get }
    var selectedInformationCard: VitalInformationType { get }
    var isAnimating: Bool { get }
}

final class VitalInformationCardViewModel: VitalInformationCardViewModelProtocol {
    
    @Published var heartRateChartDataList: [InformationChartData] = []
    @Published var sleepTimeChartDataList: [SleepTimeChartData] = []
    @Published var stepsChartDataList: [InformationChartData] = []
    @Published var waterChartDataList: [WaterChartData] = []
    
    @Published var duration: String = ""
    
    @Published var todayHeartRate: Int = 0
    @Published var todaySleepTime: Time = Time(hour: 0, minute: 0)
    @Published var todayWater: Double = 0
    @Published var todaySteps: Int = 0
    
    @Published var selectedInformationCard: VitalInformationType = .heartRate
    @Published var isAnimating: Bool = false
    
    private let heartRateChartUseCase: HeartRateChartUseCaseProtocol
    private let sleepTimeChartUseCase: SleepTimeChartUseCaseProtocol
    private let stepsChartUseCase: StepsChartUseCaseProtocol
    private let waterChartUseCase: WaterChartUseCaseProtocol
    
    enum Intent {
        case fetchAllData
        case fetchHeartRateData
        case fetchSleepTimeData
        case fetchStepsData
        case fetchWaterData
        case selectCard(VitalInformationType)
        case animationOn
    }
    
    init(heartRateChartUseCase: HeartRateChartUseCaseProtocol = HeartRateChartUseCase(),
         sleepTimeChartUseCase: SleepTimeChartUseCaseProtocol = SleepTimeChartUseCase(),
         stepsChartUseCase: StepsChartUseCaseProtocol = StepsChartUseCase(),
         waterChartUseCase: WaterChartUseCaseProtocol = WaterChartUseCase()) {
        self.heartRateChartUseCase = heartRateChartUseCase
        self.sleepTimeChartUseCase = sleepTimeChartUseCase
        self.stepsChartUseCase = stepsChartUseCase
        self.waterChartUseCase = waterChartUseCase
    }
    
    func action(_ intent: Intent) {
        switch intent {
        case .fetchAllData:
            Task {
                do {
                    let data = try await stepsChartUseCase.fetchChartData(for: .thisWeek)
                    
                    await MainActor.run {
                        stepsChartDataList = data
                        heartRateChartDataList = heartRateChartUseCase.fetchChartData()
                        sleepTimeChartDataList = sleepTimeChartUseCase.fetchChartData()
                        todayValue()
                        waterChartDataList = waterChartUseCase.fetchChartData()
                    }
                    
                } catch(let error) {
                    LogManager.errorLog(error)
                }
            }
            
            
        case .fetchHeartRateData:
            heartRateChartDataList = heartRateChartUseCase.fetchChartData()
            
        case .fetchSleepTimeData:
            sleepTimeChartDataList = sleepTimeChartUseCase.fetchChartData()
            
        case .fetchStepsData:
            Task {
                do {
                    stepsChartDataList = try await stepsChartUseCase.fetchChartData(for: .thisWeek)
                } catch(let error) {
                    LogManager.errorLog(error)
                }
            }
            
        case .fetchWaterData:
            waterChartDataList = waterChartUseCase.fetchChartData()
            
        case .selectCard(let type):
            if type == selectedInformationCard { return }
            switch type {
            case .heartRate:
                selectedInformationCard = .heartRate
            case .sleepTime:
                selectedInformationCard = .sleepTime
            case .steps:
                selectedInformationCard = .steps
            case .water:
                selectedInformationCard = .water
            }
            getDateRange()
            isAnimating = false
            
        case .animationOn:
            isAnimating = true
        }
    }
    
}

extension VitalInformationCardViewModel {
    
    /// 오늘 데이터의  rawValue만 추출하는 공통 함수
    private func extractTodayValue<T>(from list: [T]) -> T.RawValue where T: HasTodayValue {
        return list.first(where: { $0.isToday })?.rawValue ?? T.zeroValue
    }
    
    private func todayValue() {
        todayHeartRate = extractTodayValue(from: heartRateChartDataList)
        todaySleepTime = extractTodayValue(from: sleepTimeChartDataList)
        todaySteps = extractTodayValue(from: stepsChartDataList)
        todayWater = extractTodayValue(from: waterChartDataList)
    }
    
    private func getDateRange() {
        switch selectedInformationCard {
        case .heartRate:
            duration = heartRateChartUseCase.getDateRange()
        case .sleepTime:
            duration = sleepTimeChartUseCase.getDateRange()
        case .steps:
            duration = stepsChartUseCase.getDateRange()
        case .water:
            duration = waterChartUseCase.getDateRange()
        }
    }
    
}
