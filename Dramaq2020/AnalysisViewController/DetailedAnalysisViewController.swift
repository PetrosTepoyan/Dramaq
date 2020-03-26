//
//  DetailedAnalysisViewController.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 23/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import Charts

class DetailedAnalysisViewController: UIViewController, ChartViewDelegate {
    
    
    @IBOutlet weak var chart: CombinedChartView!
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    var optinos: [Option]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.delegate = self
        
        chart.chartDescription?.enabled = false
        
        chart.drawBarShadowEnabled = false
        chart.highlightFullBarEnabled = false
        
        
        chart.drawOrder = [DrawOrder.bar.rawValue,
                               DrawOrder.bubble.rawValue,
                               DrawOrder.candle.rawValue,
                               DrawOrder.line.rawValue,
                               DrawOrder.scatter.rawValue]
        
        let l = chart.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        //        chartView.legend = l
        
        let rightAxis = chart.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = chart.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        //xAxis.valueFormatter = self
        
//        self.updateChartData()
        
        // Do any additional setup after loading the view.
    }
    
    

}

enum Option {
    case toggleValues
    case toggleIcons
    case toggleHighlight
    case animateX
    case animateY
    case animateXY
    case saveToGallery
    case togglePinchZoom
    case toggleAutoScaleMinMax
    case toggleData
    case toggleBarBorders
    // CandleChart
    case toggleShadowColorSameAsCandle
    case toggleShowCandleBar
    // CombinedChart
    case toggleLineValues
    case toggleBarValues
    case removeDataSet
    // CubicLineSampleFillFormatter
    case toggleFilled
    case toggleCircles
    case toggleCubic
    case toggleHorizontalCubic
    case toggleStepped
    // HalfPieChartController
    case toggleXValues
    case togglePercent
    case toggleHole
    case spin
    case drawCenter
    // RadarChart
    case toggleXLabels
    case toggleYLabels
    case toggleRotate
    case toggleHighlightCircle
    
    var label: String {
        switch self {
        case .toggleValues: return "Toggle Y-Values"
        case .toggleIcons: return "Toggle Icons"
        case .toggleHighlight: return "Toggle Highlight"
        case .animateX: return "Animate X"
        case .animateY: return "Animate Y"
        case .animateXY: return "Animate XY"
        case .saveToGallery: return "Save to Camera Roll"
        case .togglePinchZoom: return "Toggle PinchZoom"
        case .toggleAutoScaleMinMax: return "Toggle auto scale min/max"
        case .toggleData: return "Toggle Data"
        case .toggleBarBorders: return "Toggle Bar Borders"
        // CandleChart
        case .toggleShadowColorSameAsCandle: return "Toggle shadow same color"
        case .toggleShowCandleBar: return "Toggle show candle bar"
        // CombinedChart
        case .toggleLineValues: return "Toggle Line Values"
        case .toggleBarValues: return "Toggle Bar Values"
        case .removeDataSet: return "Remove Random Set"
        // CubicLineSampleFillFormatter
        case .toggleFilled: return "Toggle Filled"
        case .toggleCircles: return "Toggle Circles"
        case .toggleCubic: return "Toggle Cubic"
        case .toggleHorizontalCubic: return "Toggle Horizontal Cubic"
        case .toggleStepped: return "Toggle Stepped"
        // HalfPieChartController
        case .toggleXValues: return "Toggle X-Values"
        case .togglePercent: return "Toggle Percent"
        case .toggleHole: return "Toggle Hole"
        case .spin: return "Spin"
        case .drawCenter: return "Draw CenterText"
        // RadarChart
        case .toggleXLabels: return "Toggle X-Labels"
        case .toggleYLabels: return "Toggle Y-Labels"
        case .toggleRotate: return "Toggle Rotate"
        case .toggleHighlightCircle: return "Toggle highlight circle"
        }
    }
}
