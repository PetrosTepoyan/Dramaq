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
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Double = 0.0
    @objc dynamic var place: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var category: String = "Unknown"
    @objc dynamic var keywords: String?
    @objc dynamic var currency: String?
    @objc dynamic var username: String?
    
    
    
}

