//
//  KeywordCollectionViewCell.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 27/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for i in view.subviews {
            i.removeFromSuperview()
        }
    }
    
}
