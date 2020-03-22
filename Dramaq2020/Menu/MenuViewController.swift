//
//  MenuViewController.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 3/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController{
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    let currencyPickerData = ["$ - USD", "€ - EUR", "£ - GBP", "₽ - RUB", "֏ - AMD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
}

extension MenuViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return currencyPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerCurrency = String(Array(currencyPickerData[row])[0])
        UserDefaults.standard.set(pickerCurrency, forKey: "CurrentCurrency")
    }
    
}
