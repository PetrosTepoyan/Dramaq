//
//  PTKeywordsLabel.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 25/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit

class PTKeywordsLabel: UILabel {
    
    var isSelected: Bool = false
    
    convenience init(text: String) {
        self.init()
        
        self.text = text
        setupKeywordLabel()
    }
    
    func setupKeywordLabel(isSelected: Bool = false){
        self.backgroundColor = isSelected ? UIColor.cyan : UIColor.gray.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        font = UIFont(name: Fonts.avenirNextMedium, size: 20)
        self.sizeToFit()
        
        
    }
    
    
    
}
