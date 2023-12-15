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
    
    

    
    var colors = [1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6]
    
    init(_ sides: Int, _ rows: Int, _ cols: Int) {
        for side in 0..<sides {
            state.append([Int]())
            for _ in 0..<rows*cols {
                while(true) {
                    let rand = Int.random(in: 0..<54)
                    if  0 != colors[rand] {
                        state[side].append(colors[rand] - 1)
                        colors[rand] = 0
                        break
                    }
                }
                    //state[side].append(colors[Int.random(in: 0..<6)])
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
          return [0,2,3,4]
      case 1:
          return [1,2,5,4]
      case 2:
          return [2,5,4,1]
      case 3:
          return [3,4,0,2]
      case 4:
          return [4,1,2,5]
      case 5:
          return [5,4,1,2]
      default:
          print("err")
          return []
      }
    }

    func mapVerticalSides(_ currentSide: Int) -> [Int] {
      //print("as: \(currentSide)")
        switch(currentSide) {
      case 0:
          return [0,1,3,5]
      case 1:
          return [1,3,5,0]
      case 2:
          return [2,5,4,1]
      case 3:
          return [3,5,0,1]
      case 4:
          return [4,1,2,5]
      case 5:
            return [5,0,1,3]
      default:
          print("err")
          return []
      }
    }

    mutating func shiftRight(_ currentSide: Int, _ selected: [Int], _ isRow: Bool) {
        let original = state
        let sideList = mapHorizontalSides(currentSide)
        for side in 0..<sideList.count {
          //print("side: \(side)")
          for square in selected {
            //print("sd:\(side)  sq:\(square)")
            if(side == 0) {
              state[sideList[side]][square] = original[sideList[sideList.count - 1]][square]
              continue
            }
            state[sideList[side]][square] = original[sideList[side - 1]][square]
          }
        }
    }

    mutating func shiftLeft(_ currentSide: Int, _ selected: [Int], _ isRow: Bool) {
        let original = state
        
        let sideList = mapHorizontalSides(currentSide)
        for side in 0..<sideList.count {
          //print("side: \(side)")
          for square in selected {
            //print("sd:\(side)  sq:\(square)")
            if(side == 3) {
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
        //print("side: \(side)")
        for square in selected {
          //print("sd:\(side)  sq:\(square)")
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
        //print("side: \(side)")
        for square in selected {
          //print("sd:\(side)  sq:\(square)")
          if(side == 0) {
            state[sideList[side]][square] = original[sideList[sideList.count - 1]][square]
            continue
          }
          state[sideList[side]][square] = original[sideList[side - 1]][square]
        }
      }
    }
    
    func clearSelection() {
        
    }
}
