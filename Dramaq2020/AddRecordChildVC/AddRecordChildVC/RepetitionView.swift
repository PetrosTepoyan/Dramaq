//
//  RepetitionView.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 21/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class RepetitionView: UIView {

    var title: String!
    var identifier: String?
    
    convenience init(title: String) {
        self.init()
        
        self.title = title
        setupRepetitionView(title: title)
        
    }
    
    func setupRepetitionView(title: String) {
        
        let label = PTLabel(fontSize: 9)
        label.text = title
        addSubview(label)
        label.center = CGPoint(x: 10, y: 10)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: super.trailingAnchor)

        ])
        
        frame = CGRect(x: 0, y: 0, width: 90, height: 60)
        layer.cornerRadius = 15
        clipsToBounds      = false
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 30
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset  = CGSize(width: 0, height: 8)
        layer.shadowRadius  = 4
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: 90)
            
        ])
        
    }

}
