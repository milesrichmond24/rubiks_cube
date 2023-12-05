//
//  ViewController.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var _1: UIImageView!
    @IBOutlet weak var _2: UIImageView!
    @IBOutlet weak var _3: UIImageView!
    @IBOutlet weak var _4: UIImageView!
    @IBOutlet weak var _5: UIImageView!
    @IBOutlet weak var _6: UIImageView!
    @IBOutlet weak var _7: UIImageView!
    @IBOutlet weak var _8: UIImageView!
    @IBOutlet weak var _9: UIImageView!
    
    var currentSide: Int = 0
    var vertical: Int = 0
    var horizontal: Int = 0
    let c = Cube(6,3,3)
    
    let colorMap: [Int:UIColor] = [
        0 : UIColor.red,
        1 : UIColor.blue,
        2 : UIColor.brown,
        3 : UIColor.cyan,
        4 : UIColor.green,
        5 : UIColor.magenta
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSide()
    }
    
    func drawSide() {
        currentSide = getIndex()
        let side = c.state[currentSide]
        _1.backgroundColor = colorMap[side[0][0]]
        _2.backgroundColor = colorMap[side[0][1]]
        _3.backgroundColor = colorMap[side[0][2]]
        _4.backgroundColor = colorMap[side[1][0]]
        _5.backgroundColor = colorMap[side[1][1]]
        _6.backgroundColor = colorMap[side[1][2]]
        _7.backgroundColor = colorMap[side[2][0]]
        _8.backgroundColor = colorMap[side[2][1]]
        _9.backgroundColor = colorMap[side[2][2]]
    }
    
    @IBAction func move_up(_ sender: UIButton) {
        if(vertical >= 3) {
            vertical = 0
        } else {
            vertical+=1
        }
        
        drawSide()
    }
    @IBAction func move_down(_ sender: UIButton) {
        if(vertical <= 0) {
            vertical = 3
        } else {
            vertical-=1
        }
        
        drawSide()
    }
    @IBAction func move_left(_ sender: UIButton) {
        if(horizontal <= 0) {
            horizontal = 3
        } else {
            horizontal-=1
        }
        
        print(horizontal)
        
        drawSide()
    }
    @IBAction func move_right(_ sender: UIButton) {
        if(horizontal >= 3) {
            horizontal = 0
        } else {
            horizontal+=1
        }
        
        drawSide()
    }
    
    // Keeps a map of things in space
    // Not something that can be easily expanded in the future
    // Returns the index with the data of the side shown
    func getIndex() -> Int {
        let getRow = { (hPos: Int) -> [Int] in
            switch hPos {
            case 0: return [4,1,5,3]
            case 1: return [0,1,2,3]
            case 2: return [5,1,4,3]
            case 3: return [2,1,0,3]
            default: return [0,0,0,0]
            }
        }
        
        return getRow(horizontal)[vertical]
    }
}

