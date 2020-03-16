//
//  SearchTextField.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 6/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField() {
        borderStyle           = .none
        layer.cornerRadius    = frame.size.height/2
        
        tintColor             = Colors.darkGrey
        textColor             = Colors.darkGrey
        font                  = UIFont(name: Fonts.avenirNextMedium, size: 16)
        backgroundColor       = UIColor.white.withAlphaComponent(0.7)
        autocorrectionType    = .no
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: Fonts.avenirNextMedium, size: 16)!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: Colors.darkGrey,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        let magnGlass = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        indentView.addSubview(magnGlass)
        magnGlass.center.x += 5
        self.layer.masksToBounds = false
        self.layer.shadowColor     = UIColor.black.cgColor
        self.layer.shadowOpacity   = 0.2
        self.layer.shadowOffset    = CGSize(width: 0, height: 15)
        self.layer.shadowRadius    = 10
        
        leftView              = indentView
        leftViewMode          = .always
        
        
        
    }
}
