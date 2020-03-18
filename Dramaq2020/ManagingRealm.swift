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
    
    func retrieveRecords() -> [[Record]] {
        let realmRecords = realm.objects(RealmRecord.self).filter{$0.isDeleted == false }.sorted(by: { $0.date > $1.date})

        
        let recordsFlattened = realmRecords.map { Record(id: $0.id,
                                                         price: $0.price,
                                                         place: $0.place,
                                                         date: $0.date,
                                                         category: Category(rawValue: $0.category)!,
                                                         keywords: $0.keywords?.components(separatedBy: ";"),
                                                         currency: $0.currency)
            
        }

        records = unflattenRecords(flatRecords: recordsFlattened)
        
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
    
    func retrieveTimes() -> [String] {
        let realmRecords = realm.objects(RealmRecord.self).filter{$0.isDeleted == false }.sorted(by: { $0.date > $1.date})
        return realmRecords.map { ($0.date.getTime()) }
    }
    
}
