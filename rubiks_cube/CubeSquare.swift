//
//  CubeSquare.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import Foundation
import UIKit

class CubeSquare: UICollectionViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var s1: UIImageView!
    
    func setColors(_ data: Int) {
        s1.tintColor = colorMap[data]
    }
    
    func clearColors() {
        s1.tintColor = UIColor.clear
    }
    
    func select(_ selected: Int) {
        s1.backgroundColor = UIColor.gray
    }
    
    func clearSelect(_ selected: Int) {
        s1.backgroundColor = UIColor.clear
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
