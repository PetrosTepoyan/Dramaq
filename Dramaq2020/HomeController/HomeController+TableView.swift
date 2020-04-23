//
//  HomeController+Extension.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 26/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

extension HomeController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {   // Number of Secions
        if searching {
            return searchedEntries.count
        } else {
            guard !entries.isEmpty else {
                setupEmptyRecordsView(message: "Press 'Add a record' button above to add your first record!")
                return entries.count
            }
            removeEmptyRecordsView()
            return entries.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // View for Date
        
        var datesForSections: [Date] = []
        if searching {
            datesForSections = searchedEntries.map { $0[0].date }
        } else {
            datesForSections = entries.map { $0[0].date }
        }
        
        let dateView = DateSectionView(date: datesForSections[section])

        let panGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        dateView.isUserInteractionEnabled = true
        dateView.addGestureRecognizer(panGesture)
        
        
        
        return dateView
        
        
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        let dateView = sender.view as! DateSectionView
        searchField.text = dateView.date.getDayExp()
        searchBar(searchField, textDidChange: searchField.text!)
        searchBarTextDidBeginEditing(searchField)
        searching = true
        tableView.reloadData()
        searchField.reloadInputViews()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Number of Rows in Section
        
        guard entries.count > 0 else { return 0 }
        
        
        if searching {
            return searchedEntries[section].count
        } else {
            return entries[section].count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { 
        
        if cell.isHidden == true { cell.isHidden.toggle() }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let entry = searching ? searchedEntries[indexPath.section][indexPath.row] : entries[indexPath.section][indexPath.row]
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordViewCell", for: indexPath) as! RecordViewCell
        var view: EntryView
        
        if entry is Record {
            view = RecordView(record: entry as! Record)
        } else {
            view = IncomeView(income: entry as! Income)
        }
        
        cell.setEntryView(entry: view)
        
//        if let entry = entry as? Record {
//            view = RecordView(record: entry)
//            cell.setRecordView(record: view as! RecordView)
//
//        } else {
//            view = IncomeView(income: entry as! Income)
//            cell.setIncomeView(income: view as! IncomeView)
//
//        }
        
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
        guard let cell = tableView.cellForRow(at: indexPath) as? RecordViewCell else { return }
        
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
        
        
        let recordView = cell.view.subviews[0] as? RecordView
        guard let id = recordView?.id! else { return }
        let recordsFlattened = ManagingRealm().retrieveRecords_isDeletedIncluded().flatMap { $0 }.sorted(by: { $1.id > $0.id })
        let record = recordsFlattened[id]
        
        viewController.priceL   .text = "\(record.price)"
        viewController.placeL   .text = "\(record.place)"
        viewController.dateL    .text = "\(record.date.getDay()) | \(record.date.getTime())"
        viewController.keywordsL.text = "\(record.keywords?.joined(separator: ";") ?? "")"
        viewController.viewCenter = cell.center
        viewController.view.backgroundColor = UIColor(named: Category(rawValue: "\(record.category!)")!.rawValue)
    }
    
    
    // MARK: - Non-related functions
    
    
    
}

