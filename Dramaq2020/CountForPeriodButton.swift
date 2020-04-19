//
//  CountForPeriodButton.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 27/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class CountForPeriodButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(UIColor.systemBlue, for: .normal)
        backgroundColor     = .white
        titleLabel?.font    = UIFont(name: Fonts.avenirNextMedium,
                                     size: 30)
        titleLabel?.numberOfLines = 2
        layer.cornerRadius  = 15
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset  = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        super.contentVerticalAlignment = .top
        super.contentHorizontalAlignment = .leading
        super.contentEdgeInsets.left = 10
        super.contentEdgeInsets.top = 10
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
