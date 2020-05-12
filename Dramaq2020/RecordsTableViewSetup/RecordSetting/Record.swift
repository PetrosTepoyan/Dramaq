//
//  Record.swift
//  MoneyTrackerNotFinal
//
//  Created by Петрос Тепоян on 11/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit


struct Record: Entry {
    
    var id: Int!
    var price: Double?
    var place: String!
    var date: Date!
    var category: Category!
    var keywords: [String]?
    var currency: String?
    var repeatsEachTimeInterval: Double?
    var purchaseMethod: PurchaseMethods! = .Cash
    
    
}


open class RecordView: UIView, EntryView {
    
    var id: Int!
    var price: Double?
    var currency: String?
    var place: String?
    var time:  String!
    var category: Category!
    var purchaseMethod: PurchaseMethods!
    var badges: [Badge]?
    
    var containerView = UIView()
    
    convenience init(record: Record){
        self.init()
    
        self.id             = record.id
        self.price          = record.price
        self.currency       = record.currency
        self.place          = record.place
        self.time           = record.date.getTime()
        self.category       = record.category
        self.purchaseMethod = record.purchaseMethod
        
        badges = []
        if record.repeatsEachTimeInterval != nil {
            self.badges = [.Repetitive]
            
        }
        
        if record.purchaseMethod == .Card {
            self.badges!.append(Badge.Card)
        } else {
            self.badges!.append(Badge.Cash)
        }
        
        
        prepareLayout()
        setupRecordView(price   : price,
                        place   : place,
                        time    : time,
                        category: category,
                        currency: currency,
                        badges  : badges)
        
        
    }
    
    
    func prepareLayout(){
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints                   = false
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive   = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive           = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive     = true
    }

    private func setupRecordView(price: Double?, place: String?, time: String?, category: Category, currency: String?, badges: [Badge]?) {
        
        

        let hStack = UIStackView()
        containerView.addSubview(hStack)
        
        hStack.axis = .horizontal
        hStack.alignment = .fill
        
        let priceLabel = PTLabel()
        let placeLabel = PTLabel()
        
        let timeLabel =  PTLabel()
        
        priceLabel.text = "\((price ?? 0.0).clean)" + (String(Array(currency ?? "$")[0]))

        placeLabel.text = "\(place ?? "")  "
        timeLabel.text  = time
        
        hStack.addArrangedSubview(priceLabel)
        hStack.addArrangedSubview(placeLabel)
        hStack.addArrangedSubview(timeLabel)
        
        placeLabel.minimumScaleFactor = 2
        placeLabel.numberOfLines = 2
        placeLabel.textAlignment = .right
        placeLabel.lineBreakMode = .byTruncatingTail
        
        let color = UIColor(named: category.rawValue)
        containerView.backgroundColor     = color
        containerView.layer.cornerRadius = 30
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor   = color?.cgColor
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowOffset  = CGSize(width: 0, height: 8)
        containerView.layer.shadowRadius  = 4
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -20),
            hStack.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
        ])
        
        guard let badges = badges else { return }
        for (i, badge) in badges.enumerated() {

            let badgeImageView = UIImageView(image: UIImage(named: badge.rawValue + "Badge"))
            let side: CGFloat = 25
            badgeImageView.frame = CGRect(x: hStack.frame.maxX - 5,
                                          y: hStack.frame.maxY - 8,
                                          width: side,
                                          height: side)
            
            addSubview(badgeImageView)
            badgeImageView.clipsToBounds = false
            
            badgeImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                badgeImageView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: CGFloat(-5 - i*30)),
                badgeImageView.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 8),
                badgeImageView.widthAnchor.constraint(equalToConstant: side),
                badgeImageView.heightAnchor.constraint(equalToConstant: side)
            ])
            
        }
    }
    
    
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
