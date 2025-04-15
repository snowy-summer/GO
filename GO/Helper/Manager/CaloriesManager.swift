//
//  CaloriesManager.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

final class CaloriesManager {
    
    func calculateCaloriesPercent(for calories: [Int],
                                  goal: Int) -> [CGFloat] {
        guard !calories.isEmpty else { return [] }
        
        let hasOverGoal = calories.contains { $0 > goal }
        let maxValue = hasOverGoal ? (calories.max()! + 200) : (goal + 200)
        
        return calories.map { CGFloat($0) / CGFloat(maxValue) }
    }
    
}
