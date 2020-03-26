//
//  CurrencyJSONParsing.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 22/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation

class CurrencyJSONParsing {
    
    struct CurrencyJSON: Codable {
        let symbol, name, symbolNative: String
        let decimalDigits: Int
        let rounding: Double
        let code, namePlural: String

        enum CodingKeys: String, CodingKey {
            case symbol, name
            case symbolNative = "symbol_native"
            case decimalDigits = "decimal_digits"
            case rounding, code
            case namePlural = "name_plural"
        }
    }

    typealias Currency = [String: CurrencyJSON]

    func getWorldCurrencies() -> [String]{
        
        let path = Bundle.main.path(forResource: "Common-Currency", ofType: "json")!

        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(Currency.self, from: data)
            var currencies = Array<CurrencyJSON>(json.values)
            currencies = currencies.sorted(by: { $0.name < $1.name })
            let strings = currencies.map { "\($0.symbolNative)-\($0.name)" }
            
            print(strings)
            return strings
            
        } catch {

            print(error)
            return []
        }
        
    }
    
}

