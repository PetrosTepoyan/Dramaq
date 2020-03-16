//
//  Constants.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 16/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//
import Foundation
import UIKit

struct Colors{
    static let darkGrey = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
    
    static let orangeTop = UIColor(red: 255.0/255.0, green: 190.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let orangeBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    
    static let greenTop = UIColor(red: 152.0/255.0, green: 251.0/255.0, blue: 152.0/255.0, alpha: 1.0)
    static let greenButtom = UIColor(red: 34.0/255.0, green: 139.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    
    static let blueTop = UIColor(red: 0.0/255.0, green: 191.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let blueButtom = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    
}


struct Fonts{
    static let avenirNextMedium = "AvenirNext-Medium"
}



enum Segues {
    static let showAddRecordView = "AddRecordChildVC"
    static let hideAddRecordView = "HideAddRecordView"
}

