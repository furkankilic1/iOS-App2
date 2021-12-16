//
//  ChartVC.swift
//  FurkanKilic_HW2
//
//  Created by CTIS Student on 18.11.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit
import Charts

class ChartVC: UIViewController {
    
    // Charts
    let country = ["Turkey", "USA", "Brazil", "India"]
    // In Millions
    let cases = [25.0, 46.6, 21.9, 34.4]
    // In Thousands
    let deaths = [5.06, 7.55, 6.10, 4.61]
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
         barChartView.delegate = self as? ChartViewDelegate
         barChartView.noDataText = "You need to provide data for the chart."
         barChartView.chartDescription?.text = "Cases and Deaths"

         let legend = barChartView.legend
         legend.enabled = true
         legend.horizontalAlignment = .right
         legend.verticalAlignment = .top
         legend.orientation = .vertical
         legend.drawInside = true
         legend.yOffset = 10.0;
         legend.xOffset = 10.0;
         legend.yEntrySpace = 0.0;


         let xaxis = barChartView.xAxis
         xaxis.drawGridLinesEnabled = true
         xaxis.labelPosition = .bottom
         xaxis.centerAxisLabelsEnabled = true
         xaxis.valueFormatter = IndexAxisValueFormatter(values:self.country)
         xaxis.granularity = 1


         let leftAxisFormatter = NumberFormatter()
         leftAxisFormatter.maximumFractionDigits = 1

         let yaxis = barChartView.leftAxis
         yaxis.spaceTop = 0.35
         yaxis.axisMinimum = 0
         yaxis.drawGridLinesEnabled = false

         barChartView.rightAxis.enabled = false

         setChart()
        

    }
    
    func setChart() {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []

        for i in 0..<self.country.count {

            let dataEntry = BarChartDataEntry(x: Double(i) , y: self.cases[i])
            dataEntries.append(dataEntry)

            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.self.deaths[i])
            dataEntries1.append(dataEntry1)

        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Cases")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Deaths")

        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]

        let chartData = BarChartData(dataSets: dataSets)


        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3

        let groupCount = self.country.count
        let startYear = 0


        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)

        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)

        barChartView.notifyDataSetChanged()

        barChartView.data = chartData

        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)

        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)


    }
    
}
