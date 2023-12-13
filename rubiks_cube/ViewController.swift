//
//  ViewController.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    @IBOutlet var up_swipe: UISwipeGestureRecognizer!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentSide: Int = 0
    var vertical: Int = 0
    var horizontal: Int = 0
    var selected: [Int] = [-1,-1,-1]
    var selectType: Bool = true
    
    var c = Cube(6,3,3)
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        up_swipe.delegate = self
        
        
        drawSide()
    }
    
    func drawSide() {
        currentSide = getIndex()
        collectionView.reloadData()
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
            case 0: return [0,1,2,3]
            case 1: return [5,1,4,3]
            case 2: return [2,1,0,3]
            case 3: return [4,1,5,3]
            default: return [0,0,0,0]
            }
        }
        
        return getRow(horizontal)[vertical]
    }
    
    // Gets the sides along the horizontal (right, back, left)
    func getHorizontalSides(vPos: Int) -> [Int] {
        switch vPos {
        case 0: return [4,0,5,2]
        case 1: return [0,1,2,1]
        case 2: return [5,1,4,0]
        case 3: return [3,3,3,3]
        default: return [0,0,0,0]
        }
    }
    
    // Gets the sides along the vertical (up, back, down)
    func getVerticalSides(hPos: Int) -> [Int] {
        switch hPos {
        case 0: return [4,1,5,3]
        case 1: return [0,1,2,3]
        case 2: return [5,1,4,3]
        case 3: return [2,1,0,3]
        default: return [0,0,0,0]
        }
    }
    
    func selectSquares(indexPath: IndexPath) {
        let previous = selected
        print(indexPath.row % 3)
        if(selectType) {
            if(indexPath.row + 3 > 8) {
                selected = [indexPath.row - 6, indexPath.row - 3, indexPath.row]
            } else if(indexPath.row - 3 < 0) {
                selected = [indexPath.row, indexPath.row + 3, indexPath.row + 6]
            } else {
                selected = [indexPath.row - 3, indexPath.row, indexPath.row + 3]
            }
        } else {
            if(indexPath.row % 3 >= 2) {
                selected = [indexPath.row - 2, indexPath.row - 1, indexPath.row]
            } else if(indexPath.row % 3 <= 0) {
                selected = [indexPath.row, indexPath.row + 1, indexPath.row + 2]
            } else {
                selected = [indexPath.row - 1, indexPath.row, indexPath.row + 1]
            }
        }
        
        if(previous == selected) {
            selectType = !selectType
            selectSquares(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let square = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! CubeSquare
        square.squareColor.tintColor = colorMap[c.state[getIndex()][indexPath.row]]
        
        if(selected.contains(indexPath.row)) {
            square.squareColor.backgroundColor = UIColor.gray
        } else {
            square.squareColor.backgroundColor = UIColor.clear
        }
        return square
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectSquares(indexPath: indexPath)
        print(selected)
        
        self.collectionView.reloadData()
    }
    @IBAction func up_swipe_action(_ sender: UISwipeGestureRecognizer) {
        
        if selected != [-1,-1,-1] {
            c.rotate(!selectType, sender, currentSide, selected)
            collectionView.reloadData()
        }
    }
    @IBAction func down_swipe_action(_ sender: UISwipeGestureRecognizer) {
        if selected != [-1,-1,-1] {
            c.rotate(!selectType, sender, currentSide, selected)
            collectionView.reloadData()
        }
    }
    @IBAction func left_swipe_action(_ sender: UISwipeGestureRecognizer) {
        print("current side: \(currentSide)")
        if selected != [-1,-1,-1] {
            c.rotate(!selectType, sender, currentSide, selected)
            collectionView.reloadData()
        }
    }
    @IBAction func right_swipe_action(_ sender: UISwipeGestureRecognizer) {
        if selected != [-1,-1,-1] {
            c.rotate(!selectType, sender, currentSide, selected)
            collectionView.reloadData()
        }
        
    }
}

