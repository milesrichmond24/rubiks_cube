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
      print("as: \(currentSide)")
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
        print("right")
        let original = state
        let layer = selected[0] / 3
        let map0 = [
            [2,5,8],
            [1,4,7],
            [0,3,6]
        ]
        
        let map2 = [
            [0,3,6],
            [1,4,7],
            [2,5,8]
        ]
        let map3 = [
            [6,7,8],
            [3,4,5],
            [0,1,2]
        ]
        
        switch(currentSide) {
        case 1:
            let sideList = [1,2,5,4]
            print("selected: \(selected) , cSelect: \(currentSide), sideList: \(sideList)")
            state[sideList[0]][selected[0]] = original[sideList[1]][map2[layer][2]]
            state[sideList[0]][selected[1]] = original[sideList[1]][map2[layer][1]]
            state[sideList[0]][selected[2]] = original[sideList[1]][map2[layer][0]]
            
            state[sideList[1]][map2[layer][0]] = original[sideList[2]][map3[layer][0]]
            state[sideList[1]][map2[layer][1]] = original[sideList[2]][map3[layer][1]]
            state[sideList[1]][map2[layer][2]] = original[sideList[2]][map3[layer][2]]
            
            state[sideList[2]][map3[layer][0]] = original[sideList[3]][map0[layer][2]]
            state[sideList[2]][map3[layer][1]] = original[sideList[3]][map0[layer][1]]
            state[sideList[2]][map3[layer][2]] = original[sideList[3]][map0[layer][0]]
            
            state[sideList[3]][map0[layer][0]] = original[sideList[0]][selected[0]]
            state[sideList[3]][map0[layer][1]] = original[sideList[0]][selected[1]]
            state[sideList[3]][map0[layer][2]] = original[sideList[0]][selected[2]]
        case 5:
            let sideList = [5,4,1,2]
            state[sideList[3]][selected[0]] = original[sideList[2]][map2[layer][2]]
            state[sideList[3]][selected[1]] = original[sideList[2]][map2[layer][1]]
            state[sideList[3]][selected[2]] = original[sideList[2]][map2[layer][0]]
            
            state[sideList[0]][map2[layer][0]] = original[sideList[3]][map3[layer][0]]
            state[sideList[0]][map2[layer][1]] = original[sideList[3]][map3[layer][1]]
            state[sideList[0]][map2[layer][2]] = original[sideList[3]][map3[layer][2]]
            
            state[sideList[1]][map3[layer][0]] = original[sideList[0]][map0[layer][2]]
            state[sideList[1]][map3[layer][1]] = original[sideList[0]][map0[layer][1]]
            state[sideList[1]][map3[layer][2]] = original[sideList[0]][map0[layer][0]]
            
            state[sideList[2]][map0[layer][0]] = original[sideList[1]][selected[0]]
            state[sideList[2]][map0[layer][1]] = original[sideList[1]][selected[1]]
            state[sideList[2]][map0[layer][2]] = original[sideList[1]][selected[2]]
        default:
            var sideList = [Int]()
            switch(currentSide) {
            case 0:
                sideList = [0,2,3,4]
            case 3:
                sideList = [3,4,0,2]
            default:
                print("L143, err")
            }
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
    
    func clearSelection() {
        
    }
}
