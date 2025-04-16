//
//  SleepTimeChartData.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct SleepTimeChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Time
    let percent: CGFloat
    let isToday: Bool
}
