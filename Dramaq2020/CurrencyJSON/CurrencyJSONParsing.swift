//
//  CurrencyJSONParsing.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 22/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

class CurrencyJSONParsing {
    
    struct ResponseBody: Decodable {
        var objects: CurrencyJSON
    }
    
    struct CurrencyJSON: Decodable {
        var currencies: [String: CurrencyInfo]
    }
    
    struct CurrencyInfo: Decodable{
        var symbol: String
        var name: String
        var symbol_native: String
        var code: String
        
        enum CodingKeys: String, CodingKey {
            case symbol = "symbol"
            case name = "name"
            case symbol_native = "symbol_native"
            case code = "code"
        }
    }

    func getWorldCurrencies() {
        
        guard let path = Bundle.main.path(forResource: "Common-Currency", ofType: "json") else { return }

        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url)
            
            let json = try JSONDecoder().decode(CurrencyJSON.self, from: data)
            print(json)
            
        } catch {

            print(error)
        }
    }
    
}

