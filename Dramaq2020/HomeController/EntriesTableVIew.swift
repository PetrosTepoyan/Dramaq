//
//  EntriesTableVIew.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 16/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

protocol ReloadingDelegate {
    func returnHomeController() -> HomeController
}

class EntriesTableVIew: UITableView {
    
    var reload: ReloadingDelegate!
    
    
    override func reloadData() {
        super.reloadData()
        print("reloaded")
        
        let homeController = reload.returnHomeController()
        homeController.reloadBalance()
        homeController.searchField.isUserInteractionEnabled = !homeController.entries.isEmpty
        
    }
}
