//
//  Arrow.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 27/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class Arrow: UIView {

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    let lft = UIView()
    let rgh = UIView()
    
    convenience init(init: Double){
        self.init()
        setup()
        
    }
    
    private func setup(){
        frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        addSubview(lft)
        addSubview(rgh)
        
        lft.layer.cornerRadius = 2.5
        rgh.layer.cornerRadius = 2.5

        lft.backgroundColor = UIColor(named: "Mercury")
        rgh.backgroundColor = UIColor(named: "Mercury")
        
        lft.frame = CGRect(x: 0, y: 20, width: 20, height: 5)
        rgh.frame = CGRect(x: 15, y: 20, width: 20, height: 5)
    }
    
    func rotate(angle: CGFloat) {
//        lft.layer.anchorPoint = self.center
//        rgh.layer.anchorPoint = self.center

        lft.transform = CGAffineTransform(rotationAngle: angle)
        rgh.transform = CGAffineTransform(rotationAngle: -angle)
    }

    func up(){
        rotate(angle: 0.3)
    }
    
    func down(){
        rotate(angle: -0.3)
    }
}
