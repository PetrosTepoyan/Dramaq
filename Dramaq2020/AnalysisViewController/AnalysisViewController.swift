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

struct ChartCategory {
    var category: Category
    var categoryColor: UIColor { UIColor(named: category.rawValue)! }
    var sum: Double
    
}

class AnalysisViewController: UIViewController{
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var magicView: UIView!
    @IBOutlet weak var topCategoryLabel: PTLabel!
    @IBOutlet weak var lowerCategoryLabel: PTLabel!
    
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    var category_color_sum: [ChartCategory] = [ChartCategory]()
    var category_sum: [String : Double]!
    let records = ManagingRealm().retrieveRecords()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category_color_sum: [ChartCategory] = get_category_color_sum()
        guard !category_color_sum.isEmpty else { return }
        
        let maxSum = category_color_sum.max { (f, s) -> Bool in
            f.sum < s.sum
        }
        let minSum = category_color_sum.min { (f, s)
            -> Bool in
            f.sum > s.sum
        }
        
        topCategoryLabel.text = "On \(maxSum!.category.rawValue.lowercased()) you have spent \(maxSum!.sum)"
        topCategoryLabel.adjustsFontSizeToFitWidth = true
        lowerCategoryLabel.text = "On \(minSum!.category.rawValue.lowercased()) you have spent \(minSum!.sum)"
        lowerCategoryLabel.adjustsFontSizeToFitWidth = true
        
        if maxSum?.category == minSum?.category {
            lowerCategoryLabel.text = ""
        }
        
        numberOfDownloadsDataEntries = category_color_sum.map { PieChartDataEntry(value: $0.sum, label: $0.category.rawValue) }
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = category_color_sum.map { $0.categoryColor }
        
        let sum = CountingUtilities().summation()
        pieChart.data = chartData
        
        pieChart.centerAttributedText = NSAttributedString(string: "Total \(sum)", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.avenirNextMedium, size: 15)!])
        pieChart.animate(xAxisDuration: 0.3, yAxisDuration: 1, easingOption: .easeInOutCirc)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = category_color_sum.map { $0.categoryColor }
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
    
    
    func get_category_color_sum() ->  [ChartCategory]{
        let recordsFlat = records.flatMap { $0 }
        let recordsTuple = recordsFlat.lazy.map { ($0.category, $0.price) }
        var category_prices_: [String : [Double]] = [:]
        
        for tuple in recordsTuple{
            let nestedPrices = recordsFlat.filter { $0.category == tuple.0}.map { $0.price }
            category_prices_["\(tuple.0)"] = nestedPrices
        }
        
        category_sum = Dictionary(uniqueKeysWithValues: category_prices_.map { key, value in (key,value.reduce(0, +))})
        
        category_color_sum = category_sum.map {
            ChartCategory(category: Category(rawValue: $0.key)!, sum: $0.value)
        }
        
        return category_color_sum.sorted(by: { $0.category.rawValue < $1.category.rawValue }).filter { $0.sum > 0 }
    }

    
    
    
    
    
    
    
    
}
