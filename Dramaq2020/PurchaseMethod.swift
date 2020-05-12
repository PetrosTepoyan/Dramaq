//
//  PurchaseMethod.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 24/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

enum PurchaseMethods: String, CaseIterable{
    case Cash
    case Card
}

class PurchaseMethodButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, method: PurchaseMethods) {
        super.init(frame: frame)
        setupButton(method: method)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    private func setupButton(method: PurchaseMethods) {
        
        backgroundColor     = .white
        layer.cornerRadius  = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset  = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        
        var buttonImage: UIImage
        switch method {
        case .Card:
            buttonImage = UIImage(named: "CreditCardSymbol")!
        default:
            buttonImage = UIImage(named: "CashSymbol")!
        }
        
        buttonImage = buttonImage.resizeImage(targetSize: CGSize(width: frame.width - 20, height: frame.height - 20))
        
        setImage(buttonImage, for: .normal)
        
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//        backgroundColor = .systemBlue
        
        super.pressesEnded(presses, with: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        },
                       completion: nil)

        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
        },
                       completion: nil)
        super.touchesEnded(touches, with: event)
    }


}
