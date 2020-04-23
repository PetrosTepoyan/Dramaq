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
        let searchTextModif = searchText.trimmingCharacters(in: .whitespaces).lowercased()
    
        let searchedRecordsFlat: [Entry] = entries
            .flatMap { $0 }
            .filter {
                let dateCheck1 = $0.date.getDayExpExp().lowercased().contains(searchTextModif)
                let dateCheck2 = $0.date.getDayExpExpForDateCheck().lowercased().contains(searchTextModif)
                let dateCheck3 = $0.date.getDayExp().lowercased().contains(searchTextModif)
                print($0.date.getDayExpExp().lowercased(),
                      $0.date.getDayExpExpForDateCheck().lowercased(),
                      $0.date.getDayExp().lowercased())
                let dateCheck = dateCheck1 || dateCheck2 || dateCheck3
                let priceCheck = String($0.price ?? 0.0).contains(searchTextModif)
                
                var placeCheck: Bool = false
                var categoryCheck: Bool = false
                if let record = $0 as? Record {
                    placeCheck = record.place.lowercased().contains(searchTextModif)
                    categoryCheck = String(Substring(record.category.rawValue)).lowercased().contains(searchTextModif)
                }
                
                var sourceCheck: Bool = false
                if let income = $0 as? Income {
                    sourceCheck = (income.source ?? "").lowercased().contains(searchTextModif)
                }
                
            
                return placeCheck || categoryCheck || dateCheck || priceCheck || sourceCheck
                
        }
        
        
        
        searchedEntries = ManageEntries.unflatten(entries: searchedRecordsFlat)
        
//        searching = true
//        
//        if searchTextModif.count == 0 {
//            searching = false
//        }
        searching = searchTextModif.count != 0
        tableView.reloadData()
        
        if searchedEntries.isEmpty && searchTextModif.count > 0 {
            setupEmptyRecordsView(message: "No records with the given parameters(")
        } else {
            removeEmptyRecordsView()
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
    
}

