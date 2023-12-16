//
//  AppData.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/15/23.
//

import Foundation

class AppData: Codable {
    static var timeTop: DateComponents = Calendar.current.dateComponents([.second], from: Date.now)
    static var dateTop: Date = Date.now
    static var timeLast: DateComponents =  Calendar.current.dateComponents([.second], from: Date.now)
    static var dateLast: Date = Date.now
}
