//
//  CustomPieChartView.swift
//  pbms
//
//  Created by Apple on 5/7/21.
//  Copyright © 2021 Pham Binh. All rights reserved.
//

import UIKit
import Charts
import Beagle

class CustomPieChartView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    var pieChart: PieChart!
    var controller: BeagleController?
    var sumOfItems: Int? {
        didSet {
            configLayout()
        }
    }
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
  
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
        fatalError("init(coder:) has not been implemented")
    }
    
    init (_ pieChart: PieChart, renderer: BeagleRenderer) {
        super.init(frame: .zero)
        self.pieChart = pieChart
        self.controller = renderer.controller
        
        renderer.observe(pieChart.sumExpression, andUpdate: \.sumOfItems, in: self)
        print("sumOfItemsvalue \(sumOfItems)")
        commitInit()
        
    }
    
    private func commitInit() {
        let bundle = Bundle(for: CustomPieChartView.self)
        bundle.loadNibNamed("CustomPieChartView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configLayout()
    }
    
    func configLayout() {
       
        let legend = pieChartView.legend
        legend.enabled = false
        
        pieChartView.usePercentValuesEnabled = true
        pieChartView.drawSlicesUnderHoleEnabled = false
        pieChartView.holeRadiusPercent = 0.58
        pieChartView.transparentCircleRadiusPercent = 0.61
        pieChartView.chartDescription!.enabled = false
        pieChartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        pieChartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "100 phản ánh")
        pieChartView.centerAttributedText = centerText;
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = true
        

//        let entries =  pieChart.dataset.map { pieChartSlice -> (PieChartDataEntry) in
//
//            return (PieChartDataEntry(value: Double(pieChartSlice.percentage.evaluate(with: originView)!) ?? 0.0))
//        }
        
//        let colors = pieChart.dataset.map{pieChartSlice -> (UIColor) in
//            return UIColor(hex: pieChartSlice.color)!
//        }
        
        
//        let set = PieChartDataSet(entries: entries)
//        set.sliceSpace = CGFloat(self.sliceSpace!)
//        set.colors = colors
//
//        let data = PieChartData(dataSet: set)
//        let pFormatter = NumberFormatter()
//        pFormatter.numberStyle = .percent
//        pFormatter.maximumFractionDigits = 1
//        pFormatter.multiplier = 1
//        pFormatter.percentSymbol = "%"
//        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
//
//        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
//        data.setValueTextColor(.white)
//        pieChartView.data = data
        pieChartView.highlightValue(nil)
        pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
       
    }
}
