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

class AddRecordChildVC: CompactChildViewController {
    
    
    @IBOutlet weak var priceTF: PTTextField!
    @IBOutlet weak var placeTF: PTTextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var upperStack: UIStackView!
    @IBOutlet weak var lowerStack: UIStackView!
    @IBOutlet weak var keywordsTF: PTTextField!
    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var nearbyPlacesTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollableView: UIView!
    
    var category: Category! = Category.Unknown
    var keywords: [String] = []
    var nearbyPlaces = [Place]() {
        didSet {
            DispatchQueue.main.async {
                self.nearbyPlacesTableView.reloadData()
                
            }
        }
    }
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    var locationManager:CLLocationManager!
    var latitude: Double! = 40.193391
    var longitude: Double! = 44.503770
    
    var idOfEditingRecord: Int!
    
    let recordWillBeAddedFrame = CGRect(x: -150, y: 240, width: 1000, height: 1000)
    let recordWillBeDismissedFrame = CGRect(x: -150, y: -40, width: 1000, height: 120)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTF.delegate = self
        priceTF.becomeFirstResponder()
        
        scrollView.contentSize = scrollableView.frame.size
        upperStack.spacing = 30
        lowerStack.spacing = 30
        
        setupCategoryImages()
        
        view.clipsToBounds = true
        
        
        setupNearbyPlacesTableView()
        setupLoc()
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let color = UIColor(named: category.rawValue)
        view.backgroundColor = color
    }
    
    @IBAction func keywordAddButtonTouchUpInside(_ sender: Any) {
        print(keywords)
        keywords.append(keywordsTF.text ?? "Null")
        keywordsTF.text = ""
        
        keywordTableView.reloadData()
        
    }
    
    @objc override func draggedView(_ sender:UIPanGestureRecognizer){
        
        self.view.bringSubviewToFront(view)
        let translation = sender.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        let vCTR = view.center
        let parentHome = parent as! HomeController
        
        if sender.state == .began {         // The drag began
            priceTF.resignFirstResponder()
            placeTF.resignFirstResponder()
            
        }
        
        if sender.state == .changed {
            let VEViews = view.subviews.filter { $0 is UIVisualEffectView }
            
            
            if recordWillBeAddedFrame.contains(dragLabel.globalFrame!) {
                guard VEViews.isEmpty else { return }
                manageBlurOnChildViewWithTheMessage(arg: 0)
                
            } else if recordWillBeDismissedFrame.contains(dragLabel.globalFrame!){
                guard VEViews.isEmpty else { return }
                manageBlurOnChildViewWithTheMessage(arg: 1)
                
            } else {
                manageBlurOnChildViewWithTheMessage(arg: 2)
                
            }
            
            
            
        }
        
        
        if sender.state == .ended {         // The drag ended
            addTheRecord(parentHome)
            dismissTheWindow(vCTR, parentHome)
            
            viewGetBackAnimation()
            parentHome.tableView.reloadData()
            
            let VEViews = view.subviews.filter { $0 is UIVisualEffectView }
            guard VEViews.isEmpty else { VEViews[0].removeFromSuperview()
                return }
            
            
        }
    }
    
    
}
extension AddRecordChildVC {
    
    func addTheRecord(_ parentHome: HomeController) {
        
        
        if recordWillBeAddedFrame.contains(dragLabel.globalFrame!) {
            
            removeBlurFromParentView() // <- code repeats
            viewToDissapear()
            parentHome.cancelLabel.removeFromSuperview()
            
            var price = priceTF.text
            let place = placeTF.text
            
            guard idOfEditingRecord == nil else {
                let editingRecord = realm.objects(RealmRecord.self).filter("id = \(self.idOfEditingRecord!)")[0]
                
                try! realm.write {
                    editingRecord.price    = Double((price == "" ? "0.0" : price)!)!
                    editingRecord.place    = place!
                    editingRecord.keywords = keywords.joined(separator: ";")
                    editingRecord.category = "\(category!)"
                    editingRecord.currency = currency
                    editingRecord.username = "Petros Tepoyan"
                }
                
                parentHome.records = ManagingRealm().retrieveRecords()
                
                parentHome.tableView.reloadData()
                
                
                parentHome.cancelLabel.removeFromSuperview()
                
                return
            }
            
            
            let id = realm.objects(RealmRecord.self).count
            
            let myRec = RealmRecord()
            myRec.id       = id
            myRec.price    = Double((price == "" ? "0.0" : price)!)!
            myRec.place    = place!
            myRec.keywords = keywords.joined(separator: ";")
            myRec.date     = Date()
            myRec.category = "\(category!)"
            myRec.currency = currency
            myRec.username = "Petros Tepoyan"
            
            try! realm.write {
                realm.add(myRec)
            }
            
            if price == "" {
                price = "0.0"
            }
            
            let theRecordToAdd = Record(id: id,
                                        price: Double(price!)!,
                                        place: place!,
                                        date: Date(),
                                        category: category,
                                        keywords: keywords,
                                        currency: currency)
            
            print("The record will be added", theRecordToAdd)
            
            guard parentHome.records.count != 0 else {
                parentHome.records.insert( [theRecordToAdd] , at: 0 )
                
                return
            }
            
            if parentHome.records[0][0].date.getDay() != Date().getDay(){
                parentHome.records.insert( [theRecordToAdd] , at: 0 )
            }
            else {
                parentHome.records[0].insert( theRecordToAdd, at: 0 )
            }
            
            parentHome.tableView.reloadData()
            parentHome.cancelLabel.removeFromSuperview()
            
            
            
            
            
        }
    }
    
