//
//  TrendingTagsChartViewController.swift
//  SAC
//
//  Created by Bala on 20/08/17.
//  Copyright © 2017 ShopAroundTheCorner. All rights reserved.
//

import UIKit
import Charts

class TrendingTagsChartViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let point1 = CGPoint(x: 0, y: 12)
        let point2 = CGPoint(x: 1, y: 16)
        let point3 = CGPoint(x: 3, y: 15)
        let point4 = CGPoint(x: 4, y: 13)        
        let numbers = [point1, point2, point3, point4]
        var lineChartEntry = [ChartDataEntry]()
        
        for point in numbers {
            let chartData = ChartDataEntry(x: Double(point.x), y: Double(point.y))
            lineChartEntry.append(chartData)
        }
        let line = LineChartDataSet(values: lineChartEntry, label: "Trends")
        let data = LineChartData()
        data.addDataSet(line)
        chartView.data = data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
