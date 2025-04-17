//
//  InformationCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

protocol InformationCardViewModelProtocol: ViewModelAble {
    var heartRateChartDataList: [InformationChartData] { get }
    var sleepTimeChartDataList: [SleepTimeChartData] { get }
    var stepsChartDataList: [InformationChartData] { get }
    var waterChartDataList: [WaterChartData] { get }
    var duration: String { get }
    var todayHeartRate: Int { get }
    var todaySleepTime: Time { get }
    var todayWater: Double { get }
    var todaySteps: Int { get }
    var selectedInformationCard: InformationCardType { get }
    var isAnimating: Bool { get }
}

final class InformationCardViewModel: InformationCardViewModelProtocol {
    
    @Published var heartRateChartDataList: [InformationChartData] = []
    @Published var sleepTimeChartDataList: [SleepTimeChartData] = []
    @Published var stepsChartDataList: [InformationChartData] = []
    @Published var waterChartDataList: [WaterChartData] = []
    
    @Published var duration: String = ""
    
    @Published var todayHeartRate: Int = 0
    @Published var todaySleepTime: Time = Time(hour: 0, minute: 0)
    @Published var todayWater: Double = 0
    @Published var todaySteps: Int = 0
    
    @Published var selectedInformationCard: InformationCardType = .heartRate
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
        case selectCard(InformationCardType)
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
            heartRateChartDataList = heartRateChartUseCase.fetchChartData()
            sleepTimeChartDataList = sleepTimeChartUseCase.fetchChartData()
            stepsChartDataList = stepsChartUseCase.fetchChartData()
            waterChartDataList = waterChartUseCase.fetchChartData()
            
            todayValue()
            
        case .fetchHeartRateData:
            heartRateChartDataList = heartRateChartUseCase.fetchChartData()
            
        case .fetchSleepTimeData:
            sleepTimeChartDataList = sleepTimeChartUseCase.fetchChartData()
            
        case .fetchStepsData:
            stepsChartDataList = stepsChartUseCase.fetchChartData()
            
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
            isAnimating = false
            
        case .animationOn:
            isAnimating = true
        }
    }
    
}

extension InformationCardViewModel {
    
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
