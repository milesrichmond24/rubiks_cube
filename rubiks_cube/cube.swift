//
//  cube.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import Foundation
import UIKit

struct Cube {
    var state: [[Int]] = [[Int]]()
    
    init(_ sides: Int, _ rows: Int, _ cols: Int) {
        for side in 0..<sides {
            state.append([Int]())
            for _ in 0..<rows*cols {
                    state[side].append(Int.random(in: 0..<6))
            }
        }
        
        print("Cube Initialized")
    }
    
    mutating func rotate(_ isRow: Bool, _ sender: UISwipeGestureRecognizer, _ currentSide: Int, _ selected: [Int]) {
        if(isRow) {
            switch(sender.direction) {
            case .left:
                shiftLeft(currentSide, selected, isRow)
            case .right:
                shiftRight(currentSide, selected, isRow)
            default:
                print("invalid swipe")
            }
        } else {
            switch(sender.direction) {
            case .up:
                shiftUp(currentSide, selected, isRow)
            case .down:
                shiftDown(currentSide, selected, isRow)
            default:
                print("invalid swipe")
            }
        }
    }
    
    func mapHorizontalSides(_ currentSide: Int) -> [Int] {
      switch(currentSide) {
      case 0:
          return [0,5,2,4]
      case 1:
          return [1,5,3,4]
      case 2:
          return [2,4,0,5]
      case 3:
          return [3,4,1,5]
      case 4:
          return [4,0,5,2]
      case 5:
          return [5,2,4,0]
      default:
          print("err")
          return []
      }
    }

    func mapVerticalSides(_ currentSide: Int) -> [Int] {
      switch(currentSide) {
        case 0:
          return [0,3,2,1]
        case 1:
          return [1,2,3,0]
        case 2:
          return [2,3,0,1]
        case 3:
          return [3,1,0,2]
        default:
          print("err")
          return []
      }
    }

    mutating func shiftRight(_ currentSide: Int, _ selected: [Int], _ isRow: Bool) {
      let sideList = mapHorizontalSides(currentSide)
      let original = state
      
      for side in 0..<sideList.count {
        print("side: \(side)")
        for square in selected {
          print("sd:\(side)  sq:\(square)")
          if(side == 0) {
            state[sideList[side]][square] = original[sideList[sideList.count - 1]][square]
            continue
          }
          state[sideList[side]][square] = original[sideList[side - 1]][square]
        }
      }
    }

    mutating func shiftLeft(_ currentSide: Int, _ selected: [Int], _ isRow: Bool) {
      let sideList = mapHorizontalSides(currentSide)
      let original = state

      for side in 0..<sideList.count {
        print("side: \(side)")
        for square in selected {
          print("sd:\(side)  sq:\(square)")
          if(side == sideList.count - 1) {
            state[sideList[side]][square] = original[sideList[0]][square]
            continue
          }
          state[sideList[side]][square] = original[sideList[side + 1]][square]
        }
      }
    }

    mutating func shiftUp(_ currentSide: Int, _ selected: [Int], _ isRow: Bool) {
      let sideList = mapVerticalSides(currentSide)
      let original = state

      for side in 0..<sideList.count {
        print("side: \(side)")
        for square in selected {
          print("sd:\(side)  sq:\(square)")
          if(side == sideList.count - 1) {
            state[sideList[side]][square] = original[sideList[0]][square]
            continue
          }
          state[sideList[side]][square] = original[sideList[side + 1]][square]
        }
      }
    }

    mutating func shiftDown(_ currentSide: Int, _ selected: [Int], _ isRow: Bool) {
      let sideList = mapVerticalSides(currentSide)
      let original = state

      for side in 0..<sideList.count {
        print("side: \(side)")
        for square in selected {
          print("sd:\(side)  sq:\(square)")
          if(side == 0) {
            state[sideList[side]][square] = original[sideList[sideList.count - 1]][square]
            continue
          }
          state[sideList[side]][square] = original[sideList[side - 1]][square]
        }
      }
    }
    
    func doRotation() {
        
    }
}
