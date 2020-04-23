//
//  ReloadingExtension.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 20/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

extension HomeController: ReloadingDelegate {
    
    func returnHomeController() -> HomeController {
        return self
    }
    
}
