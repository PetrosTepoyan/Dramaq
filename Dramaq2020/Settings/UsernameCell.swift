//
//  UsernameCell.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 23/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class UsernameCell: UITableViewCell {

    @IBOutlet weak var usernameTFOutlet: UITextField!
    @IBAction func usernameTF(_ sender: Any) {
        UserDefaults.standard.set(usernameTFOutlet.text, forKey: "Username")
    }
    
    @IBAction func usernameTFEditingChanged(_ sender: UITextField) {
        UserDefaults.standard.set(usernameTFOutlet.text, forKey: "Username")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
