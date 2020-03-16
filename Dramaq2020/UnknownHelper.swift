//
//  UnknownHelper.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 9/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

let apiKey    = "AIzaSyBcnrDUZCOMinmvHcDunigw_J9aifHzK0Y"
let latitute  = 40.1931
let longitude = 44.5044
let radius    = 1500
let request   =  "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitute),\(longitude)&radius=\(radius)&type=restaurant&key=\(apiKey)"


