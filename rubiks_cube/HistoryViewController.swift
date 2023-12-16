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
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: "dateTop") {
            if let decoded = try? decoder.decode(Date.self, from: data) {
                AppData.dateTop = decoded
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: "timeLast") {
            if let decoded = try? decoder.decode(DateComponents.self, from: data) {
                AppData.timeLast = decoded
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: "dateLast") {
            if let decoded = try? decoder.decode(Date.self, from: data) {
                AppData.dateLast = decoded
            }
        }
        
        dateTop.text = AppData.dateTop.formatted(.dateTime)
        timeTop.text = "\t\(AppData.timeTop.second!) seconds"
        dateLast.text = AppData.dateLast.formatted(.dateTime)
        timeLast.text = "\t\(AppData.timeLast.second!) seconds"
    }

}
