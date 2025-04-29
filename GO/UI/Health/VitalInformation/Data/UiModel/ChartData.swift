//
//  ChartData.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

protocol HasTodayValue {
    associatedtype RawValue
    var isToday: Bool { get }
    var rawValue: RawValue { get }
    
    static var zeroValue: RawValue { get }
}

// 심박수, 걸음 차트용
struct InformationChartData: Identifiable, HasTodayValue {
    let id = UUID()
    let text: String
    let rawValue: Int
    let percent: CGFloat
    let isToday: Bool
    var distance: Double = 0
    
    static let zeroValue: Int = 0
}

// 수면시간 차트용
struct SleepTimeChartData: Identifiable, HasTodayValue {
    let id = UUID()
    let text: String
    let rawValue: Time
    let percent: CGFloat
    let isToday: Bool
    
    static let zeroValue: Time = Time(hour: 0, minute: 0)
}

struct WaterChartData: Identifiable, HasTodayValue {
    let id = UUID()
    let text: String
    let rawValue: Double
    let percent: CGFloat
    let isToday: Bool
    
    static let zeroValue: Double = 0.0
}
