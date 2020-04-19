//
//  RepetitionPickerView.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 17/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class RepetitionPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let repetitionPatterns = ["Daily", "Weekly", "Monthly", "Annualy"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repetitionPatterns.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repetitionPatterns[row]
    }
    
    override init(frame: CGRect) {
        self.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
