//
//  AddRecordChildVC+NearbyPlaces.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 11/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit

extension AddRecordChildVC {
    @IBAction func placeTextFieldEditingDidBegin(_ sender: Any) {
        
        scrollableView.sendSubviewToBack(lowerStack)
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
        
        let service = NetworkService(url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude!),\(longitude!)&type=establishment&rankby=distance&key=\(apiKey)")
        
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
                
            case .travel_agency
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
                
            case .restaurant,
                 .meal_delivery,
                 .meal_takeaway,
                 .bakery,
                 .cafe
                : categoryToRetern = Category.Food
                
            case .gym
                : categoryToRetern = Category.Sport
            
            case .beauty_salon,
                 .spa
                : print("Beauty") ; categoryToRetern = .Unknown
                
            case .mosque,
                 .synagogue
                : print("Religion") ; categoryToRetern = .Unknown
                
            default: categoryToRetern = Category.Unknown
            }
        }
        return categoryToRetern
    }
}
