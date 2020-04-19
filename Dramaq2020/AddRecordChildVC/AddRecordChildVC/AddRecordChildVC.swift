//
//  AddRecordChildVC.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 27/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
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
    var repeatingPicker = UIPickerView()
    
    var category: Category! = Category.Unknown
    var categoriesInCollection: [Category] = []
    var keywords: [String] = []

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
    
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceTF.delegate = self
        priceTF.becomeFirstResponder()

//        view.center.x = (parent as! HomeController).view.center.x

        
        scrollView.contentSize = scrollableView.frame.size
        view.clipsToBounds = true
        
        
        setupCurrecnyLabel()
        setupNearbyPlacesTableView()
        setupLoc()
        setupCategoryCollectionView()
        
        keywordsCollectionView.backgroundColor = .clear
        
        repeatingPicker.delegate = self
        repeatingPicker.dataSource = self
        repeatingPicker.frame = CGRect(x: keywordsCollectionView.frame.minX, y: keywordsCollectionView.frame.maxY + 5, width: keywordsCollectionView.frame.width, height: 70)
        scrollView.addSubview(repeatingPicker)
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
        
        let repPat = repetitionPatterns[repeatingPicker.selectedRow(inComponent: 0)]
        repetition = TimeInterval.getTimeInterval(str: repPat)
        
        
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
        
        try! realm.write {
            realm.add(myRec)
        }
        
        let theRecordToAdd = Record(id: id,
                                    price: price,
                                    place: place,
                                    date: Date(),
                                    category: category,
                                    keywords: keywords,
                                    currency: currency)
        
        
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

extension AddRecordChildVC {
    func playSound(sound: Sounds) {
        guard let soundsAreTurnedOn = UserDefaults.standard.value(forKey: "SoundsAreTurnedOn") else { return }
        guard soundsAreTurnedOn as! Bool else { return }
        guard let path = Bundle.main.path(forResource: sound.rawValue, ofType: nil) else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        } catch {
            print("Sound not found")
        }
    }
}
