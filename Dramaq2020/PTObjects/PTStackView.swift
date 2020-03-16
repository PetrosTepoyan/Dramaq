//
//  PTStackView.swift
//  Money Tracker
//
//  Created by Петрос Тепоян on 11/11/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTStackView: UIStackView {
    
}

extension UIStackView {

    func addBackground(color: UIColor, stackView: UIStackView) {
        let subview = UIView(frame: stackView.bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subview.layer.cornerRadius  = 25
        subview.layer.masksToBounds = true
        insertSubview(subview, at: 0)
        
        
        
    }
}
