//
//  ViewController.swift
//  FinalProject
//
//  Created by Turk Erdin on 5/19/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

struct Files: Decodable {
    let files: [Filename]
}

struct Filename: Decodable {
    let filename: String
}

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    var files = [Filename]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            downloadJSON {
                self.listTableView.reloadData()
            }
            
            self.title = "Available Reports"
            
            listTableView.delegate = self
            listTableView.dataSource = self
        }
        
        func downloadJSON(completed: @escaping () -> ()) {
            files.removeAll()
            guard let url = URL(string: "http://24.4.79.131:8218") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                if error == nil {
                    do {
                        let jsonData = try JSONDecoder().decode(Files.self, from: data)
                        self.files = jsonData.files
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

    extension ListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showReport", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? ReportViewController {
                destination.file = files[listTableView.indexPathForSelectedRow?.row ?? 0]
            }
        }
    }

    extension ListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return files.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "listCell")
            cell.textLabel?.text = files[indexPath.row].filename
            return cell
        }
        
        
    }

