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
            self.updateLineChart()
        }
        
        self.title = file?.filename ?? "Report"
        
        // Code to mirror our structs
        let mirror = Mirror(reflecting: Hours.self)
        for child in mirror.children {
            print("key: \(String(describing: child.label)), value: \(child.value)")
        }
        
        lineChart.delegate = self
        let margins = view.safeAreaLayoutGuide
        print(margins.layoutFrame.size.width)
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(lineChart)
        
//        lineChart.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
//        lineChart.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//        lineChart.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//        lineChart.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
//        myView.heightAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 2.0).isActive = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lineChart.delegate = nil
        reports.removeAll()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateLineChart()
    }
    
    func updateLineChart() {var entries = [ChartDataEntry]()
        var labels = [String]()
        
        for x in 0..<reports.count {
            let val = Double(reports[x].entry) ?? 0.0
            entries.append(ChartDataEntry(x: Double(x), y: Double(val)))
            labels.append("\(x):00")
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        
        lineChart.xAxis.enabled = true
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        lineChart.xAxis.granularity = 1
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
