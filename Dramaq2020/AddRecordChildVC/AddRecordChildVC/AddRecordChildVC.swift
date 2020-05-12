//
//  AddRecordChildVC.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 27/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation
import AVFoundation

class AddRecordChildVC: AddEntryChildVC {
    
    
//    @IBOutlet weak var priceTF: PTTextField!
//    @IBOutlet weak var placeTF: PTTextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var keywordsTF: PTTextField!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    @IBOutlet weak var nearbyPlacesTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollableView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var cardButton: PurchaseMethodButton!
    var cashButton: PurchaseMethodButton!
    
    var category: Category! = Category.Unknown
    var categoriesInCollection: [Category] = []
    var keywords: [String] = []
    var suggestedKeywords: [String] = ["nails", "hair", "salon", "beauty", "barbershop","nails", "hair", "salon", "beauty", "barbershop"]

    var nearbyPlaces = [Place]() {
        didSet {
            DispatchQueue.main.async {
                self.nearbyPlacesTableView.reloadData()
                
            }
        }
    }
    
    
    var locationManager:CLLocationManager!
    var latitude: Double!
    var longitude: Double!
    
    var soundPlayer: AVAudioPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceTF.delegate = self
        priceTF.becomeFirstResponder()
        
        scrollView.addSubview(repetitionPicker)
        repetitionPicker.frame = CGRect(x: keywordsCollectionView.frame.minX, y: keywordsCollectionView.frame.maxY + 10, width: keywordsCollectionView.frame.width, height: 80)
        repetitionPicker.delegate = self
        repetitionPicker.dataSource = self
        repetitionPicker.pickerViewStyle = .flat
        repetitionPicker.interitemSpacing = 5
        repetitionPicker.reloadData()
        
        scrollView.contentSize = scrollableView.frame.size
        view.clipsToBounds = true
        
        setupCurrecnyLabel()
        setupNearbyPlacesTableView()
        setupLoc()
        setupCategoryCollectionView()
        
        
        
        keywordsCollectionView.backgroundColor = .clear
        keywordsCollectionView.delegate = self
        
        scrollView.delaysContentTouches = false
        nearbyPlacesTableView.delaysContentTouches = false
        
