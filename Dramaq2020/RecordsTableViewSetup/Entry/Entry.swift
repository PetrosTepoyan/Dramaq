//
//  Entry.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 14/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

protocol Entry {
    var id: Int! { get set }
    var date: Date! { get set }
    var price: Double? { get set }
    
}

protocol EntryView : UIView {
    var id: Int! { get set }
    var time: String! { get set }
    var price: Double? { get set }
    
    
}

class ManageEntries {
    
    static func unflatten(entries: [Entry]) -> [[Entry]]{
        var entriesFlattened = entries
        var multiEntries: [[Entry]] = []
        
        
        
        
        let dateCounts = Set(entriesFlattened.map {$0.date}).count
        for _ in 0...(dateCounts){
            let nestedArr = entriesFlattened.filter {$0.date.getDay() == entriesFlattened[0].date.getDay()}
            
            multiEntries.append(nestedArr)
            
            entriesFlattened.removeAll( where: {
                $0.date.getDay() == nestedArr[0].date.getDay()
                
            } )
        }
        return multiEntries.filter { $0.isEmpty == false }
        
    }
    
    static func flatten(entries: [[Entry]]) -> [Entry]{
        return entries.flatMap { $0 }

    }
    
}

//class Entry {
//    
//    var date: Date!
//    
//    init(date: Date) {
//        self.date = date
//    }
//    
//    
    
//    
//}

