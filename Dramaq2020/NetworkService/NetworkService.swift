//
//  NetworkService.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 11/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    let apiKey    = "AIzaSyBcnrDUZCOMinmvHcDunigw_J9aifHzK0Y"
    fileprivate var url = ""
    

    typealias placesCallBack = (_ places: [Place]?, _ status: Bool, _ message: String) -> Void
    var callBack: placesCallBack?
    
    init(url: String) {
        self.url = url
        
    }
    
    func getPlaces(with parameters: [String:String]? = nil){
        AF.request(self.url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                let places = response.results
                self.callBack?(places, true, "")
            }
            catch {
                
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping placesCallBack) {
        self.callBack = callBack
    }
}

struct Response: Decodable {
    var results: [Place]
    
    
}

struct Place: Decodable {
    var name: String
    var vicinity: String
    var types: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case vicinity = "vicinity"
        case types = "types"
    }
}
