//
//  BurnCaloriesViewModel.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

final class BurnCaloriesViewModel: BurnCaloriesViewModelProtocol {
    
    @Published var calories: [Int] = []
    @Published var duration: String = "13 - 19 April 2025"
    
    @Published var todayCalories: Int = 0
    @Published var averageCalories: Int = 0
    
    
    
}

protocol BurnCaloriesViewModelProtocol: AnyObject, ObservableObject {

    var calories: [Int] { get }
    var duration: String { get }
    var todayCalories: Int { get }
    var averageCalories: Int { get }
}
