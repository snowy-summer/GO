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
    
    /// 년, 월, 일 추출
    func getYearAndMonthString(currentDate: Date) -> [String] {
        
        dateFormatter.dateFormat = "YYYY MM dd"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        
        let date = dateFormatter.string(from: currentDate)
        let yearMonthDay = date.components(separatedBy: " ")
        
        return yearMonthDay
    }
    
    ///Date -> String
    func getDateString(date: Date,
                       format: String = "YYYY.MM.dd") -> String {
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    /// String -> Date
    func getDate(from date : String, format: String = "YYYY.MM.dd") -> Date {
        dateFormatter.dateFormat = format
        guard let dateValue = dateFormatter.date(from: date) else {
            LogManager.log("String -> Date 변환 실패\nString을 확인하세요")
            return Date()
        }
        return dateValue
    }
    
    /// Date로 날짜 글자 추출
    func weekdayString(from date: Date,
                       style: WeekdayStyle) -> String {
        dateFormatter.dateFormat = style.format
        return dateFormatter.string(from: date)
    }
    
    /// 같은 요일 판별
    func isSameWeekday(_ day1: Date, _ day2: Date) -> Bool {
        dateFormatter.dateFormat = WeekdayStyle.full.format
        return dateFormatter.string(from: day1) == dateFormatter.string(from: day2)
    }
   
    func formattedDateRange(from startDate: Date, to endDate: Date) -> String {
        dateFormatter.dateFormat = "dd"
        let startDay = dateFormatter.string(from: startDate)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let endFull = dateFormatter.string(from: endDate)
        return "\(startDay) - \(endFull)"
    }
    
    /// 기간을 설정해서 날짜 추출하기
    func getDateRange(for period: StepsFetchPeriod) -> (Date, Date) {
        let calendar = Calendar.current
        let now = Date()
        
        switch period {
        case .today:
            let startOfDay = calendar.startOfDay(for: now)
            return (startOfDay, now)
            
        case .thisWeek:
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) ?? now
            return (startOfWeek, now)
            
        case .thisMonth:
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)) ?? now
            return (startOfMonth, now)
        }
    }
    
}

enum StepsFetchPeriod {
    case today
    case thisWeek
    case thisMonth
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
