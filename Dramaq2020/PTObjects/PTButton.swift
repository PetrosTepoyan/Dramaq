//
//  PTButton.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 16/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        setTitleColor(Colors.darkGrey, for: .normal)
        backgroundColor     = .white
        titleLabel?.font    = UIFont(name: Fonts.avenirNextMedium, size: 20)
        layer.cornerRadius  = frame.size.height/2
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset  = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
    }

    func buttonScalingAnimation(scale: CGFloat){
        UIView.animate(
        withDuration: 0.05,
        animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        },
        completion: nil)
    }
    
    func buttonScalingAnimationNotAffine(scale: CGFloat){
        UIView.animate(
        withDuration: 0.1,
        animations: {
            self.frame.size.width     *= scale
            self.frame.size.height    *= scale
            self.center.x             *= 1/(scale)
        },
        completion: nil)
    }
    
    func buttonFading(alpha: CGFloat){
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.alpha = alpha
                
        })
    }
    
    var categoryCollection = [Category]()
    var categoryButtonCollection = [PTButton]()
    

    
}
