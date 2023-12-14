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
      let sideList = mapHorizontalSides(currentSide)
      let original = state
        
      
        if(currentSide == 1 || currentSide == 5) {
            /*
            for side in 0..<sideList.count {
                if(side == 0) {
                    state[sideList[side]][selected[0] - 2] = original[sideList[sideList.count - 1]][selected[0]]
                    state[sideList[side]][selected[1]] = original[sideList[sideList.count - 1]][selected[1]]
                    state[sideList[side]][selected[2] + 2] = original[sideList[sideList.count - 1]][selected[2]]
                    continue
                }
                
              state[sideList[side]][selected[0] - 2] = original[side - 1][selected[0]]
              state[sideList[side]][selected[1]] = original[side - 1][selected[1]]
              state[sideList[side]][selected[2] + 2] = original[side - 1][selected[2]]
            }
            */
            
            
            
            
            
            if(isRow && (currentSide == 1 || currentSide == 5)) {
                for side in 0..<sideList.count {
                    switch (selected[0] / 3) {
                    case 0:
                        if(side == 0) {
                            state[sideList[side]][0] = original[sideList.count-1][0]
                            state[sideList[side]][1] = original[sideList.count-1][3]
                            state[sideList[side]][2] = original[sideList.count-1][6]
                            continue
                        }
                        state[sideList[side]][0] = original[side-1][0]
                        state[sideList[side]][1] = original[side-1][3]
                        state[sideList[side]][2] = original[side-1][6]
                        print("t0")
                    case 1:
                        if(side == 0) {
                            state[sideList[side]][3] = original[sideList.count-1][1]
                            state[sideList[side]][4] = original[sideList.count-1][4]
                            state[sideList[side]][5] = original[sideList.count-1][7]
                            continue
                        }
                        state[sideList[side]][3] = original[side-1][1]
                        state[sideList[side]][4] = original[side-1][4]
                        state[sideList[side]][5] = original[side-1][7]
                        print("t1")
                    case 2:
                        if(side == 0) {
                            state[sideList[side]][6] = original[sideList.count-1][0]
                            state[sideList[side]][7] = original[sideList.count-1][3]
                            state[sideList[side]][8] = original[sideList.count-1][6]
                            continue
                        }
                        state[sideList[side]][6] = original[side-1][0]
                        state[sideList[side]][7] = original[side-1][3]
                        state[sideList[side]][8] = original[side-1][6]
                        print("t2")
                    default:
                        print("a")
                    }
                }
                }
        } else if(currentSide == 2 || currentSide == 4) {
            
        } else {
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