    fileprivate func dismissTheWindow(_ vCTR: CGPoint, _ parentHome: HomeController) {
        
        if recordWillBeDismissedFrame.contains(dragLabel.globalFrame!) {
            removeBlurFromParentView()
            viewToDissapear()
            parentHome.cancelLabel.removeFromSuperview()
            
            
        }
    }
    
    
    
    
    
}


extension AddRecordChildVC {
    
    func removeBlurFromParentView() {
        let blurView = (parent as! HomeController).view.subviews.filter { $0 is UIVisualEffectView }[0]
        blurView.removeFromSuperview()
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
                    UIView.animate(withDuration: 0.3, animations: {
                        i.alpha = 0.0
                    })
                    
                }
            }
            
        }
        
    }
    
    
    func setupCategoryImages() {
        let defaultCategoriesUpperStack = [Category.Food, Category.Entertainment, Category.Shop, Category.Transportation]
        let defaultCategoriesLowerStack = [Category.Sport, Category.Education, Category.Medicine]
        let defaultCategories = [defaultCategoriesUpperStack, defaultCategoriesLowerStack]
        let stacks = [upperStack!, lowerStack! ]
        
        for (ind, stack) in defaultCategories.enumerated() {
            for i in stack {
                let categoryView = CategoryView(category: i)
                (categoryView.subviews[0] as! UIStackView).arrangedSubviews[1].alpha = 0.0
                stacks[ind].addArrangedSubview(categoryView)
//                categoryView.frame.size.height = 60
//                categoryView.frame.size.width  = 50
                categoryView.translatesAutoresizingMaskIntoConstraints = false
                categoryView.heightAnchor.constraint(equalToConstant: 60).isActive = true
                categoryView.widthAnchor.constraint(equalToConstant: 50).isActive = true
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(categoryImagePressedOnTap))
                
                categoryView.addGestureRecognizer(tapGesture)
            }
            
        }
        
        let hover = UIPanGestureRecognizer(target: self, action: #selector(hovering(_:)))
        hover.delaysTouchesBegan = false
        upperStack.addGestureRecognizer(hover)
        
        upperStack.center.x = priceTF.center.x
        
        
    }
    
    @objc func categoryImagePressedOnTap(_ sender: UITapGestureRecognizer){
        let categoryPressed = sender.view! as! CategoryView
        
        categoryImagePressed(on: categoryPressed)
        
    }
    
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
    
    @objc func hovering(_ recognizer: UIPanGestureRecognizer) {
        
        let upperStack = recognizer.view! as! UIStackView
        let categoryViews = upperStack.arrangedSubviews as! [CategoryView]
        switch recognizer.state {
            
        case .changed:
            var location = recognizer.location(in: self.view)
            location = CGPoint(x: location.x + 10, y: location.y + 70)
            
            for categ in categoryViews {
                if categ.globalFrame!.contains(location) {
                    scaleCategoryView(category: categ, scale: 1.2, angle: 0.13, alpha: 1)
                } else {
                    scaleCategoryView(category: categ, scale: 1, angle: 0.0, alpha: 0)
                }
            }
            
        case .ended:
            
            for categ in categoryViews {
                scaleCategoryView(category: categ, scale: 1, angle: 0.0, alpha: 0)
                //                if categ.globalFrame!.contains(location) {
                //                    scaleCategoryView(category: categ, scale: 1.2, angle: 0.13)
                //                }  detect which category is hover
            }
            
        default:
            break
        }
        
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
        nearbyPlacesTableView.layer.cornerRadius = 30
        nearbyPlacesTableView.alpha = 0.0
        nearbyPlacesTableView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        nearbyPlacesTableView.canCancelContentTouches = false
    }
}
