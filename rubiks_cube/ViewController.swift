//
//  ViewController.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//


// The following concepts are contained:
// Variables, operators, if/else, loops, switch, arrays, dictionaries, functions, classes, structs, persistance
// Button, Label, stack view, imageView, collectionView, viewController, alertController, tabBarController, GestureRecognizer, constraints
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    @IBOutlet var up_swipe: UISwipeGestureRecognizer!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentSide: Int = 3

    var selected: [Int] = [-1,-1,-1]
    var selectType: Bool = true
    
    var c = Cube(6,3,3)
    var timeStarted = Date.now
    
    let colorMap: [Int:UIColor] = [
        0 : UIColor.red,
        1 : UIColor.blue,
        2 : UIColor.brown,
        3 : UIColor.cyan,
        4 : UIColor.green,
        5 : UIColor.magenta
    ]
    
    let s0 = [0,1,2,9,10,11,18,19,20]
    let s1 = [3,4,5,12,13,14,21,22,23]
    let s2 = [27,28,29,36,37,38,45,46,47]
    let s3 = [30,31,32,39,40,41,48,49,50]
    let s4 = [33,34,35,42,43,44,51,52,53]
    let s5 = [57,58,59,66,67,68,75,76,77]
    
    let s2select1 = [29,38,47]
    let s2select2 = [27,36,45]
    let s4select1 = [33,42,51]
    let s4select2 = [35,44,53]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        up_swipe.delegate = self
        
        
        drawSide()
    }
    
    func drawSide() {
        collectionView.reloadData()
    }
    
    func selectSquares(indexPath: IndexPath) {
        if(!(s3.contains(indexPath.row) || ((s1.suffix(3).contains(indexPath.row) || s1.prefix(3).contains(indexPath.row))) || ((s2select1.contains(indexPath.row) || s2select2.contains(indexPath.row))) || ((s4select1.contains(indexPath.row) || s4select2.contains(indexPath.row))) || ((s5.prefix(upTo: 3).contains(indexPath.row) || s5.suffix(3).contains(indexPath.row))))) {
            return
        }
        
        if((((s1.suffix(3).contains(indexPath.row) || s1.prefix(3).contains(indexPath.row)) && selectType) || ((s2select1.contains(indexPath.row) || s2select2.contains(indexPath.row)) && !selectType) || ((s4select1.contains(indexPath.row) || s4select2.contains(indexPath.row)) && !selectType) || ((s5.prefix(upTo: 3).contains(indexPath.row) || s5.suffix(3).contains(indexPath.row)) && selectType))) {
            selectType = !selectType
        }
        
        let previous = selected
        //print(indexPath.row % 3)
        if(selectType) {
            if(indexPath.row / 9 % 3 == 2) {
                selected = [indexPath.row - 18, indexPath.row - 9, indexPath.row]
            } else if(indexPath.row / 9 % 3 == 0) {
                selected = [indexPath.row, indexPath.row + 9, indexPath.row + 18]
            } else {
                selected = [indexPath.row - 9, indexPath.row, indexPath.row + 9]
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
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let square = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! CubeSquare
        let empty1 = [6,7,8,15,16,17,24,25,26]
        let empty2 = [54,55,56,63,64,65,72,73,74]
        let empty3 = [60,61,62,69,70,71,78,79,80]

        if(empty1.contains(indexPath.row) || empty2.contains(indexPath.row) || empty3.contains(indexPath.row)) {
            square.clearColors()
        } else {
            
            if(s0.contains(indexPath.row)) {
                square.setColors(c.state[0][s0.firstIndex(of: indexPath.row)!])
            } else if(s1.contains(indexPath.row)) {
                square.setColors(c.state[1][s1.firstIndex(of: indexPath.row)!])
            } else if(s2.contains(indexPath.row)) {
                square.setColors(c.state[2][s2.firstIndex(of: indexPath.row)!])
            } else if(s3.contains(indexPath.row)) {
                square.setColors(c.state[3][s3.firstIndex(of: indexPath.row)!])
            } else if(s4.contains(indexPath.row)) {
                square.setColors(c.state[4][s4.firstIndex(of: indexPath.row)!])
            } else if(s5.contains(indexPath.row)) {
                square.setColors(c.state[5][s5.firstIndex(of: indexPath.row)!])
            }
        }
        
        if(selected.contains(indexPath.row)) {
            square.select(indexPath.row)
        } else {
            if(s0.contains(indexPath.row)) {
                square.s1.backgroundColor = UIColor.lightGray
            } else if(s1.contains(indexPath.row)) {
                square.s1.backgroundColor = UIColor.gray
            } else if(s2.contains(indexPath.row)) {
                square.s1.backgroundColor = UIColor.gray
            } else if(s3.contains(indexPath.row)) {
                square.s1.backgroundColor = UIColor.lightGray
            } else if(s4.contains(indexPath.row)) {
                square.s1.backgroundColor = UIColor.gray
            } else if(s5.contains(indexPath.row)) {
                square.s1.backgroundColor = UIColor.gray
            } else {
                square.s1.backgroundColor = UIColor.clear
            }
        }
        
        return square
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 9, height: collectionView.bounds.width / 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -2.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectSquares(indexPath: indexPath)
        print("selected: \(selected)")
        self.collectionView.reloadData()
    }
    
    @IBAction func up_swipe_action(_ sender: UISwipeGestureRecognizer) {
        if selected != [-1,-1,-1] {
            var squareSelected = [0,0,0]
            var side: Int
            
            if(s1.suffix(3).contains(selected[0]) || s1.prefix(3).contains(selected[0])) {
                print("invalid swipe")
                return
            } else if(s2select1.contains(selected[0]) || s2select2.contains(selected[0])) {
                squareSelected[0] = s2.firstIndex(of: selected[0])!
                squareSelected[1] = s2.firstIndex(of: selected[1])!
                squareSelected[2] = s2.firstIndex(of: selected[2])!
                side = 2
            } else if(s4select1.contains(selected[0]) || s4select1.contains(selected[0])) {
                squareSelected[0] = s4.firstIndex(of: selected[0])!
                squareSelected[1] = s4.firstIndex(of: selected[1])!
                squareSelected[2] = s4.firstIndex(of: selected[2])!
                side = 4
            } else if(s5.prefix(upTo: 3).contains(selected[0]) || s5.suffix(3).contains(selected[0])) {
                print("invalid swipe")
                return
            } else {
                squareSelected[0] = s3.firstIndex(of: selected[0])!
                squareSelected[1] = s3.firstIndex(of: selected[1])!
                squareSelected[2] = s3.firstIndex(of: selected[2])!
                c.rotate(!selectType, sender, currentSide, squareSelected)
                collectionView.reloadData()
                return
            }
            
            c.specialShiftUp(side, squareSelected)
            collectionView.reloadData()
        }
    }
    @IBAction func down_swipe_action(_ sender: UISwipeGestureRecognizer) {
        if selected != [-1,-1,-1] {
            var squareSelected = [0,0,0]
            var side: Int = 0

            if(s1.suffix(3).contains(selected[0]) || s1.prefix(3).contains(selected[0])) {
                print("invalid swipe")
                return
            } else if(s2select1.contains(selected[0]) || s2select2.contains(selected[0])) {
                squareSelected[0] = s2.firstIndex(of: selected[0])!
                squareSelected[1] = s2.firstIndex(of: selected[1])!
                squareSelected[2] = s2.firstIndex(of: selected[2])!
                side = 2
            } else if(s4select1.contains(selected[0]) || s4select1.contains(selected[0])) {
                squareSelected[0] = s4.firstIndex(of: selected[0])!
                squareSelected[1] = s4.firstIndex(of: selected[1])!
                squareSelected[2] = s4.firstIndex(of: selected[2])!
                side = 4
            } else if(s5.prefix(upTo: 3).contains(selected[0]) || s5.suffix(3).contains(selected[0])) {
                print("invalid swipe")
                return
            } else {
                squareSelected[0] = s3.firstIndex(of: selected[0])!
                squareSelected[1] = s3.firstIndex(of: selected[1])!
                squareSelected[2] = s3.firstIndex(of: selected[2])!
                c.rotate(!selectType, sender, currentSide, squareSelected)
                collectionView.reloadData()
                return
            }
            
            c.specialShiftDown(side, squareSelected)
            collectionView.reloadData()
            
        }
    }
    @IBAction func left_swipe_action(_ sender: UISwipeGestureRecognizer) {
        if selected != [-1,-1,-1] {
            var squareSelected = [0,0,0]
            var side: Int

            if(s1.suffix(3).contains(selected[0]) || s1.prefix(3).contains(selected[0])) {
                squareSelected[0] = s1.firstIndex(of: selected[0])!
                squareSelected[1] = s1.firstIndex(of: selected[1])!
                squareSelected[2] = s1.firstIndex(of: selected[2])!
                side = 1
            } else if(s2select1.contains(selected[0]) || s2select2.contains(selected[0])) {
                print("invalid swipe")
                return
            } else if(s4select1.contains(selected[0]) || s4select1.contains(selected[0])) {
                print("invalid swipe")
                return
            } else if(s5.prefix(upTo: 3).contains(selected[0]) || s5.suffix(3).contains(selected[0])) {
                squareSelected[0] = s5.firstIndex(of: selected[0])!
                squareSelected[1] = s5.firstIndex(of: selected[1])!
                squareSelected[2] = s5.firstIndex(of: selected[2])!
                side = 5
            } else {
                squareSelected[0] = s3.firstIndex(of: selected[0])!
                squareSelected[1] = s3.firstIndex(of: selected[1])!
                squareSelected[2] = s3.firstIndex(of: selected[2])!
                c.rotate(!selectType, sender, currentSide, squareSelected)
                collectionView.reloadData()
                return
            }

            c.specialShiftLeft(side, squareSelected)
            collectionView.reloadData()
        }
    }
    @IBAction func right_swipe_action(_ sender: UISwipeGestureRecognizer) {
        if selected != [-1,-1,-1] {
            var squareSelected = [0,0,0]
            var side: Int = 0
            if(s1.suffix(3).contains(selected[0]) || s1.prefix(3).contains(selected[0])) {
                squareSelected[0] = s1.firstIndex(of: selected[0])!
                squareSelected[1] = s1.firstIndex(of: selected[1])!
                squareSelected[2] = s1.firstIndex(of: selected[2])!
                side = 1
            } else if(s2select1.contains(selected[0]) || s2select2.contains(selected[0])) {
                print("invalid swipe")
                return
            } else if(s4select1.contains(selected[0]) || s4select1.contains(selected[0])) {
                print("invalid swipe")
                return
            } else if(s5.prefix(upTo: 3).contains(selected[0]) || s5.suffix(3).contains(selected[0])) {
                squareSelected[0] = s5.firstIndex(of: selected[0])!
                squareSelected[1] = s5.firstIndex(of: selected[1])!
                squareSelected[2] = s5.firstIndex(of: selected[2])!
                side = 5
            } else {
                squareSelected[0] = s3.firstIndex(of: selected[0])!
                squareSelected[1] = s3.firstIndex(of: selected[1])!
                squareSelected[2] = s3.firstIndex(of: selected[2])!
                c.rotate(!selectType, sender, currentSide, squareSelected)
                collectionView.reloadData()
                return
            }
            
            c.specialShiftRight(side, squareSelected)
            collectionView.reloadData()
        }
    }

    @IBAction func randomizeCube(_ sender: UIButton) {
        c = Cube(6,3,3)
        timeStarted = Date.now
        collectionView.reloadData()
    }
    
    @IBAction func finished(_ sender: UIButton) {
        if(c.isSolved()) {
            let timeTaken = Calendar.current.dateComponents([.second], from: timeStarted, to: Date.now)
            let ac = UIAlertController(title: "Congrats", message: "You comleted the cube in \(timeTaken.second!) seconds", preferredStyle: .alert)
            
            if(timeTaken.second! < AppData.timeTop.second!) {
                AppData.timeTop = timeTaken
                AppData.dateTop = Date.now
            }
            
            AppData.timeLast = timeTaken
            AppData.dateLast = Date.now
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(AppData.timeTop) {
                UserDefaults.standard.set(encoded, forKey: "timeTop")
            }
            if let encoded = try? encoder.encode(AppData.dateTop) {
                UserDefaults.standard.set(encoded, forKey: "dateTop")
            }
            if let encoded = try? encoder.encode(AppData.timeLast) {
                UserDefaults.standard.set(encoded, forKey: "timeLast")
            }
            if let encoded = try? encoder.encode(AppData.dateLast) {
                UserDefaults.standard.set(encoded, forKey: "dateLast")
            }
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Error", message: "Cube is not solved", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
}

