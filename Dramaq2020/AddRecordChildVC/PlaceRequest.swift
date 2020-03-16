//
//  PlaceRequest.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 9/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation


enum PlaceError: Error {
    case noDataAvalible
    case cannotProcessData
}

struct PlaceRequest {
    
    let resourceURL: URL
    let apiKey    = "AIzaSyBcnrDUZCOMinmvHcDunigw_J9aifHzK0Y"
    let latitute  = 40.193391
    let longitude = 44.503770
    let radius    = 1500
    
    
    
    init(radius: Double = 1500, latitude: Double = 40.193391, longitude: Double = 44.50377) {
        let resourceString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=food&key=\(apiKey)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        let parametersForSearch = ["location": "\(latitute),\(longitude)","radius":"\(radius)"]
        
        self.resourceURL = resourceURL
    }
    
//    func getPlaces(completition: @escaping(Result<[PlaceDetail], PlaceError>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error  in
//
//            print(self.resourceURL)
//
//            guard let jsonData = data, error == nil else {
//                completition(.failure(.noDataAvalible))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let placeResponse = try decoder.decode(PlaceResponse.self, from: jsonData)
//                let placeDetails = placeResponse.response.places
//                completition(.success(placeDetails))
//            } catch {
//                completition(.failure(.cannotProcessData))
//            }
//
//        }
//        dataTask.resume()
//    }

    func getPlaces(completion: @escaping (Result<[String],Error>) -> Void) {
        print(resourceURL)
        URLSession.shared.dataTask(with: resourceURL) { data, response, error  in
            guard let jsonData = data, error == nil else {
                print("error1")
                return
            }
            var names: [String]
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: [])
                
                guard let jsonArray = jsonResponse as? NSDictionary else {
                      return
                }
                let results = jsonArray["results"] as! NSArray
                let resultsDict = results.map { $0 as! NSDictionary }
                names = resultsDict.map { $0["name"] as! String }
                DispatchQueue.main.async {
                    completion(.success(names))
                }
            
            } catch {
                print("error2")
            }
            
        }.resume()
        
    }
    
}
