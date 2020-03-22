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
        
        guard searchText != "" else { return }
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
        
        if searchedRecord.isEmpty {
            setupEmptyRecordsView(message: "No records with the given parameters(")
        } else {
            removeEmptyRecordsView()
        }
        
        
    }
    
    func setupEmptyRecordsView(message: String){
        let emptySearch = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300))
        let label = PTLabel(fontSize: 25)
        label.text = message
        label.numberOfLines = 6
        label.frame = emptySearch.frame
        emptySearch.addSubview(label)
        tableView.addSubview(emptySearch)
    }
    
    func removeEmptyRecordsView() {
        for i in tableView.subviews {
            i.removeFromSuperview()
        }
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
        removeEmptyRecordsView()
    }
    
}

