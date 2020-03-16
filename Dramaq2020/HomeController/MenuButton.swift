//
//  MenuButton.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 27/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class MenuButton: PTButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton(){
        self.frame.size           = CGSize(width: 50, height: 50)
        self.backgroundColor      = .white
        self.layer.cornerRadius   = 25
        self.imageView!.tintColor = .black
    }
    
}
