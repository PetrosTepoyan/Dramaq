//
//  CategoryView.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 30/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

enum Category: String, CaseIterable {
    case Food
    case Entertainment
    case Shop
    case Transportation
    case Traveling
    case Education
    case Medicine
    case Utilities
    case Sport
    case Religion
    case Beauty
    
    case Unknown
}

enum CategoryColors {
    static let Food = UIColor(named: Category.Food.rawValue)
    static let Entertainment = UIColor(named: Category.Entertainment.rawValue)
    static let Shop = UIColor(named: Category.Shop.rawValue)
}

class CategoryView: UIView {

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    var categoryIdentifier: Category = .Unknown
    
    convenience init(category: Category?){
        self.init()
        
        categoryIdentifier = category!
        
        let image: UIImage = UIImage(named: category!.rawValue + "Icon")!
        let name: String = category!.rawValue
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textAlignment = .center
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.frame = CGRect(x: 0, y: 0, width: 60, height: 80)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)

        frame = stackView.frame
        
        
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        super.touchesBegan(touches, with: event)
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.animate(withDuration: 0.2,
//                       delay: 0.0,
//                       usingSpringWithDamping: 10,
//                       initialSpringVelocity: 2,
//                       options: .allowUserInteraction,
//                       animations: {
//                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
//                        self.transform = CGAffineTransform(rotationAngle: 0.0)
//        },
//                       completion: nil)
//        super.touchesEnded(touches, with: event)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.animate(withDuration: 0.2,
//                       delay: 0.0,
//                       usingSpringWithDamping: 10,
//                       initialSpringVelocity: 2,
//                       options: .allowUserInteraction,
//                       animations: {
//                        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//                        self.transform = CGAffineTransform(rotationAngle: 0.13)
//        },
//                       completion: nil)
//    }
    
}
