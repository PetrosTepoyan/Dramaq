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
        keyword.frame = CGRect(x: 5, y: 5, width: 100, height: 30)
        keyword.center.x = view.center.x
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isHidden = true
    }
    
}
