//
//  PieChart.swift
//  DemoBeagleApp
//
//  Created by Apple on 4/9/21.
//

import Foundation
import Beagle
import UIKit
import Charts

struct PieChart: ServerDrivenComponent {
    var dataset: [PieChartSlice]
    var valueTextColor: String?
    var valueTextSize: Float?
    var sliceSpace: Float?
    var isHoleNeeded: Bool?
    var holeRadius: Float?
    var holeColor: String?
    var holeText: String?
    var drawValuesEnabled: Bool?
    var sumExpression: Expression<Int>?
    var holeTextColor: String?
    var holeTextSize: Float?
    var width: Int?
    var height: Int?
    
    func toView(renderer: BeagleRenderer) -> UIView {
       return configPieChart()
    }
    
    func configPieChart() -> PieChartView {
        let pieChart = PieChartView()
        
        pieChart.frame.size.width = CGFloat(width ?? 100)
        pieChart.frame.size.height = CGFloat(height ?? 100)

        let legend = pieChart.legend
        legend.enabled = false
        
        pieChart.usePercentValuesEnabled = false
        pieChart.drawSlicesUnderHoleEnabled = false
        pieChart.holeRadiusPercent = CGFloat(holeRadius ?? 0)
        pieChart.transparentCircleRadiusPercent = 0
        pieChart.chartDescription!.enabled = false
        pieChart.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        pieChart.drawCenterTextEnabled = true
        pieChart.drawEntryLabelsEnabled = false

        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: holeText ?? "")
        pieChart.centerAttributedText = centerText;
        pieChart.rotationAngle = 0
        pieChart.rotationEnabled = true
        pieChart.highlightPerTapEnabled = true
        

        let entries =  dataset.map { pieChartSlice -> (PieChartDataEntry) in
            return (PieChartDataEntry(value: Double(pieChartSlice.percentage)))
        }
        
        let colors = dataset.map{pieChartSlice -> (UIColor) in
            return UIColor(hex: pieChartSlice.color)!
        }
        
        let set = PieChartDataSet(entries: entries)
        set.sliceSpace = CGFloat(self.sliceSpace ?? 0)
        set.colors = colors
        set.drawValuesEnabled = self.drawValuesEnabled ?? true
        set.selectionShift = 3.0
            
        let primaryAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.systemFont(ofSize: CGFloat(self.holeTextSize ?? 19), weight: .bold),
            .foregroundColor: UIColor(hex: self.holeTextColor ?? ""),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedText = NSMutableAttributedString(string: holeText ?? "", attributes: primaryAttributes)
        pieChart.centerAttributedText = attributedText
        
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        pieChart.highlightValue(nil)
        pieChart.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        return pieChart
    }
}

extension PieChart {
    enum CodingKeys: String, CodingKey {
        case dataset
        case valueTextColor
        case valueTextSize
        case sliceSpace
        case isHoleNeeded
        case holeRadius
        case holeColor
        case holeText
        case drawValuesEnabled
        case sumExpression
        case holeTextColor
        case holeTextSize
        case width
        case height
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dataset = try container.decodeIfPresent([PieChartSlice].self, forKey: .dataset)!
        valueTextColor = try container.decodeIfPresent(String.self, forKey: .valueTextColor)
        valueTextSize = try container.decodeIfPresent(Float.self, forKey: .valueTextSize)
        sliceSpace = try container.decodeIfPresent(Float.self, forKey: .sliceSpace)
        isHoleNeeded = try container.decodeIfPresent(Bool.self, forKey: .isHoleNeeded)
        holeRadius = try container.decodeIfPresent(Float.self, forKey: .holeRadius)
        holeColor = try container.decodeIfPresent(String.self, forKey: .holeColor)
        holeText = try container.decodeIfPresent(String.self, forKey: .holeText)
        drawValuesEnabled = try container.decodeIfPresent(Bool.self, forKey: .drawValuesEnabled)
        sumExpression = try container.decodeIfPresent(Expression<Int>.self, forKey: .sumExpression)
        holeTextColor = try container.decodeIfPresent(String.self, forKey: .holeTextColor)
        holeTextSize = try container.decodeIfPresent(Float.self, forKey: .holeTextSize)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
    }
}

class PieChartSlice: Decodable {
    let percentage: Float
    let color: String
}
