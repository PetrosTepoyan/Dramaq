//
//  PTTextField.swift
//  Money Tracker
//
//  Created by Петрос Тепоян on 3/11/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField(size: Int? = nil) {
        borderStyle           = .none
        layer.cornerRadius    = frame.size.height/2
        
        tintColor             = Colors.darkGrey
        textColor             = Colors.darkGrey
        font                  = UIFont(name: Fonts.avenirNextMedium, size: (CGFloat(size ?? 20)))
        backgroundColor       = UIColor.white.withAlphaComponent(0.7)
        autocorrectionType    = .no
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: Fonts.avenirNextMedium, size: (CGFloat(size ?? 20)))!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor(named: "Mercury")!,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        self.layer.masksToBounds = false
        self.layer.shadowColor     = UIColor.black.cgColor
        self.layer.shadowOpacity   = 0.2
        self.layer.shadowOffset    = CGSize(width: 0, height: 15)
        self.layer.shadowRadius    = 10
        
        leftView              = indentView
        leftViewMode          = .always
        
        
        
    }
    
    open func textFieldFading(alpha: CGFloat){
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.alpha = alpha
                
        })
    }
    
    func textFieldToPopBack(textField: PTTextField, by value: CGFloat){
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
            textField.center.y += -value
            }, completion: nil)
        
        UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: [],
        animations: {
            textField.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    func textFieldToPopOut(textField: PTTextField, by value: CGFloat){ //usually to textField.center.y += 80
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                textField.center.y += value
            }, completion: nil)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                textField.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: nil)
        
    }
    
    
}
