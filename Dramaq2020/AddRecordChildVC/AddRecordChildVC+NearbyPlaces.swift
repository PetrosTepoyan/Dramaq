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
        UIView.animate(withDuration: 0.1, animations: {
            self.nearbyPlacesTableView.alpha = 1.0
            self.nearbyPlacesTableView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        setupLoc()
        retrieveNearbyPlaces()
        
        
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
    
    @IBAction func placeTextFieldEditingDidEnd(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
            self.nearbyPlacesTableView.alpha = 0.0
            self.nearbyPlacesTableView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
}
