//
//  CubeSquare.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import Foundation
import UIKit

class CubeSquare: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var s9: UIImageView!
    @IBOutlet weak var s8: UIImageView!
    @IBOutlet weak var s7: UIImageView!
    @IBOutlet weak var s6: UIImageView!
    @IBOutlet weak var s5: UIImageView!
    @IBOutlet weak var s4: UIImageView!
    @IBOutlet weak var s3: UIImageView!
    @IBOutlet weak var s2: UIImageView!
    @IBOutlet weak var s1: UIImageView!
    
    func setColors(_ data: [Int]) {
        s1.tintColor = colorMap[data[0]]
        s2.tintColor = colorMap[data[1]]
        s3.tintColor = colorMap[data[2]]
        s4.tintColor = colorMap[data[3]]
        s5.tintColor = colorMap[data[4]]
        s6.tintColor = colorMap[data[5]]
        s7.tintColor = colorMap[data[6]]
        s8.tintColor = colorMap[data[7]]
        s9.tintColor = colorMap[data[8]]
    }
    
    func clearColors() {
        s1.tintColor = UIColor.clear
        s2.tintColor = UIColor.clear
        s3.tintColor = UIColor.clear
        s4.tintColor = UIColor.clear
        s5.tintColor = UIColor.clear
        s6.tintColor = UIColor.clear
        s7.tintColor = UIColor.clear
        s8.tintColor = UIColor.clear
        s9.tintColor = UIColor.clear
    }
    
    func select(_ selected: Int) {
        switch(selected) {
        case 0:
            s1.backgroundColor = UIColor.gray
        case 1:
            s2.backgroundColor = UIColor.gray
        case 2:
            s3.backgroundColor = UIColor.gray
        case 3:
            s4.backgroundColor = UIColor.gray
        case 4:
            s5.backgroundColor = UIColor.gray
        case 5:
            s6.backgroundColor = UIColor.gray
        case 6:
            s7.backgroundColor = UIColor.gray
        case 7:
            s8.backgroundColor = UIColor.gray
        case 8:
            s9.backgroundColor = UIColor.gray
        default:
            print("error in selecting")
        }
    }
    
    func clearSelect(_ selected: Int) {
        switch(selected) {
        case 0:
            s1.backgroundColor = UIColor.clear
        case 1:
            s2.backgroundColor = UIColor.clear
        case 2:
            s3.backgroundColor = UIColor.clear
        case 3:
            s4.backgroundColor = UIColor.clear
        case 4:
            s5.backgroundColor = UIColor.clear
        case 5:
            s6.backgroundColor = UIColor.clear
        case 6:
            s7.backgroundColor = UIColor.clear
        case 7:
            s8.backgroundColor = UIColor.clear
        case 8:
            s9.backgroundColor = UIColor.clear
        default:
            print("error in selecting")
        }
    }
    
    let colorMap: [Int:UIColor] = [
        0 : UIColor.red,
        1 : UIColor.blue,
        2 : UIColor.brown,
        3 : UIColor.cyan,
        4 : UIColor.green,
        5 : UIColor.magenta
    ]
}
