//
//  HomeController+SearchBar.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 8/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

extension HomeController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchedRecordFlat = records
            .flatMap { $0 }
            .filter {
                $0.place.lowercased()                              .contains(searchText.lowercased()) ||
                $0.date.getDayExpExp().lowercased()                .contains(searchText.lowercased()) ||
                String($0.price)                                   .contains(searchText.lowercased()) ||
                String(Substring($0.category.rawValue)).lowercased().contains(searchText.lowercased())
        }
        
        
        
        searchedRecord = ManagingRealm().unflattenRecords(flatRecords: searchedRecordFlat)
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        if scrollViewIsShown {
            hidingRecordsAnimation()
            scrollViewIsShown.toggle()
        }
        
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if !scrollViewIsShown {
            showingRecordsAnimation()
            scrollViewIsShown.toggle()
        }
        
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if scrollViewIsShown {
            hidingRecordsAnimation()
            scrollViewIsShown.toggle()
        }
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

