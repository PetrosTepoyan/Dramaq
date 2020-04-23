//
//  FrequentRecord.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 28/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class FrequentRecord1: RecordView {
    convenience init(record: Record){
        self.init()
        
        
    }
}


class FrequentRecord: UIView {
    
    
    var price: Double!
    var place: String!
    var category: Category!
    
    convenience init(record: Record){
        self.init()
        
        self.price    = record.price
        self.place    = record.place
        self.category = record.category
        
        setupFrequentView(price: record.price, place: record.place, category: record.category)
        
        
    }
    
    convenience init(price: Double?, place: String?, category: Category?){
        self.init()
        
        setupFrequentView(price: price, place: place, category: category)
        
        
    }
    
    func setupFrequentView(price: Double?, place: String?, category: Category?) {
        let record = Record(id: 0,
                            price: price!,
                            place: place!,
                            date: Date(),
                            category: Category.Unknown,
                            keywords: nil,
                            currency: UserDefaults.standard.string(forKey: "CurrentCurrency"))
        let hStack = UIStackView()
        addSubview(hStack)
        
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.spacing = 10
        
        let priceLabel = PTLabel()
        let placeLabel = PTLabel()
                
        priceLabel.text = "\(record.price!)"
        placeLabel.text = "\(record.place!)"
        
        hStack.addArrangedSubview(priceLabel)
        hStack.addArrangedSubview(placeLabel)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -20),
            hStack.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
        ])
        
        let color = UIColor(named: category!.rawValue)
        
        backgroundColor = color
        clipsToBounds = false
        layer.cornerRadius = 30
        
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset  = CGSize(width: 0, height: 10)
        layer.shadowRadius = 5
        
        
        
    }
    
}

