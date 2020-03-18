//
//  Date+Extension.swift
//  MoneyTrackerNotFinal
//
//  Created by Петрос Тепоян on 13/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

extension Date {
    
    func getDay() -> String {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let formattedDate = format.string(from: self)
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
    
    
}
