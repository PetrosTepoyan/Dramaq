//
//  AnalysisViewController.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 7/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class AnalysisViewController: UIViewController{
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var magicView: UIView!
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    var category_sum: [String : Double]!
    let records = ManagingRealm().retrieveRecords()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recordsFlat = records.flatMap { $0 }
        let recordsTuple = recordsFlat.lazy.map { ($0.category, $0.price) }
        var category_prices_: [String : [Double]] = [:]
        
        for tuple in recordsTuple{
            let nestedPrices = recordsFlat.filter { $0.category == tuple.0}.map { $0.price }
            category_prices_["\(tuple.0)"] = nestedPrices
        }
        
        category_sum = Dictionary(uniqueKeysWithValues: category_prices_.map { key, value in (key,value.reduce(0, +))}
        )
        
        
        for i in category_sum {
            let chart = PieChartDataEntry(value: i.value)
            //chart.label = i.key
            
            numberOfDownloadsDataEntries.append(chart)
        }
        
        //        print(category_sum)
        
        print(Dictionary(uniqueKeysWithValues: category_sum.sorted { $1.key < $0.key } ))
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = [NSUIColor(named: "Shop")!, NSUIColor(named: "Food")!, NSUIColor(named: "Entertainment")!, NSUIColor(named: "Unknown")!]
        let sum = CountingUtilities().summation()
        pieChart.data = chartData
//        pieChart.centerText = "Total \(sum)"
        pieChart.centerAttributedText = NSAttributedString(string: "Total \(sum)", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.avenirNextMedium, size: 15)!])
        pieChart.animate(xAxisDuration: 0.3, yAxisDuration: 1, easingOption: .easeInOutCirc)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "Shop")!.cgColor, UIColor(named: "Food")!.cgColor, UIColor(named: "Entertainment")!.cgColor, UIColor(named: "Unknown")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        
        gradientLayer.locations = [0.1, 0.3, 0.5, 1]
//        gradientLayer.locations = [category_sum["Shop"]!/sum,
//                                   category_sum["Food"]!/sum,
//                                   category_sum["Entertainment"]!/sum,
//                                   category_sum["notSpecified"]!/sum] as [NSNumber]
//        print(gradientLayer.locations!)

        gradientLayer.frame = magicView.bounds
        
        magicView.layer.addSublayer(gradientLayer)
        magicView.clipsToBounds = true
        magicView.layer.cornerRadius = 30
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

        
        
    }
    
    
    
    
    
    
    
    
    
}
