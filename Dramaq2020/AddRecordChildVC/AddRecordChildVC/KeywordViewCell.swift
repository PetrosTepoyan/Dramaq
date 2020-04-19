//
//  KeywordView.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 6/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class KeywordViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    
    func setKeywordView(keyword: PTKeywordsLabel) {
        
        
        for i in view.subviews{
            i.removeFromSuperview()
        }
        
        view.addSubview(keyword)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isHidden = true
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            contentView.leftAnchor.constraint(equalTo: leftAnchor),
//            contentView.rightAnchor.constraint(equalTo: rightAnchor),
//            contentView.topAnchor.constraint(equalTo: topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
    
}
