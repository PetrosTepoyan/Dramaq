//
//  Record.swift
//  MoneyTrackerNotFinal
//
//  Created by Петрос Тепоян on 11/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit


struct Record {
    var id: Int!
    var price: Double
    var place: String
    var date: Date
    var category: Category
    var keywords: [String]?
    var currency: String?
}


open class RecordView: UIView {
    
    var id: Int!
    var price: Double?
    var currency: String?
    var place: String?
    var time:  String?
    var category: Category!
    
    convenience init(record: Record){
        self.init()
    
        self.id    = record.id
        self.price = record.price
        self.currency = record.currency
        self.place = record.place
        self.time  = record.date.getTime()
        self.category = record.category
        
        setupRecordView(price: price, place: place, time: time, category: category, currency: currency)
        
        
    }
    
    convenience init(price: Double?, place: String?, time: String?, category: Category?){
        self.init()
        
        self.price = price
        self.currency = currency
        self.place = place
        self.time  = time
        self.category = category
        
        setupRecordView(price: price, place: place, time: time, category: category ?? Category.Unknown, currency: currency)
        
        
    }
    

    private func setupRecordView(price: Double?, place: String?, time: String?, category: Category, currency: String?) {
        
        

        let hStack = UIStackView()
        addSubview(hStack)
        
        hStack.axis = .horizontal
        hStack.alignment = .fill
        
        let priceLabel = PTLabel()
        let placeLabel = PTLabel()
        let timeLabel =  PTLabel()
        
        priceLabel.text = "\((price ?? 0.0).clean)" + (currency ?? "$")

        placeLabel.text = "\(place ?? "")  "
        timeLabel.text  = time
        
        hStack.addArrangedSubview(priceLabel)
        hStack.addArrangedSubview(placeLabel)
        hStack.addArrangedSubview(timeLabel)
        
        placeLabel.minimumScaleFactor = 2
        placeLabel.numberOfLines = 2
        placeLabel.textAlignment = .right
        placeLabel.lineBreakMode = .byTruncatingTail
        
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -20),
            hStack.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
        ])
        
        
        let color = UIColor(named: category.rawValue)
        
        backgroundColor     = color
        clipsToBounds      = false
        layer.cornerRadius = 30
        
        layer.shadowColor   = color?.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset  = CGSize(width: 0, height: 8)
        layer.shadowRadius  = 4
        
        

    }
    
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
