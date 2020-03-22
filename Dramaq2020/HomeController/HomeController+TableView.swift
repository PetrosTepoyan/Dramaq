//
//  HomeController+Extension.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 26/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import CoreData

#warning("Turn seaching to terniary operator")
extension HomeController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {   // Number of Secions
        if searching {
            return searchedRecord.count
        } else {
            guard !records.isEmpty else {
                setupEmptyRecordsView(message: "Press 'Add a record' button above to add your first record!")
                return records.count
            }
            removeEmptyRecordsView()
            return records.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // View for Date
        
        var datesForSections: [Date] = []
        if searching {
            datesForSections = searchedRecord.map { $0[0].date }
        } else {
            datesForSections = records.map { $0[0].date }
        }
        
        let dateView = DateSectionView(date: datesForSections[section])

        return dateView
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Number of Rows in Section
        
        guard records.count > 0 else { return 0 }
        
        if searching {
            return searchedRecord[section].count
        } else {
            return records[section].count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { 
        
        if cell.isHidden == true { cell.isHidden.toggle() }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var record: Record 
        
        if searching {
            record = searchedRecord[indexPath.section][indexPath.row]
        } else {
            record = records[indexPath.section][indexPath.row]
        }
        
        let view = RecordView(record: record)
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordViewCell", for: indexPath) as! RecordViewCell
        cell.setRecordView(record: view)
        
        
        
        cell.clipsToBounds = true
        cell.contentView.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        
        cell.selectionStyle = .none
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPress))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        cell.addGestureRecognizer(longPress)
        
        
        
        return cell
    }
    
    @objc func cellLongPress(gestureRecognizer: UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began {
            print("Long press")
                
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecordViewCell
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "showReviewViewController") as! ReviewViewController
        
        self.addChild(viewController)
        view.insertSubview(viewController.view, at: 9)
        viewController.didMove(toParent: self)
        
//        viewController.view.alpha = 0.0
        viewController.view.transform = CGAffineTransform(scaleX: 1, y: 0.1)
        viewController.view.center = cell.center
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let blurView = getBlurSetup()
        blurView.alpha = 0.0
        view.insertSubview(blurView, at: 8)
        setupCancelLabel()
        cancelLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.3, animations: {
            viewController.view.alpha     = 1.0
            viewController.view.transform = CGAffineTransform.identity
            self.cancelLabel.alpha        = 1.0
            blurView.alpha = 1.0
            

        }, completion: {finish in
            
        })
        
//        UIView.animate(withDuration: 0.3, animations: {
//            viewController.view.alpha     = 1.0
//            viewController.view.transform = CGAffineTransform.identity
//            self.cancelLabel.alpha        = 1.0
//            blurView.alpha = 1.0
//
//
//        }, completion: {finish in
//
//        })
        
        
        let recordView = cell.view.subviews[0] as! RecordView
        let id = recordView.id!
        let recordsFlattened = ManagingRealm().retrieveRecords_isDeletedIncluded().flatMap { $0 }.sorted(by: { $1.id > $0.id })
        let record = recordsFlattened[id]
        
        viewController.priceL   .text = "\(record.price)"
        viewController.placeL   .text = "\(record.place)"
        viewController.dateL    .text = "\(record.date.getDay()) | \(record.date.getTime())"
        viewController.keywordsL.text = "\(record.keywords?.joined(separator: ";") ?? "")"
        viewController.view.backgroundColor = UIColor(named: Category(rawValue: "\(record.category)")!.rawValue)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView,
      trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      ->   UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        delete.backgroundColor = .white
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        edit.backgroundColor = .white
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let record = records[indexPath.section][indexPath.row]
        
        let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            let id = record.id!
            
            try! self.realm.write {
                self.realm.objects(RealmRecord.self)[id].isDeleted = true
            }
            
            self.records[indexPath.section].remove(at: indexPath.row)
            
            if self.records[indexPath.section].isEmpty {
                self.records.remove(at: indexPath.section)
            }
            
            UIView.transition(with: self.tableView,
            duration: 0.35,
            options: [.curveEaseInOut, .transitionCrossDissolve],
            animations: { self.tableView.reloadData() })
            completion(true)
        }
        let image = UIImage(named: "Trash 2-2")
        action.image = image
        action.backgroundColor = .white
        
        
        return action
    }
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let record = records[indexPath.section][indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            let id = record.id!
            
            let childView = self.displayAddRecordChildVC(price: String(record.price), place: String(record.place), category: "\(record.category)", keywords: record.keywords)
            childView.idOfEditingRecord = id
            
        }
        let image = UIImage(named: "Edit-2")
        action.image = image
        action.backgroundColor = .white
        
        
        return action
    }
    
    
    
    func showingRecordsAnimation(){
        let chng1: CGFloat = 100.0
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.tableView.frame  = self.tableView.frame.offsetBy(dx: 0, dy: -270)
                self.arrowView.center.y -= 260
                self.arrowView.up()
                self.addARecord.center.x += 110
                self.addARecord.center.y -= 55
                self.analysisButton.center.y -= chng1
                self.accountButton.center.y -= chng1
                self.menuButton.center.y -= chng1
                self.addRecordView.alpha = 0
                self.searchField.center.y -= 290
                self.searchField.center.x -= 70
                
                
                self.view.layoutIfNeeded()
        }, completion: nil )
    }
    
    func hidingRecordsAnimation(){
        let chng1: CGFloat = 100.0
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.tableView.frame = self.tableView.frame.offsetBy(dx: 0, dy: 270)
                self.arrowView.center.y += 220
                self.arrowView.down()
                self.addARecord.center.x -= 110
                self.addARecord.center.y += 55
                self.analysisButton.center.y += chng1
                self.accountButton.center.y += chng1
                self.menuButton.center.y += chng1
                self.addRecordView.alpha = 1
                self.searchField.center.y += 290
                self.searchField.center.x += 70
                
                
                self.view.layoutIfNeeded()
                
        }, completion: {finish in
            self.searchField.endEditing(true)
        }
            
        )
    }
    
}

