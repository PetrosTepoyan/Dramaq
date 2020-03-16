//
//  Record.swift
//  MoneyTrackerNotFinal
//
//  Created by Петрос Тепоян on 11/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

let currency = String(UserDefaults.standard.string(forKey: "CurrentCurrency") ?? "$")

struct Record {
    var id: Int!
    var price: Double?
    var place: String?
    var date: Date?
    var category: Category
    var keywords: [String]?
    var currency: String?
}


open class RecordView: UIView {
    
    var id: Int!
    var price: Double?
    var place: String?
    var time:  String?
    var category: Category!
    
    convenience init(record: Record){
        self.init()
    
        self.id    = record.id
        self.price = record.price
        self.place = record.place
        self.time  = record.date?.getTime()
        self.category = record.category
        
        setupRecordView(price: price, place: place, time: time, category: category)
        
        
    }
    
    convenience init(price: Double?, place: String?, time: String?, category: Category?){
        self.init()
        
        self.price = price
        self.place = place
        self.time  = time
        self.category = category
        
        setupRecordView(price: price, place: place, time: time, category: category ?? Category.Unknown)
        
        
    }
    

    private func setupRecordView(price: Double?, place: String?, time: String?, category: Category) {
        
        let record = Record(price: price, place: place, date: nil, category: category, keywords: nil, currency: currency)
        

        let hStack = UIStackView()
        addSubview(hStack)
        
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.spacing = 10
        
        let priceLabel = PTLabel()
        let placeLabel = PTLabel()
        let timeLabel =  PTLabel()
        
        
        
        priceLabel.text = "\((record.price ?? 0.0).clean)" + currency
        placeLabel.text = "\(record.place ?? "")"
        timeLabel.text  = time
        
        hStack.addArrangedSubview(priceLabel)
        hStack.addArrangedSubview(placeLabel)
        hStack.addArrangedSubview(timeLabel)
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
                placeLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
                placeLabel.textAlignment = .right
                placeLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -5).isActive = true
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -20),
            hStack.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
        ])
        
        
        let color = UIColor(named: category.rawValue)
        
        backgroundColor = color
        clipsToBounds = false
        layer.cornerRadius = 30
        
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset  = CGSize(width: 0, height: 8)
        layer.shadowRadius = 4
        
        

    }
    
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
