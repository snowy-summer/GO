//
//  InformationCardViewModel.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

final class InformationCardViewModel: InformationCardViewModelProtocol {
    
    
    @Published var informationChartDataList: [InformationChartData] = []
    @Published var duration: String = "13 - 19 April 2025"
    
    @Published var todayHeartRate: Int = 0
    @Published var todaySleepTime: Time = Time(hour: 0, minute: 0)
    @Published var todayWater: Float = 0
    @Published var todaySteps: Int = 0
    
}

protocol InformationCardViewModelProtocol: AnyObject, ObservableObject {

    var informationChartDataList: [InformationChartData] { get }
    var duration: String { get }
    var todayHeartRate: Int { get }
    var todaySleepTime: Time { get }
    var todayWater: Float { get }
    var todaySteps: Int { get }
}

struct Time {
    var hour: Int
    var minute: Int
    var second: Int = 0
}
