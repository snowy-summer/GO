//
//  InformationChartData.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct InformationChartData: Identifiable {
    let id = UUID()
    let text: String
    let rawValue: Int
    let percent: CGFloat
    let isToday: Bool
}
