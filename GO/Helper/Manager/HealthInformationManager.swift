//
//  HealthInformationManager.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

struct HealthInformationManager {
    
    func calculateHeartRatePercent(for rates: [Int]) -> [CGFloat] {
        guard !rates.isEmpty else { return [] }
        
        let maxValue = 250
        
        return rates.map { CGFloat($0) / CGFloat(maxValue) }
    }
    
}
