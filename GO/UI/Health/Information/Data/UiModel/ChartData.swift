//
//  ChartData.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

// 심박수, 걸음 차트용
struct InformationChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Int
    let percent: CGFloat
    let isToday: Bool
}

// 수면시간 차트용
struct SleepTimeChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Time
    let percent: CGFloat
    let isToday: Bool
}

struct WaterChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Double
    let percent: CGFloat
    let isToday: Bool
}
