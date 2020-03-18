//
//  ViewController.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 26/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation


class HomeController: UIViewController {
    
    @IBOutlet weak var addARecord: PTButton!
    @IBOutlet weak var menuButton: MenuButton!
    @IBOutlet weak var analysisButton: PTButton!
    @IBOutlet weak var accountButton: MenuButton!
    @IBOutlet weak var addRecordView: UIView!
    @IBOutlet weak var frequentStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UISearchBar!

    
    var records: [[Record]] = []
    var scrollViewIsShown: Bool = false
    let arrowView = Arrow()
    let cancelLabel = PTLabel()
    
    var searchedRecord = [[Record]]()
    var searching = false
    
    var locationManager:CLLocationManager!
    
    var latitude: Double!
    var longitude: Double!
    
    
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = ManagingRealm().retrieveRecords()
        
        tableView.showsVerticalScrollIndicator = false
        searchField.delegate = self
        setupAddRecordView()
        setupFrequentRecords()
        setupArrow()
        makeAnalysisButtonBeautiful()
        hideKeyboardWhenTouching()
        
        UserDefaults.standard.set("֏", forKey: "CurrentCurrency")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    
        searchField.backgroundColor = .clear
        searchField.showsScopeBar = false
        searchField.barStyle = .default
        searchField.searchBarStyle = .minimal
        
        
    }

    @IBAction func addARecordTouchUpInside(_ sender: Any) {
        
        var price: String? = nil
        var place: String? = nil
        var category: String? = nil
        var keywords: [String]? = nil
        
        if let frequentRecordTemp = (sender as? UITapGestureRecognizer)?.view{
            let frequentRecord = frequentRecordTemp as! FrequentRecord
            price = String(frequentRecord.price!)
            place = String(frequentRecord.place!)
            category = frequentRecord.category.map { $0.rawValue }
            
            // change FrequentRecord -> properties only are price place id
        }
        
        _ = displayAddRecordChildVC(price: price, place: place, category: category, keywords: keywords)
        
    }
    
    
    
}

extension HomeController {
    
    @objc func displayAddRecordChildVC(price: String? = nil, place: String? = nil, category: String? = nil, keywords: [String]? = nil) -> AddRecordChildVC{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "showAddRecordView") as! AddRecordChildVC
        
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        view.insertSubview(viewController.view, at: 9)
        viewController.didMove(toParent: self)
        
        viewController.view.alpha = 0.0
        viewController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        let blurView = getBlurSetup()
        
        setupCancelLabel()
        cancelLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.3, animations: {
            viewController.view.alpha     = 1.0
            viewController.view.transform = CGAffineTransform.identity
            self.cancelLabel.alpha        = 1.0
            self.view.insertSubview(blurView, at: 8)
            

        }, completion: {finish in
            
        })
        
        viewController.priceTF.text = price
        viewController.placeTF.text = place
        viewController.category = Category(rawValue: category ?? "Unknown")
        
        if let keywords = keywords {
            viewController.keywords = keywords
        }
        
        
        return viewController
    }
    
//    func add(_ child: UIViewController, frame: CGRect? = nil) {
//        addChild(child)
//        
//        if let frame = frame {
//            child.view.frame = frame
//        }
//        
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//    }
    
    func getBlurSetup(style: UIBlurEffect.Style? = nil) -> UIVisualEffectView{
        
        let blurEffect                                     = UIBlurEffect(style: style ?? .systemUltraThinMaterialLight)
        let blurView                                       = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame                                     = self.view.frame
        
        let tapGesture = UITapGestureRecognizer(target: blurView, action: #selector(UIView.endEditing))
        blurView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        return blurView
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    func editTableView() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
        tableView.endUpdates()
    }
    
    func setupAddRecordView() {
        addRecordView.layer.cornerRadius = 30
        addRecordView.layer.shadowColor = addRecordView.backgroundColor?.cgColor
        addRecordView.layer.shadowOpacity = 0.5
        addRecordView.layer.shadowOffset  = CGSize(width: 0, height: 15)
        addRecordView.layer.shadowRadius = 10
    }
    
    func hideKeyboardWhenTouching(){
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func setupArrow() {
        view.addSubview(arrowView)
        arrowView.center = addRecordView.center
        arrowView.center.y += 170
        arrowView.down()
    }
    
    func setupFrequentRecords(){
        
        let currentTime = Date()
        let time1 = currentTime.advanced(by: -60*30).getTime().toDate()
        let time2 = currentTime.advanced(by:  60*30).getTime().toDate()
    
        let label = PTLabel(fontSize: 14)
        label.text = "Dramaq will suggest you records, based on the data you provide"
        label.numberOfLines = 3
        label.textAlignment = .center
        
        frequentStack.addArrangedSubview(label)
        
        guard !records.isEmpty else { return }
        
        
        let frequentRecords = records.flatMap { $0 }.filter {
            ($0.date.getTime().toDate()) > time1 && ($0.date.getTime().toDate()) < time2
            
        }
        
        guard frequentRecords.count > 0 else { return }
        
        frequentStack.removeArrangedSubview(label)
        label.removeFromSuperview()
        
        let frequentRecord1 = FrequentRecord(record: frequentRecords[0])
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(addARecordTouchUpInside(_:)))
        frequentRecord1.addGestureRecognizer(tap1)
        frequentStack.addArrangedSubview(frequentRecord1)

        guard frequentRecords.count > 1 else { return }
        
        let frequentRecord2 = FrequentRecord(record: frequentRecords[1])
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(addARecordTouchUpInside(_:)))
        frequentRecord2.addGestureRecognizer(tap2)
        frequentStack.addArrangedSubview(frequentRecord2)
        
    }
    
    func setupCancelLabel(){
        view.addSubview(cancelLabel)
        cancelLabel.frame = CGRect(x: 30, y: 20, width: view.frame.width, height: 60)
        cancelLabel.text  = "Drag here to dimsiss the window"
        cancelLabel.font  = UIFont(name: Fonts.avenirNextMedium, size: 20)
    }
    
    func makeAnalysisButtonBeautiful(){
        
//        self.analysisButton.applyGradient(colours: [.purple, .blue])
//        self.analysisButton.titleLabel!.textColor = .white
//        self.analysisButton.clipsToBounds = true
//        self.analysisButton.layer.cornerRadius = 20
        
    }
    
    
    
}
