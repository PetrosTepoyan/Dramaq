//
//  UIView+Extension.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 22/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func setBlurEffect(at index: Int) {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.layer.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 25
        blurEffectView.clipsToBounds = true

        
        self.insertSubview(blurEffectView, at: index)
    }
    
    func removeBlurEffect() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func fading(alpha: CGFloat) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            animations: {
                self.alpha = alpha
        })
    }
    
    func image() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

extension UIView {
    //@discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    //@discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame      = self.bounds
        gradient.colors     = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint   = CGPoint(x: 1, y: 1)
        gradient.locations  = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    
}

extension UIView {
    var globalFrame: CGRect? {
        
        let rootView = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
}

extension UIView {
    func scaleAnimation(scale: Double) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}
