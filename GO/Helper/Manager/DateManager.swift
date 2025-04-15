//
//  DateManager.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation

final class DateManager {
    
    static let shared = DateManager()
    private init() { }
    
    private let dateFormatter = DateFormatter()
    
    func getYearAndMonthString(currentDate: Date) -> [String] {
        
        dateFormatter.dateFormat = "YYYY MM dd"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        
        let date = dateFormatter.string(from: currentDate)
        let yearMonthDay = date.components(separatedBy: " ")
        
        return yearMonthDay
    }
    
    func getDateString(date: Date,
                       format: String = "YYYY.MM.dd") -> String {
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
   
}
