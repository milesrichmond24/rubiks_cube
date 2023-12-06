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
    
    func rotate(rType row: Bool, _ sender: UISwipeGestureRecognizer, sides: [Int], selected: [Int]) {
        if(row) {
            switch(sender.direction) {
            case .left:
                // For each side, select squares represented in selected
                var tempArr: [[Int]] = [[Int]]()
                for x in sides {
                    tempArr.append([Int]())
                    for y in selected {
                        tempArr[x].append(state[x][y / 3][y % 3])
                    }
                }
                print(tempArr)
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
