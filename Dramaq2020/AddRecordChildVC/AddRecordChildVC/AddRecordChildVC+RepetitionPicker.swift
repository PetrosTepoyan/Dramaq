//
//  AddRecordChildVC+RepetitionPicker.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 21/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import AKPickerView_Swift

extension AddRecordChildVC: AKPickerViewDelegate, AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return repetitionPatterns.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return repetitionPatterns[item]
    }
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        
        chosenRepetition = repetitionPatterns[item]
    }
    
    
    
    
}
