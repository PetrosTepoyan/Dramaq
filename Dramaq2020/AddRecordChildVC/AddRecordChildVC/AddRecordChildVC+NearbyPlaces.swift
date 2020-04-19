//
//  AddRecordChildVC+NearbyPlaces.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 11/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit

extension AddRecordChildVC: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
            
//        case keywordTableView:
//            return keywords.count
            
        default:
            if nearbyPlaces.isEmpty {
                return 1
            } else {
                return 12
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        if tableView == keywordTableView {
        //            let cell = keywordTableView.dequeueReusableCell(withIdentifier: "KeywordViewCell", for: indexPath) as! KeywordViewCell
        //
        //            let label = PTKeywordsLabel()
        //
        //            label.text = keywords[indexPath.row]
        //            cell.setKeywordView(keyword: label)
        //
        //            cell.clipsToBounds = true
        //            cell.contentView.backgroundColor = UIColor.clear
        //            cell.layer.backgroundColor = UIColor.clear.cgColor
        //            cell.backgroundColor = .clear
        //
        //            return cell
        //        } else {
        
        
        
        let cell = nearbyPlacesTableView.dequeueReusableCell(withIdentifier: "NearbyPlaceCell", for: indexPath) as! NearbyViewCell
        
        if !nearbyPlaces.isEmpty {
            let place = nearbyPlaces[indexPath.row]
            cell.textLabel?.text = place.name
            cell.detailTextLabel?.text = place.vicinity
            print(place.name, place.types, extractCategoryFromPlaceResponse(place: place))
            cell.category = extractCategoryFromPlaceResponse(place: place)
            
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.default
        
        cell.clipsToBounds = true
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        
        return cell
        //        }
        
        
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
        

        var categoryViews = [CategoryView]()
        for i in 0...categoryCollectionView.numberOfItems(inSection: 0)-1 {
            
            if let item = categoryCollectionView!.dataSource?.collectionView(self.categoryCollectionView, cellForItemAt: IndexPath(row: i, section: 0)) as? CategoryCollectionViewCell {
                print(item)
                item.center.y += categoryCollectionView.center.y
                
                let neededCategoryView = item.view.subviews[0] as! CategoryView
                categoryViews.append(neededCategoryView)
                
            }
        }
        
        
        categoryViews = categoryViews.filter { $0.categoryIdentifier == category }
        
        
        guard !categoryViews.isEmpty else { return }
        
        categoryImagePressed(on: categoryViews[0])
    }
    
}

extension AddRecordChildVC {
    @IBAction func placeTextFieldEditingDidBegin(_ sender: Any) {
        
        scrollView.isScrollEnabled = false
        
        UIView.animate(withDuration: 0.1, animations: {
            self.nearbyPlacesTableView.alpha = 1.0
            self.nearbyPlacesTableView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        setupLoc()
        retrieveNearbyPlaces()
        
        
    }
    
    @IBAction func placeTextFieldEditingDidEnd(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
            self.nearbyPlacesTableView.alpha = 0.0
            self.nearbyPlacesTableView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        scrollView.isScrollEnabled = true
    }
    
    func retrieveNearbyPlaces() {
        let apiKey    = "AIzaSyBcnrDUZCOMinmvHcDunigw_J9aifHzK0Y"
        let service = NetworkService(url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude ?? 0.0),\(longitude ?? 0.0)&type=establishment&rankby=distance&key=\(apiKey)")
        
        service.getPlaces()
        service.completionHandler { [weak self] (places, status, message) in
            if status {
                guard let self = self else { return }
                guard let _places = places else { return }
                self.nearbyPlaces = _places
            }
            
        }
    }
    
    
}

extension AddRecordChildVC {
    func extractCategoryFromPlaceResponse(place: Place) -> Category {
        var categoryToRetern: Category = .Unknown
        
        for i in place.types.filter({ $0 != "point_of_interest" && $0 != "establishment"}) {
            let type = NearByTypes.init(rawValue: i)
            switch type { // beauty category
            case .supermarket,
                 .shopping_mall,
                 .store,
                 .jewelry_store,
                 .shoe_store,
                 .pet_store,
                 .book_store,
                 .home_goods_store,
                 .liquor_store,
                 .bicycle_store,
                 .hardware_store,
                 .electronics_store,
                 .convenience_store,
                 .department_store,
                 .clothing_store,
                 .furniture_store
                : categoryToRetern = Category.Shop
                
            case .travel_agency,
                 .tourist_attraction
                : categoryToRetern = Category.Traveling
                
            case .transit_station,
                 .train_station,
                 .taxi_stand,
                 .subway_station,
                 .parking,
                 .gas_station,
                 .bus_station
                : categoryToRetern = Category.Transportation
                
            case .zoo,
                 .stadium,
                 .park,
                 .night_club,
                 .museum,
                 .movie_theater,
                 .movie_rental,
                 .bar,
                 .casino,
                 .art_gallery
                : categoryToRetern = Category.Entertainment
                
            case .doctor,
                 .hospital,
                 .veterinary_care,
                 .pharmacy,
                 .physiotherapist,
                 .dentist,
                 .health
                : categoryToRetern = Category.Medicine
                
            case .school,
                 .library
                : categoryToRetern = Category.Education
                
            case .food,
                 .restaurant,
                 .meal_delivery,
                 .meal_takeaway,
                 .bakery,
                 .cafe
                : categoryToRetern = Category.Food
                
            case .gym
                : categoryToRetern = Category.Sport
            
            case .beauty_salon,
                 .spa
                : categoryToRetern = Category.Beauty
                
            case .mosque,
                 .synagogue
                : categoryToRetern = Category.Religion
                
            default: categoryToRetern = Category.Unknown
            }
        }
        return categoryToRetern
    }
}
