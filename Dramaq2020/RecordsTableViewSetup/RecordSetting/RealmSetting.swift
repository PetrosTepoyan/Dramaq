//
//  RealmRecord.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 5/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRecord: Object {
    @objc dynamic var isDeleted: Bool = false
//    @objc dynamic var isRepetitive: Bool = false
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Double = 0.0
    @objc dynamic var place: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var category: String = "Unknown"
    var repeatsEachTimeInterval = RealmOptional<Double>()
    @objc dynamic var keywords: String?
    @objc dynamic var currency: String?
//    @objc dynamic var user: RealmUser?
    @objc dynamic var username: String = "Petros Tepoyan"
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
}

//class TestRealm: Object {
//    @objc dynamic var record: Record?
//}

class RealmIncome: Object {
    @objc dynamic var isDeleted: Bool = false
//    @objc dynamic var isRepetitive: Bool = false
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Double = 0.0
    @objc dynamic var source: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var currency: String?
//    @objc dynamic var repeatsEachTimeInterval: Date?
    //    @objc dynamic var user: RealmUser?
    @objc dynamic var username: String = "Petros Tepoyan"
    
    override class func primaryKey() -> String? {
        return "id"
    }
}



//class Keywords: Object {
//    @objc dynamic var keyword: String = ""
//    let keywords = List<keyword>()
//}

//class RealmUser: Object {
//    @objc dynamic var name: String = ""
//    @objc dynamic var surname: String = ""
//
//}



