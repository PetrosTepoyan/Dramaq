//
//  CategoryView.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 30/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

enum Category: String {
    case Food
    case Entertainment
    case Shop
    case Transportation
    case Traveling
    case Education
    case Medicine
    case Utilities
    case Sport
    
    
    case Unknown
}

enum CategoryColors {
    static let Food = UIColor(named: Category.Food.rawValue)
    static let Entertainment = UIColor(named: Category.Entertainment.rawValue)
    static let Shop = UIColor(named: Category.Shop.rawValue)
}

//enum CategoryImages{ // substitute each color to an image
//    static let Food = UIImage(named: Category.Food.rawValue + "Icon")
//    static let Entertainment  = UIImage(named: Category.Entertainment.rawValue + "Icon")
//    static let Shop = UIImage(named: Category.Shop.rawValue + "Icon")
//
//    static let notSpecified = UIColor(named: "notSpecified")
//
//}

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
    
    
}
