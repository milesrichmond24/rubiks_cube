//
//  cube.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import Foundation
import UIKit

struct Cube {
    var state: [[[Int]]] = [[[Int]]]()
    
    init(_ sides: Int, _ rows: Int, _ cols: Int) {
        for side in 0..<sides {
            state.append([[Int]]())
            for row in 0..<rows {
                state[side].append([Int]())
                for _ in 0..<cols {
                    state[side][row].append(Int.random(in: 0..<6))
                }
            }
        }
        
        print("Cube Initialized")
    }
    
    mutating func rotate(rType row: Bool, _ sender: UISwipeGestureRecognizer, sides: [Int], selected: [Int]) {
        if(row) {
            var tempArr: [Int] = [Int]()
            for x in sides {
                print("side included: \(x)")
                for y in selected {
                    print("selected side: \(y)")
                    tempArr.append(state[x][y / 3][y % 3])
                    
                }
            }
            print("tempArr: \(tempArr)")
            
            print("state:")
            print("side1: \(state[0])")
            print("side2: \(state[1])")
            print("side3: \(state[2])")
            print("side4: \(state[3])")
            print("side5: \(state[4])")
            print("side6: \(state[5])")
            
            switch(sender.direction) {
            case .left:
                var tempArr2 = [Int]()
                for x in 0..<sides.count {
                    for y in 0..<selected.count {
                        if((x + 1) * 3 + y >= tempArr.count) {
                            state[sides[x]][selected[y] / 3][selected[y] % 3] = tempArr[y]
                            tempArr2.append(tempArr[y])
                        } else {
                            state[sides[x]][selected[y] / 3][selected[y] % 3] = tempArr[(x + 1) * 3 + y]
                            tempArr2.append(tempArr[(x+1) * 3 + y])
                        }
                        
                    }
                }
                print("tempArr2: \(tempArr2)")
                
                print("state:")
                print("side1: \(state[0])")
                print("side2: \(state[1])")
                print("side3: \(state[2])")
                print("side4: \(state[3])")
                print("side5: \(state[4])")
                print("side6: \(state[5])")
            case .right:
                print("rotate right")
            default:
                print("invalid swipe")
            }
        } else {
            switch(sender.direction) {
            case .up:
                print("rotate up")
            case .down:
                print("rotate down")
            default:
                print("invalid swipe")
            }
        }
    }
    
    func doRotation() {
        
    }
}
