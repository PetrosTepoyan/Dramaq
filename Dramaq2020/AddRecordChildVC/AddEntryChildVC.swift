//
//  AddEntryChildVC.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 15/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import RealmSwift
import AKPickerView_Swift

#warning("change scroll view from outlet to var and add to this class so that income would have it too")
class AddEntryChildVC: CompactChildViewController { // addrecordchildvc will inherit from this

    @IBOutlet weak var priceTF: PTTextField!
    @IBOutlet weak var placeTF: PTTextField!
    
    var repetitionPicker: AKPickerView! = AKPickerView()
    var chosenRepetition: String? = "None"
    let repetitionPatterns = ["None", "Daily", "Weekly", "Monthly", "Annualy"]

//    var specificDatePicker: 
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    let recordWillBeAddedFrame = CGRect(x: -150, y: 240, width: 1000, height: 1000)
    var idOfEditingRecord: Int!
    let currency = UserDefaults.standard.string(forKey: "CurrentCurrency")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func draggedView(_ sender: UIPanGestureRecognizer) {
        super.draggedView(sender)
        
        let parentHome = parent as! HomeController
        
        if sender.state == .began {         // The drag began
            priceTF.resignFirstResponder()
            placeTF.resignFirstResponder()
            
        }
        
        
        if sender.state == .changed {
            
            let VEViews = view.subviews.filter { $0 is UIVisualEffectView }
            
            if recordWillBeAddedFrame.contains(dragLabel.globalFrame!) {
                makeHapticTouchImpact(in: recordWillBeAddedFrame)
                
                guard VEViews.isEmpty else { return }
                manageBlurOnChildViewWithTheMessage(arg: 0)
                
            } else if super.recordWillBeDismissedFrame.contains(dragLabel.globalFrame!){
                guard VEViews.isEmpty else { return }
                manageBlurOnChildViewWithTheMessage(arg: 1)
                
            } else {
                manageBlurOnChildViewWithTheMessage(arg: 2)
                
            }
            
        }
        
    }
    
}

extension AddEntryChildVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repetitionPatterns.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repetitionPatterns[row]
    }
    
}

extension AddEntryChildVC {
    func addEntry(income: Entry, beingAt parentHome: HomeController) {
        
    }
    
    func manageBlurOnChildViewWithTheMessage(arg: Int) {
        //args :
        // 0 - add the blur with the message that record will be added
        // 1 - add the blur with the message that record will be dismissed
        // 2 - dismiss the blur with the message
        
        let message = PTLabel()
        if arg == 0 {
            message.text = "The record will be added"
        } else if arg == 1 {
            message.text = "The record will not be added"
        }
        message.frame = CGRect(origin: CGPoint(x: 0, y: 30), size: CGSize(width: view.frame.width, height: 100))
        message.textAlignment = .center
        message.numberOfLines = 2
        message.alpha = 0.0
        message.accessibilityIdentifier = "MessageOverBlur"

        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: 500, height: 600)
        
        if arg == 0 || arg == 1 {
            
            view.addSubview(blurView)
            view.addSubview(message)
            blurView.alpha = 0.0
            
            UIView.animate(withDuration: 0.2, animations: {
                blurView.alpha = 0.97
                message.alpha = 1
            })
            
            
            
        } else {
            
            for i in view.subviews {
                if i is UIVisualEffectView || i.accessibilityIdentifier == "MessageOverBlur"{
                    i.removeFromSuperview()
                    UIView.animate(withDuration: 0.3, animations: { i.alpha = 0.0 })
                    
                }
            }
            
        }
        
    }
}
