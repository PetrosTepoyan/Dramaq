//
//  Date+Extension.swift
//  MoneyTrackerNotFinal
//
//  Created by Петрос Тепоян on 13/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import RealmSwift

extension Date {
    
    func getDay() -> String? {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let formattedDate: String? = format.string(from: self)
        return formattedDate
        
    }
    
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let formattedDate = format.string(from: self)
        return formattedDate
        
    }
    
    func getDayExp() -> String {
        let format = DateFormatter()
        format.dateFormat = "E, d MMM"
        let formattedDate = format.string(from: self)
        return formattedDate
    }
    
    func getDayExpExp() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEEE, MMMM d, yyyy"
        let formattedDate = format.string(from: self)
        return formattedDate
    }
    
    func getDayExpExpForDateCheck() -> String {
        let format = DateFormatter()
        format.dateFormat = "d MMMM"
        let formattedDate = format.string(from: self)
        return formattedDate
    }
    
    func getDayExpExpForDateCheck2() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEE, d MMM"
        let formattedDate = format.string(from: self)
        return formattedDate
    }
    
    
}

extension TimeInterval {
    static func getTimeInterval(str: String) -> RealmOptional<Double> {
        switch str {
            case "Daily"  : return RealmOptional<Double>(60 * 60 * 24)
            case "Weekly" : return RealmOptional<Double>(60 * 60 * 24 * 7)
            case "Monthly": return RealmOptional<Double>(60 * 60 * 24 * 7 * 31)
            case "Annualy": return RealmOptional<Double>(60 * 60 * 24 * 7 * 31 * 12)
            default       : return RealmOptional<Double>(nil)
        }
    }
}

extension Date {

    func daysInMonth(_ monthNumber: Int? = nil, _ year: Int? = nil) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year ?? Calendar.current.component(.year,  from: self)
        dateComponents.month = monthNumber ?? Calendar.current.component(.month,  from: self)
        if
            let d = Calendar.current.date(from: dateComponents),
            let interval = Calendar.current.dateInterval(of: .month, for: d),
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day
        { return days } else { return -1 }
    }
    
    func numberOfCurrentDayInMonth() -> Int {
        return Calendar.current.component(.day,  from: self)
    }
    
    func numberOfCurrentDayInWeek() -> Int {
        return Calendar.current.component(.weekday,  from: self)
    }

}
