//
//  ManagingReal.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 6/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import RealmSwift

class ManagingRealm {
    
    var realm: Realm = {
        return try! Realm()
    }()
    
    var records: [[Record]] = []
    
    func retrieveRecords_isDeletedIncluded() -> [[Record]] {
        let realmRecords = realm.objects(RealmRecord.self).sorted(by: { $0.date > $1.date})

        
        var recordsFlattened = realmRecords.map { Record(id: $0.id,
                                                         price: $0.price,
                                                         place: $0.place,
                                                         date: $0.date,
                                                         category: Category(rawValue: $0.category)!,
                                                         keywords: $0.keywords?.components(separatedBy: ";"),
                                                         currency: $0.currency)
            
        }
        
        let dateCounts = Set(recordsFlattened.map {$0.date}).count
        for _ in 0...dateCounts{
            let nestedArr = recordsFlattened.filter {$0.date.getDay() == recordsFlattened[0].date.getDay()}
            records.append(nestedArr)

            recordsFlattened.removeAll( where: { $0.date.getDay() == nestedArr[0].date.getDay() } )
        }

        records = records.filter { $0.isEmpty == false }
        
        return records
    }
    
    
    
    
    
    func unflattenRecords(flatRecords: [Record]) -> [[Record]]{
        var recordsFlattened = flatRecords
        var multiRecords: [[Record]] = []
        
        let dateCounts = Set(recordsFlattened.map {$0.date}).count
        for _ in 0...dateCounts{
            let nestedArr = recordsFlattened.filter {$0.date.getDay() == recordsFlattened[0].date.getDay()}
            multiRecords.append(nestedArr)

            recordsFlattened.removeAll( where: { $0.date.getDay() == nestedArr[0].date.getDay() } )
        }
        return multiRecords.filter { $0.isEmpty == false }
    }
    
    func retrievePrices() -> [Double] {
        let realmRecords = realm.objects(RealmRecord.self).filter{$0.isDeleted == false }.sorted(by: { $0.date > $1.date})
        return realmRecords.map { $0.price }
    }
    
    func retrievePricesWithCurrency() -> [(Double, String)] {
        let realmRecords = realm.objects(RealmRecord.self).filter{$0.isDeleted == false }.sorted(by: { $0.date > $1.date})
        let tuples = realmRecords.map { ($0.price, $0.currency) }
//        return tuples.map { ($0.0, String(Array($0.1!)[4...6])) }
        return [(1, "No")]
    }
    
    func retrieveTimes() -> [String] {
        let realmRecords = realm.objects(RealmRecord.self).filter{$0.isDeleted == false }.sorted(by: { $0.date > $1.date})
        return realmRecords.map { ($0.date.getTime()) }
    }
    
    
    var entries: [[Entry]] = []
    
    func retrieveRecords_flat() -> [Record] {
        let realmRecords = realm.objects(RealmRecord.self).filter{$0.isDeleted == false }.sorted(by: { $0.date > $1.date})
        
        
        return realmRecords.map { Record(id: $0.id,
                                                         price: $0.price,
                                                         place: $0.place,
                                                         date: $0.date,
                                                         category: Category(rawValue: $0.category)!,
                                                         keywords: $0.keywords?.components(separatedBy: ";"),
                                                         currency: $0.currency,
                                                         repeatsEachTimeInterval: $0.repeatsEachTimeInterval.value)
            
        }
        
    }
    
    func retrieveRecords() -> [[Record]] {

        return unflattenRecords(flatRecords: retrieveRecords_flat())
    }
    
    
    
    func retrieveIncomes_flat() -> [Income] {
        let realmIncomes = realm.objects(RealmIncome.self).sorted(by: { $0.date > $1.date}).filter{ $0.isDeleted == false }
        
        return realmIncomes.map { Income(id: $0.id,
                                         price: $0.price,
                                         date: $0.date, source: $0.source,
                                         currency: $0.currency)
            
        }
    }
    
    func retrieveIncomes() -> [[Income]] {
        
        return ManageEntries.unflatten(entries: retrieveIncomes_flat()) as! [[Income]]
    }
    
    
    
    // add retrieveEntries (as AnyObject)
}
