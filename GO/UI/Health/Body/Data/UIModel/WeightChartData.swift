//
//  WeightChartData.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import Foundation

struct WeightChartData: Identifiable {
    let id = UUID()
    let weight: Double
    let muscleMass: Double
    let bodyFatMass: Double
    let date: String
}
