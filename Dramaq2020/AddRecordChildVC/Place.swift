//
//  Place.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 9/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

struct PlaceResponse: Decodable {
    var response: Places
}

struct Places: Decodable {
    var places: [PlaceDetail]
}

struct PlaceDetail: Decodable {
    var name: String
}
