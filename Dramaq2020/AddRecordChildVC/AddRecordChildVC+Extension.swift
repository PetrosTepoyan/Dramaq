//
//  AddRecordChildVC+Extension.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 6/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

extension AddRecordChildVC: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
            
        case keywordTableView:
            return keywords.count
            
        default:
            if nearbyPlaces.isEmpty {
                return 1
            } else {
                return 12
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == keywordTableView {
            let cell = keywordTableView.dequeueReusableCell(withIdentifier: "KeywordViewCell", for: indexPath) as! KeywordViewCell
            
            let label = PTKeywordsLabel()
            
            label.text = keywords[indexPath.row]
            cell.setKeywordView(keyword: label)
        
            cell.clipsToBounds = true
            cell.contentView.backgroundColor = UIColor.clear
            cell.layer.backgroundColor = UIColor.clear.cgColor
            cell.backgroundColor = .clear
            
            return cell
        } else {
            
            
            
            let cell = nearbyPlacesTableView.dequeueReusableCell(withIdentifier: "NearbyPlaceCell", for: indexPath) as! NearbyViewCell
            
            if !nearbyPlaces.isEmpty {
                let place = nearbyPlaces[indexPath.row]
                cell.textLabel?.text = place.name
                cell.detailTextLabel?.text = place.vicinity
                print(place.types)
                cell.category = extractCategoryFromPlaceResponse(place: place)
                // check // create a class for the cell and add category as property extractCategoryFromPlaceResponse(place: Place)
                
                
            }
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.default
            
            cell.clipsToBounds = true
            cell.contentView.backgroundColor = UIColor.clear
            cell.layer.backgroundColor = UIColor.clear.cgColor
            cell.backgroundColor = .clear
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isHidden == true {

            cell.isHidden.toggle()

        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView == nearbyPlacesTableView else { return }
        let cell = tableView.cellForRow(at: indexPath) as! NearbyViewCell
        
        placeTF.text = cell.textLabel?.text
        placeTF.endEditing(true)
        category = cell.category
        
        let arrSubviews = (upperStack.arrangedSubviews + lowerStack.arrangedSubviews) as! [CategoryView]
        let relatedCategory = arrSubviews.filter { $0.categoryIdentifier == category }
        guard !relatedCategory.isEmpty else { return }
        categoryImagePressed(on: relatedCategory[0])
    }
    
}
