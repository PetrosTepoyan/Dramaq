//
//  Balance.swift
//  Dramaq2020
//

//  Created by Петрос Тепоян on 16/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit


protocol Accounting {
    
}

class Balance : Accounting {
    
    func overall() ->  Double {
        let incomes = ManagingRealm()
            .retrieveIncomes_flat()
            .map { $0.price ?? 0.0 }
            .reduce(0.0, +)
        
        let records = ManagingRealm()
            .retrieveRecords_flat()
            .map { $0.price ?? 0.0}
            .reduce(0.0, +)
        
        return incomes - records
    }
    
    func overPeriod(from date1: Date, to date2: Date) -> Double {
        let incomes = ManagingRealm()
            .retrieveIncomes_flat()
            .filter { $0.date >= date1 && $0.date <= date2 }
            .map { $0.price ?? 0.0 }
            .reduce(0.0, +)
        
        let records = ManagingRealm()
            .retrieveRecords_flat()
            .filter { $0.date >= date1 && $0.date <= date2 }
            .map { $0.price ?? 0.0}
            .reduce(0.0, +)
        
        return incomes - records
    }
    
    func moneyPerDayFor31Days_StartingNow() -> Double {
        let day:TimeInterval = 24 * 60.0 * 60
        let endDate = Date(timeInterval: day * 31, since: Date())
        let balance = overall()
        
        guard balance > 0 else { return 0 }
        
        return round(balance / 31 * 10) / 10
    }
    
    func moneyLeftToSpendToday() -> Double {
        let moneyForToday = moneyPerDayFor31Days_StartingNow()
        let moneySpent = CountingUtilities().summationForToday()
        
        let ret = round((moneyForToday - moneySpent)*10)/10
        guard ret > 0 else { return 0 }
        return ret
    }
    
    func moneyLeftToSpendTillTheEndOfTheMonth() -> Double {
        
        let records = ManagingRealm()
        .retrieveRecords_flat()
        .map { $0.price ?? 0.0}
        .reduce(0.0, +)
        
        let balance = overall()
        guard balance > 0 else { return 0 }
        let currentDay = Calendar(identifier: .gregorian).component(.day, from: Date())
        let daysLeft = Date().daysInMonth() - currentDay
        
        
        let moneyLeftToSpendForEachDayTillTheEndOfTheMonth = balance / Double(daysLeft)
        
        print("Money left to spend for each day", moneyLeftToSpendForEachDayTillTheEndOfTheMonth)
        print("Money spent today", records)
        return round(moneyLeftToSpendForEachDayTillTheEndOfTheMonth - records)
    }
    
//    func moneyPerDay() -> Double {
//        let balance = overPeriod(from: Date(), to: <#T##Date#>)
//        return 0.0
//    }
//    
//    
//    
    // MARK: - DueTheDay Approach
    
    
    
    // MARK: - RegularSalary Approach
    
    
    
    
}
