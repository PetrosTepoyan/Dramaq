//
//  CountingUtilities.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 21/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit

class CountingUtilities {
    
    func summation(from date1: Date? = nil, upto date2: Date? = nil, exchanged currency: CurrencyExchange? = nil) -> Double{

        
        
        
        if let date1 = date1, let date2 = date2 {
            let prices = ManagingRealm().retrieveRecords().flatMap { $0 }.filter {$0.date > date1 && $0.date < date2 }.map { $0.price }
            return Array(Set(prices)).reduce(0, +)
            
        } else {
            let prices = ManagingRealm().retrievePrices()
            return prices.reduce(0, +)
            
        }
        
        
    }
    
    func beingPricesToBase(currency: Currency) {
        currency.rates
    }

    
    
    func cnv(_ string: String) -> Date {
        return PTDate().convertStringToTime(string: string)
    }
    
    fileprivate func distributeForChunksSwitch(_ times: [String?], _ i: Int, _ chunks: inout [Array<Int>]) {
        if times[i] != nil {
            
            let j = cnv(times[i]!)
            
            switch j {
            case cnv("00:00")..<cnv("00:30"): chunks[0 ].append(i)
            case cnv("00:30")..<cnv("01:00"): chunks[1 ].append(i)
            case cnv("01:00")..<cnv("01:30"): chunks[2 ].append(i)
            case cnv("01:30")..<cnv("02:00"): chunks[3 ].append(i)
            case cnv("02:00")..<cnv("02:30"): chunks[4 ].append(i)
            case cnv("02:30")..<cnv("03:00"): chunks[5 ].append(i)
            case cnv("03:00")..<cnv("03:30"): chunks[6 ].append(i)
            case cnv("03:30")..<cnv("04:00"): chunks[7 ].append(i)
            case cnv("04:00")..<cnv("04:30"): chunks[8 ].append(i)
            case cnv("04:30")..<cnv("05:00"): chunks[9 ].append(i)
            case cnv("05:00")..<cnv("05:30"): chunks[10].append(i)
            case cnv("05:30")..<cnv("06:00"): chunks[11].append(i)
            case cnv("06:00")..<cnv("06:30"): chunks[12].append(i)
            case cnv("06:30")..<cnv("07:00"): chunks[13].append(i)
            case cnv("07:00")..<cnv("07:30"): chunks[14].append(i)
            case cnv("07:30")..<cnv("08:00"): chunks[15].append(i)
            case cnv("08:00")..<cnv("08:30"): chunks[16].append(i)
            case cnv("08:30")..<cnv("09:00"): chunks[17].append(i)
            case cnv("09:00")..<cnv("09:30"): chunks[18].append(i)
            case cnv("09:30")..<cnv("10:00"): chunks[19].append(i)
            case cnv("10:00")..<cnv("10:30"): chunks[20].append(i)
            case cnv("10:30")..<cnv("11:00"): chunks[21].append(i)
            case cnv("11:00")..<cnv("11:30"): chunks[22].append(i)
            case cnv("11:30")..<cnv("12:00"): chunks[23].append(i)
            case cnv("12:00")..<cnv("12:30"): chunks[24].append(i)
            case cnv("12:30")..<cnv("13:00"): chunks[25].append(i)
            case cnv("13:00")..<cnv("13:30"): chunks[26].append(i)
            case cnv("13:30")..<cnv("14:00"): chunks[27].append(i)
            case cnv("14:00")..<cnv("14:30"): chunks[28].append(i)
            case cnv("14:30")..<cnv("15:00"): chunks[29].append(i)
            case cnv("15:00")..<cnv("15:30"): chunks[30].append(i)
            case cnv("15:30")..<cnv("16:00"): chunks[31].append(i)
            case cnv("16:00")..<cnv("16:30"): chunks[32].append(i)
            case cnv("16:30")..<cnv("17:00"): chunks[33].append(i)
            case cnv("17:00")..<cnv("17:30"): chunks[34].append(i)
            case cnv("17:30")..<cnv("18:00"): chunks[35].append(i)
            case cnv("18:00")..<cnv("18:30"): chunks[36].append(i)
            case cnv("18:30")..<cnv("19:00"): chunks[37].append(i)
            case cnv("19:00")..<cnv("19:30"): chunks[38].append(i)
            case cnv("19:30")..<cnv("20:00"): chunks[39].append(i)
            case cnv("20:00")..<cnv("20:30"): chunks[40].append(i)
            case cnv("20:30")..<cnv("21:00"): chunks[41].append(i)
            case cnv("21:00")..<cnv("21:30"): chunks[42].append(i)
            case cnv("21:30")..<cnv("22:00"): chunks[43].append(i)
            case cnv("22:00")..<cnv("22:30"): chunks[44].append(i)
            case cnv("22:30")..<cnv("23:00"): chunks[45].append(i)
            case cnv("23:00")..<cnv("23:30"): chunks[46].append(i)
            case cnv("23:30")..<cnv("23:59"): chunks[47].append(i)
            default: break
                
            }
            
        }
    }
    
    func distributeForChunks() -> [[Int]]{
        
        let times: [String?] = ManagingRealm().retrieveTimes()
        var chunks: [[Int]] = (0...47).map { _ in [] }
        if !times.isEmpty {
            _ = (0...times.count-1).map { distributeForChunksSwitch(times, $0, &chunks) }
        }
        
        
        
        return chunks
    }

    func distributeForChunksCleaned() -> [[Int]]{
        
        return distributeForChunks().filter { $0.isEmpty == false }
    }
    
    func frequentRecords()  {
//        let indeces = distributeForChunksCleaned()
//        let records = ManagingRealm().retrieveRecords_isDeletedIncluded().flatMap { $0 }
//        
//        let index_place = indeces.map { $0.map { ($0, records[$0].place!.lowercased()) } }
//        let places = indeces.map { $0.map { (records[$0].place!.lowercased()) } }
//        var placeCountTuple = places.map { arr in arr.map { ($0, arr.numberOfOccurencies(of: $0)) } }
        
        
        
        
        // the output: ["SAS":[1,3,4], "Taxi":[2,5,6,7], "Cafe":[8,9], "Cafe#":[10,11]]
        
    }
    
    func repeatedPlaces() -> [(String, [Int])] { // works wrong
        var repeatedPlaces: [(String, [Int])] = []
        
        let places: [String?] = [] //coredata
        
        for i in 0...(places.count-1) {
            if places[i] != nil {
                var indecesOfThosePlaces: [Int] = []
                for j in places {
                    if places[i] == j {
                        indecesOfThosePlaces.append(i)
                        
                    }
                }
                
                repeatedPlaces.append((places[i]!, indecesOfThosePlaces))
            }
            
        }

        return repeatedPlaces
    }
    
    func frequentPlaces() -> [(String, [Int])] {
        let places = repeatedPlaces()
        var frequentPlaces: [(String, [Int])] = []
        
        for i in 0...(places.count-1) {
            if places[i].1.count != 1 {
                frequentPlaces.append(places[i])
            }
        }
        
        return frequentPlaces
    }
    
//
//    func summationForPlace(place: String) {
//
//    }
    
//    func summationfForCategory(category: Category){
//
//    }
//    func mostFrequentCategory() -> Category {
//        var category: Category
//
//        return category
//    }
    
    
}

extension Array where Element == String {
    func numberOfOccurencies(of str: String) -> Int { // must be generics
        
        let bits = self.map { $0 == str ? 1 : 0 }
        
        return bits.reduce(0, +)
        
    }
}
