//
//  RecordAddedDelegate.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 26/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

protocol RecordAddedDelegate {
    func didAdd(record: Record)
}

protocol RecordWillBeDisplayed {
    func didDisplay(record: Record)
}
