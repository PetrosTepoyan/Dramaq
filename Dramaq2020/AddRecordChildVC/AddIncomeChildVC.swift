//
//  AddIncomeChildVC.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 15/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import RealmSwift

class AddIncomeChildVC: AddEntryChildVC {

//    @IBOutlet weak var priceTF: PTTextField!
//    @IBOutlet weak var placeTF: PTTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func draggedView(_ sender: UIPanGestureRecognizer) {
        
        let parentHome = parent as! HomeController

        if sender.state == .ended {         // The drag ended
            let willAdd = recordWillBeAddedFrame.contains(dragLabel.globalFrame!)
            
            if willAdd {
                addIncome(parentHome)
                
            }
            super.draggedView(sender)
            
            let VEViews = view.subviews.filter { $0 is UIVisualEffectView }
            guard VEViews.isEmpty else { VEViews[0].removeFromSuperview() ; return }
        }
        
        super.draggedView(sender) // must be executed at the end
    }
    

}

extension AddIncomeChildVC {
    func addIncome(_ parentHome: HomeController) {
        var price = priceTF.text
        let place = placeTF.text
        
//        guard idOfEditingRecord == nil else {
//            let editingRecord = realm.objects(RealmRecord.self).filter("id = \(self.idOfEditingRecord!)")[0]
//
//            try! realm.write {
//                editingRecord.price    = Double((price == "" ? "0.0" : price)!)!
//                editingRecord.place    = place!
//                editingRecord.keywords = keywords.joined(separator: ";")
//                editingRecord.category = "\(category!)"
//                editingRecord.currency = currency
//                editingRecord.username = "Petros Tepoyan"
//            }
//
//            parentHome.records = ManagingRealm().retrieveRecords()
//            parentHome.tableView.reloadData()
//
//
//            parentHome.cancelLabel.removeFromSuperview()
//
//            return
//        } ADD SUPPORT FOR CHANGIN THE INCOME 
        
        
//        let id = max(realm.objects(RealmRecord.self).count, realm.objects(RealmIncome.self).count)
        let id = realm.objects(RealmIncome.self).count
        let myRec = RealmIncome()
        myRec.id       = id
        myRec.price    = Double((price == "" ? "0.0" : price)!)!
        myRec.source    = place!
        
        myRec.date     = Date()
        myRec.currency = currency
        myRec.username = "Petros Tepoyan"
        
        try! realm.write {
            realm.add(myRec)
        }
        
        if price == "" {
            price = "0.0"
        }
        
        let theIncomeToAdd = Income(id: id,
                                    price: Double(price!)!,
                                    date: Date(),
                                    source: place!,
                                    currency: currency)
        
        
        if parentHome.entries.isEmpty {
            parentHome.entries.insert( [theIncomeToAdd] , at: 0 )
        }
        else if parentHome.entries[0][0].date.getDay() != Date().getDay(){
            parentHome.entries.insert( [theIncomeToAdd] , at: 0 )
        }
        else {
            parentHome.entries[0].insert( theIncomeToAdd, at: 0 )
        } 
        

        parentHome.tableView.reloadData()
        dismissTheWindow(parentHome)
    }
}
