//
//  Income.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 14/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit


struct Income: Entry{
    var id: Int!
    var price: Double?
    var date: Date!
    var source: String?
    var currency: String?
    
    
//    init(id: Int,
//         price: Double,
//         source: String?,
//         date: Date!,
//         currency: String?) {
//        super.init(date: date)
//
//        self.id = id
//        self.price = price
//        self.source = source
//        self.date = date
//        self.currency = currency
//    }
    
}


open class IncomeView: UIView, EntryView {
    
    var id: Int!
    var price: Double?
    var source: String?
    var time: String!
    var currency: String?
        
    
    convenience init(income: Income){
        self.init()
    
        self.id    = income.id
        self.price = income.price
        self.currency = income.currency
        self.source = income.source
        self.time  = income.date.getTime()
        
        setupIncomeView(price: price, source: source, time: time, currency: currency)
        
        
    }
    

    private func setupIncomeView(price: Double?, source: String?, time: String?, currency: String?) {
        
        

        let hStack = UIStackView()
        addSubview(hStack)
        
        hStack.axis = .horizontal
        hStack.alignment = .fill
        
        let plusLabel = PTLabel(fontSize: 45)
        let priceLabel = PTLabel()
        let sourceLabel = PTLabel()
        let timeLabel =  PTLabel()
        
        plusLabel.text = "+"
        priceLabel.text = "\((price ?? 0.0).clean)" + (String(Array(currency ?? "$")[0]))
        sourceLabel.text = "\(source ?? "")  "
        timeLabel.text  = time
        
        hStack.addArrangedSubview(plusLabel)
        hStack.addArrangedSubview(priceLabel)
        hStack.addArrangedSubview(sourceLabel)
        hStack.addArrangedSubview(timeLabel)
        
        sourceLabel.minimumScaleFactor = 2
        sourceLabel.numberOfLines = 2
        sourceLabel.textAlignment = .right
        sourceLabel.lineBreakMode = .byTruncatingTail
        
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -20),
            hStack.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
        ])
        
        
        let color = UIColor.green
        
//        backgroundColor     = color
        clipsToBounds      = true
        layer.cornerRadius = 10
        layer.borderColor = color.cgColor
        layer.borderWidth = 5
//        layer.shadowColor   = color.cgColor
//        layer.shadowOpacity = 0.6
//        layer.shadowOffset  = CGSize(width: 0, height: 8)
//        layer.shadowRadius  = 4
        
        

    }
    
}
