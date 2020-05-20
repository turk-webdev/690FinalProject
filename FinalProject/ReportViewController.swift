//
//  ReportViewController.swift
//  FinalProject
//
//  Created by Turk Erdin on 5/19/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit
import Charts

struct Report: Decodable {
    let report: [Entries]
}

struct Entries: Decodable {
    let entry: String
}

class ReportViewController: UIViewController, ChartViewDelegate {
    var file: Filename?
    var reports = [Entries]()
    var lineChart = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.lineChart.notifyDataSetChanged()
        }
        
        self.title = file?.filename ?? "Report"
        
        // Code to mirror our structs
        let mirror = Mirror(reflecting: Hours.self)
        for child in mirror.children {
            print("key: \(String(describing: child.label)), value: \(child.value)")
        }
        
        lineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<reports.count {
            let val = Double(reports[x].entry) ?? 0.0
            entries.append(ChartDataEntry(x: Double(x), y: Double(val)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }

    func downloadJSON(completed: @escaping () -> ()) {
        guard let fileString = file?.filename else { return }
        guard let url = URL(string: "http://24.4.79.131:8218/?file="+fileString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if error == nil {
                do {
                    let obj = try JSONDecoder().decode(Report.self, from: data)
                    self.reports = obj.report
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch let jsonErr {
                    print("Error in downloading JSON: \(jsonErr)")
                }
            }
        }.resume()
    }
}