        setupPurchaseMethodButtons()
        
        
        
        
    }

    @objc func purchaseMethodButtonPressed(sender: PurchaseMethodButton) {
        if sender == cardButton {
            cashButton.backgroundColor = .white
            cardButton.backgroundColor = .systemBlue
        } else {
            cardButton.backgroundColor = .white
            cashButton.backgroundColor = .systemBlue
        }
    }
    
    func setupPurchaseMethodButtons(){
        cardButton = PurchaseMethodButton(frame: CGRect(x:repetitionPicker.frame.minX,
                                                       y: repetitionPicker.frame.maxY + 10,
                                                       width: 100, height: 80),
                                         method: .Card)
        cashButton = PurchaseMethodButton(frame: CGRect(x:repetitionPicker.frame.maxX - 100,
                                                       y: repetitionPicker.frame.maxY + 10,
                                                       width: 100, height: 80), method: .Cash)
        
        scrollView.addSubview(cardButton)
        scrollView.addSubview(cashButton)

        cashButton.addTarget(self, action: #selector(purchaseMethodButtonPressed), for: .touchUpInside)
        cardButton.addTarget(self, action: #selector(purchaseMethodButtonPressed), for: .touchUpInside)
        cashButton.backgroundColor = .systemBlue
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let color = UIColor(named: category.rawValue)
        view.backgroundColor = color
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
    @IBAction func keywordAddButtonTouchUpInside(_ sender: Any) {
        if keywordsTF.text != "" {
            keywords.append(keywordsTF.text ?? "Null")
            keywordsTF.text = ""
            keywordsCollectionView.reloadData()
        }
        
        
    }
    
    @objc override func draggedView(_ sender:UIPanGestureRecognizer){
        
        let parentHome = parent as! HomeController

        if sender.state == .ended {         // The drag ended
            let willAdd = recordWillBeAddedFrame.contains(dragLabel.globalFrame!)
            
            if willAdd {
                addRecord(parentHome)
                
            }
            super.draggedView(sender)
            
            let VEViews = view.subviews.filter { $0 is UIVisualEffectView }
            guard VEViews.isEmpty else { VEViews[0].removeFromSuperview() ; return }
        }
        
        super.draggedView(sender) // must be exectued at the end
        
    }
    
    
}

extension AddRecordChildVC {
    
    func addRecord(_ parentHome: HomeController) {
        
        
        var priceStr = priceTF.text
        let placeStr = placeTF.text
        var repetition: RealmOptional<Double>
        
        
        
        
        if priceStr == "" {
            priceStr = "0.0"
        }
        
        let price = Double((priceStr == "" ? "0.0" : priceStr)!)!
        let place = placeStr!
        
        let repPat = chosenRepetition!
//        repetition = TimeInterval.getTimeInterval(str: repPat)
        repetition = RealmOptional<Double>(60)
        var purchaseMeth: PurchaseMethods!
        
        
        if cardButton.backgroundColor!.resolvedColor(with: view.traitCollection) != UIColor.systemBackground.resolvedColor(with: view.traitCollection) {
            purchaseMeth = .Card
        } else {
            purchaseMeth = .Cash
        }
        
        guard idOfEditingRecord == nil else {
            let editingRecord = realm.objects(RealmRecord.self).filter("id = \(self.idOfEditingRecord!)")[0]
            
            try! realm.write {
                editingRecord.price    = price
                editingRecord.place    = place
                editingRecord.keywords = keywords.joined(separator: ";")
                editingRecord.category = "\(category!)"
                editingRecord.currency = currency
                editingRecord.username = "Petros Tepoyan"
                editingRecord.repeatsEachTimeInterval = repetition
                editingRecord.purchaseMethod = purchaseMeth.rawValue
            }
            
            parentHome.records = ManagingRealm().retrieveRecords()
            parentHome.tableView.reloadData()
            
            
            parentHome.cancelLabel.removeFromSuperview()
            
            return
        }
        
        
//        let id = max(realm.objects(RealmRecord.self).count, realm.objects(RealmIncome.self).count)
        let id = realm.objects(RealmRecord.self).count
        let myRec = RealmRecord()
        myRec.id       = id
        myRec.price    = price
        myRec.place    = place
        myRec.keywords = keywords.joined(separator: ";")
        myRec.date     = Date()
        myRec.category = "\(category!)"
        myRec.currency = currency
        myRec.username = "Petros Tepoyan"
        myRec.repeatsEachTimeInterval = repetition
        myRec.purchaseMethod = purchaseMeth.rawValue
        
        try! realm.write {
            realm.add(myRec)
        }
        
        let theRecordToAdd = Record(id: id,
                                    price: price,
                                    place: place,
                                    date: Date(),
                                    category: category,
                                    keywords: keywords,
                                    currency: currency,
                                    repeatsEachTimeInterval: repetition.value,
                                    purchaseMethod: purchaseMeth)
        
        
        if parentHome.entries.isEmpty {
            parentHome.entries.insert( [theRecordToAdd] , at: 0 )
        }
        else if parentHome.entries[0][0].date.getDay() != Date().getDay(){
            parentHome.entries.insert( [theRecordToAdd] , at: 0 )
        }
        else {
            parentHome.entries[0].insert( theRecordToAdd, at: 0 )
        }
        parentHome.tableView.reloadData()
        dismissTheWindow(parentHome)
        
        playSound(sound: .recordWasAdded)
        
        if let repetit = repetition.value {
            DramaqNotification.instantiateNotification(title: "Test", subtitle: "You planned to add", body: "Test", imageName: nil, repeatsEach: repetit, identifier: "EntryNotification.\(id)")
        }
        
        //
        
        print(Balance().moneyLeftToSpendToday())
    }
    
}


extension AddRecordChildVC {
    
    func categoryImagePressed(on categoryView: CategoryView) {
        
        let centerOfCategoryPressedX = (categoryView.globalFrame!.maxX + categoryView.globalFrame!.minX) / 2 - 50
        let centerOfCategoryPressedY = (categoryView.globalFrame!.maxY + categoryView.globalFrame!.minY) / 2 - 110
        let center = CGPoint(x: centerOfCategoryPressedX, y: centerOfCategoryPressedY)
        
        category = categoryView.categoryIdentifier
        if view.subviews[0].accessibilityIdentifier == "CategoryCircleView"{
            view.subviews[0].removeFromSuperview()
        }
        
        circleAnimation(color: category, from: center)
        
        categoryLabel.text = category.map { $0.rawValue }
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.backgroundColor = .white
    }
    
    func circleAnimation(color category: Category, from center: CGPoint){
        
        let color = UIColor(named: category.rawValue)
        let circleView = UIView(frame: CGRect(origin: center, size: CGSize(width: 50, height: 50)))
        circleView.accessibilityIdentifier = "CategoryCircleView"
        view.insertSubview(circleView, at: 0)
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = circleView.frame.size.height / 2
        circleView.backgroundColor = color!
        
        UIView.animate(withDuration: 0.3, animations: {
            circleView.transform = CGAffineTransform(scaleX: 20, y: 20)
        },completion: {finish in self.view.backgroundColor = color})
        
    }

    
    func scaleCategoryView(category: CategoryView, scale: CGFloat, angle: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: {
            category.transform = CGAffineTransform(scaleX: scale, y: scale)
            category.transform = CGAffineTransform(rotationAngle: angle)
            (category.subviews[0] as! UIStackView).arrangedSubviews[1].alpha = alpha
        })
    }
    
    
    
}



 

extension AddRecordChildVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        priceTF.resignFirstResponder()
        placeTF.becomeFirstResponder()
        return true
    }
    
}

extension AddRecordChildVC {
    func setupNearbyPlacesTableView() {
        nearbyPlacesTableView.clipsToBounds = true
        nearbyPlacesTableView.layer.cornerRadius = 20
        nearbyPlacesTableView.alpha = 0.0
        nearbyPlacesTableView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        nearbyPlacesTableView.canCancelContentTouches = false
    }
    
    func setupCategoryCollectionView(){
        categoriesInCollection = Category.allCases
        categoryCollectionView.backgroundColor = .clear
        
    }
    
    func setupCurrecnyLabel() {
        currencyLabel.text = String(Array(currency ?? "$")[0])
        currencyLabel.clipsToBounds = true
        currencyLabel.layer.cornerRadius = currencyLabel.frame.height / 2
        currencyLabel.layer.borderColor = UIColor.black.cgColor
        currencyLabel.layer.borderWidth = 1
    }
    
}


