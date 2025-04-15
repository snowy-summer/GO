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
    
    func getDate(from date : String, format: String = "YYYY.MM.dd") -> Date {
        dateFormatter.dateFormat = format
        guard let dateValue = dateFormatter.date(from: date) else {
            LogManager.log("String -> Date 변환 실패\nString을 확인하세요")
            return Date()
        }
        return dateValue
    }
    
    func weekdayString(from date: Date,
                       style: WeekdayStyle) -> String {
        dateFormatter.dateFormat = style.format
        return dateFormatter.string(from: date)
    }
   
    
}

enum WeekdayStyle {
    case short    // "Sun"
    case full     // "Sunday"
    case narrow   // "S"

    var format: String {
        switch self {
        case .short:
            return "E"
        case .full:
            return "EEEE"
        case .narrow:
            return "EEEEE"
        }
    }
}
