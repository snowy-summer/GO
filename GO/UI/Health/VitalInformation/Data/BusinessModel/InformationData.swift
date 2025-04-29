//
//  InformationData.swift
//  GO
//
//  Created by 최승범 on 4/16/25.
//

import Foundation

struct HeartRateData {
    let heartRate: Int
    let date: Date
}

struct SleepTimeData {
    let time: Time
    let date: Date
}

struct StepsData {
    let steps: Int
    let distance: Double
    let date: Date
}

struct WaterData {
    let amount: Double
    let date: Date
}

struct Time {
    let hour: Int
    let minute: Int
    let second: Int = 0
}
