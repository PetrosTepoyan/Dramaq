//
//  NetworkClient.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 9/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Alamofire

//class NetworkClient {
//    func execDebug(url: String) {
//        AF.request(url)
//            .validate().responseJSON(completionHandler: { response in
//                print(response)
//                
//            })
//    }
//    
//    func executeTest(url: String) -> [Dictionary<String, AnyObject>]{
//        var resultArray: [Dictionary<String, AnyObject>] = []
//        
//        var urlRequest = URLRequest(url: URL(string: url)!)
//        urlRequest.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard error == nil else { return }
//            guard let responseData = data else { return }
//            let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//            
//            guard let dict = jsonDict as? Dictionary<String, AnyObject> else { return }
//            guard let results = dict["results"] as? [Dictionary<String, AnyObject>] else { return }
//            
//            for dct in results {
//                resultArray.append(dct)
//            }
//            
//            
//            
//        }
//        task.resume()
//        
//        return resultArray
//    }
//    
//    func execute(url: String) {
//        AF.request(url)
//            .validate()
//            .responseDecodable(of: Places.self) { (response) in
//                guard let places = response.value else { return }
//                print(places)
//                print("Entered")
//        }
//        print("Requested")
//    }
//}
