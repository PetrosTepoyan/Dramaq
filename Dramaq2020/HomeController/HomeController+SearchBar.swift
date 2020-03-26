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
        let searchTextModif = searchText.trimmingCharacters(in: .whitespaces)
        
        let searchedRecordsFlat = records
            .flatMap { $0 }
            .filter {
                $0.place.lowercased()                              .contains(searchTextModif.lowercased()) ||
                $0.date.getDayExpExp().lowercased()                .contains(searchTextModif.lowercased()) ||
                String($0.price)                                   .contains(searchTextModif.lowercased()) ||
                String(Substring($0.category.rawValue)).lowercased().contains(searchTextModif.lowercased())
        }
        
        
        
        searchedRecords = ManagingRealm().unflattenRecords(flatRecords: searchedRecordsFlat)
        print(searchedRecords)
//        searching = true
//        
//        if searchTextModif.count == 0 {
//            searching = false
//        }
        searching = searchTextModif.count != 0
        tableView.reloadData()
        
        
        
        if searchedRecords.isEmpty && searchTextModif.count > 0 {
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
        
        guard !records.isEmpty else { searchBar.isUserInteractionEnabled = false ; return }
        searchBar.isUserInteractionEnabled = true
        
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


//extension UITableView {
//    func reloadDataWithUpdateToSearchBar(isSearchBarEnabled: Bool) {
//        self.reloadData()
//        searchBar.isUserInteractionEnabled = isSearchBarEnabled
//    }
//    
//}
