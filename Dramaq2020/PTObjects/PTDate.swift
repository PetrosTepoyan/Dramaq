//
//  PTDate.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 19/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTDate {
    func currentHourAndMinutes() -> String{
        let calendar = Calendar.current
        var hour     = String(calendar.component(.hour, from: Date()))
        var minutes  = String(calendar.component(.minute, from: Date()))
        
        if hour.count == 1 {
            hour = "0" + hour
        }
        if minutes.count == 1 {
            minutes = "0" + minutes
        }
        return ("\(hour):\(minutes)")
        
    }
    
    func currentDate() -> String{
        let calendar = Calendar.current
        let day      = String(calendar.component(.day, from: Date()))
        let month    = String(calendar.component(.month, from: Date()))
        let year     = String(calendar.component(.year, from: Date()))
        return "\(day)/\(month)/\(year)"
    }
    
    func convertStringToDate(string: String) -> Date {
        let dateString = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.date(from: dateString)!
    }
    
    func convertStringToTime(string: String) -> Date {
        let dateString = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.date(from: dateString)!
    }
}

