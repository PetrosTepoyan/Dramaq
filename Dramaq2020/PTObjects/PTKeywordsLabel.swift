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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeywordLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupKeywordLabel()
        
    }
    
    func setupKeywordLabel(){
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        font = UIFont(name: Fonts.avenirNextMedium, size: 20)
        self.sizeToFit()
        
    }
    
    
}
