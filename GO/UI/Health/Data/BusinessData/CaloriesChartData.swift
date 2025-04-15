//
//  CaloriesChartData.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct CaloriesChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Int
    let percent: CGFloat
}
