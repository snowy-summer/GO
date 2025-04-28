//
//  HealthChartCalculator.swift
//  GO
//
//  Created by 최승범 on 4/28/25.
//

import Foundation

struct HealthChartCalculator {
    //MARK: - 퍼센트 계산
    
    static func calculateHeartRatePercent(for rates: [Int]) -> [CGFloat] {
        guard !rates.isEmpty else { return [] }
        
        let maxValue = 250
        
        return rates.map { CGFloat($0) / CGFloat(maxValue) }
    }
    
    static func calculateSleepTimePercent(for time: [Time]) -> [CGFloat] {
        guard !time.isEmpty else { return [] }
        
        let maxValue = 1440 // 24 * 60
        
        
        return time.map { CGFloat($0.hour * 60 + $0.minute) / CGFloat(maxValue) }
    }
    
    static func calculateStepsPercent(for steps: [Int]) -> [CGFloat] {
        guard !steps.isEmpty else { return [] }
        
        let maxValue = steps.max()! + 2000
        
        
        return steps.map { CGFloat($0) / CGFloat(maxValue) }
    }
    
    static func calculateWaterPercent(for amount: [Double]) -> [CGFloat] {
        guard !amount.isEmpty else { return [] }
        
        let maxValue = ceil(amount.max()!)
        
        
        return amount.map { CGFloat($0) / CGFloat(maxValue) }
    }
}
