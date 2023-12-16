//
//  HistoryViewController.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/15/23.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var dateTop: UILabel!
    @IBOutlet weak var timeTop: UILabel!
    @IBOutlet weak var dateLast: UILabel!
    @IBOutlet weak var timeLast: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "timeTop") {
            if let decoded = try? decoder.decode(DateComponents.self, from: data) {
                AppData.timeTop = decoded
                timeTop.text = AppData.dateTop.formatted(.dateTime)
            }
        } else {
            timeTop.text = "No data"
        }
        
        if let data = UserDefaults.standard.data(forKey: "dateTop") {
            if let decoded = try? decoder.decode(Date.self, from: data) {
                AppData.dateTop = decoded
                dateTop.text = "\t\(AppData.timeTop.second!) seconds"
            }
        } else {
            dateTop.text = "No data"
        }
        
        if let data = UserDefaults.standard.data(forKey: "timeLast") {
            if let decoded = try? decoder.decode(DateComponents.self, from: data) {
                AppData.timeLast = decoded
                timeLast.text = AppData.dateLast.formatted(.dateTime)
            }
        } else {
            timeLast.text = "No data"
        }
        
        if let data = UserDefaults.standard.data(forKey: "dateLast") {
            if let decoded = try? decoder.decode(Date.self, from: data) {
                AppData.dateLast = decoded
                dateLast.text = "\t\(AppData.timeLast.second!) seconds"
            }
        } else {
            dateLast.text = "No data"
        }
    }
}
