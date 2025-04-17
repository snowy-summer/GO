//
//  BurnCaloriesChartData.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct BurnCaloriesChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Int
    let percent: CGFloat
    let isToday: Bool
}

struct FoodCaloriesChartData: Identifiable {
    let id = UUID()
    let rawValue: Int
    let percent: CGFloat
    let goal: Int
}
