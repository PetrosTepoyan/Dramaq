//
//  NetworkService.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 11/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import Alamofire

#warning("Change the code below: add SwiftyJSON, so that each call of the main function with a type would return an array of objects of that type")

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

class CurrencyExchange {
    var base: String? = "USD"
    let url: String!
    
    
    init(base: String) {
        self.base = base
        url = "https://api.exchangeratesapi.io/latest?base=\(base)"
    }
    
    
    func getCurrencies(completionHandler: @escaping (_ currencies: Currency) -> Void){
        AF.request(self.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else { return }
            do {
                let response = try JSONDecoder().decode(Currency.self, from: data)
                print(response)
                completionHandler(response)
            }
            catch {
                print("No")
            }
        }
    }
    
    
}

struct Currency: Codable {
    let rates: [String: Double]
    let base, date: String
}



