//
//  PTViewController.swift
//  MoneyTracker2020
//
//  Created by Петрос Тепоян on 16/12/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false

    }
    
    func setGradientBackground() {
        let colorTop =  Colors.orangeTop.cgColor
        let colorBottom = Colors.orangeBottom.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    

    
}
