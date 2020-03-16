//
//  AccountViewController.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 13/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileImage.image = UIImage(named: "ProfileIcon")
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
    }
        
    
    

}
