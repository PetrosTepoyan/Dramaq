//
//  ReviewViewController.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 6/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class ReviewViewController: CompactChildViewController {
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var priceL: UILabel!
    @IBOutlet var placeL: UILabel!
    @IBOutlet var dateL: UILabel!
    @IBOutlet var keywordsL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        scrollView.contentSize = contentView.frame.size
        dragLabel.text = "Drag up to dismiss the record"
        // Do any additional setup after loading the view.
    }
    
    

}
