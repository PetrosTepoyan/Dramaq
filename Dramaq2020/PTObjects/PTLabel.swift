//
//  PTLabel.swift
//  Money Tracker
//
//  Created by Петрос Тепоян on 7/11/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    convenience init(fontSize: Int) {
        self.init()
        setupLabel()
    }
    
    private func setupLabel(fontSize: Int = 23) {
        font    = UIFont(name: Fonts.avenirNextMedium, size: CGFloat(fontSize))
    }

}
