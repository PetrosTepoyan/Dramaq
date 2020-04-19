//
//  SummationConversion.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 23/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class SummationConversion: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var summationLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    let currencies = ["$ - USD", "€ - EUR", "£ - GBP", "₽ - RUB", "֏ - AMD"]
    var code: String? = "$"
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = currencies[row]
        code = currency[4...]
    }

}
