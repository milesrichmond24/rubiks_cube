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
    
    mutating func rotateS3(_ right: Bool) {
        let original = state
        if(right) {
            state[3][0] = original[3][6]
            state[3][1] = original[3][3]
            state[3][2] = original[3][0]
            state[3][3] = original[3][7]
            state[3][5] = original[3][1]
            state[3][6] = original[3][8]
            state[3][7] = original[3][5]
            state[3][8] = original[3][2]
        } else {
            state[3][0] = original[3][2]
            state[3][1] = original[3][5]
            state[3][2] = original[3][8]
            state[3][3] = original[3][1]
            state[3][5] = original[3][7]
            state[3][6] = original[3][0]
            state[3][7] = original[3][3]
            state[3][8] = original[3][6]
        }
    }
    
    mutating func rotateS0(_ right: Bool) {
        let original = state
        if(right) {
            state[0][0] = original[0][6]
            state[0][1] = original[0][3]
            state[0][2] = original[0][0]
            state[0][3] = original[0][7]
            state[0][5] = original[0][1]
            state[0][6] = original[0][8]
            state[0][7] = original[0][5]
            state[0][8] = original[0][2]
        } else {
            state[0][0] = original[0][2]
            state[0][1] = original[0][5]
            state[0][2] = original[0][8]
            state[0][3] = original[0][1]
            state[0][5] = original[0][7]
            state[0][6] = original[0][0]
            state[0][7] = original[0][3]
            state[0][8] = original[0][6]
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
    
    // currentSide must either be 1 or 5
    // selected must either be [1,2,3] or [6,7,8]
    mutating func specialShiftRight(_ currentSide: Int, _ selected: [Int]) {
        let original = state
        var sideList: [Int]
        var sel1: [Int]
        var sel2: [Int]
        var sel3: [Int]
        
        if(currentSide == 1) {
            sideList = [1,2,5,4]
        } else {
            sideList = [5,4,1,2]
        }
        
        print("selected: \(selected)")
        
        if(selected == [0,1,2]) {
            sel1 = [0,3,6]
            sel2 = [8,7,6]
            sel3 = [8,5,2]
            rotateS0(true)
        } else {
            sel1 = [2,5,8]
            sel2 = [2,1,0]
            sel3 = [0,3,6]
            rotateS3(true)
        }
        
        for side in 0..<sideList.count {
            print(sideList[side])

            switch(sideList[side]) {
            case 1:
                state[1][selected[0]] = original[2][sel1[2]]
                state[1][selected[1]] = original[2][sel1[1]]
                state[1][selected[2]] = original[2][sel1[0]]
            case 2:
                state[2][sel1[0]] = original[5][sel2[2]]
                state[2][sel1[1]] = original[5][sel2[1]]
                state[2][sel1[2]] = original[5][sel2[0]]
            case 5:
                state[5][sel2[0]] = original[4][sel3[0]]
                state[5][sel2[1]] = original[4][sel3[1]]
                state[5][sel2[2]] = original[4][sel3[2]]
            case 4:
                state[4][sel3[0]] = original[1][selected[0]]
                state[4][sel3[1]] = original[1][selected[1]]
                state[4][sel3[2]] = original[1][selected[2]]
            default:
                print("sp right err")
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
    
    mutating func specialShiftLeft(_ currentSide: Int, _ selected: [Int]) {
        let original = state
        var sideList: [Int]
        var sel1: [Int]
        var sel2: [Int]
        var sel3: [Int]
        
        if(currentSide == 1) {
            sideList = [1,2,5,4]
        } else {
            sideList = [5,4,1,2]
        }
        
        if(selected == [0,1,2]) {
            sel1 = [2,5,8]
            sel2 = [6,7,8]
            sel3 = [6,3,0]
            rotateS0(true)
        } else {
            sel1 = [6,3,0]
            sel2 = [0,1,2]
            sel3 = [8,5,2]
            rotateS3(true)
        }
        
        for side in 0..<sideList.count {
            print(sideList[side])

            switch(sideList[side]) {
            case 1:
                state[1][selected[0]] = original[4][sel1[2]]
                state[1][selected[1]] = original[4][sel1[1]]
                state[1][selected[2]] = original[4][sel1[0]]
            case 2:
                state[2][sel3[0]] = original[1][selected[0]]
                state[2][sel3[1]] = original[1][selected[1]]
                state[2][sel3[2]] = original[1][selected[2]]
            case 5:
                state[5][sel2[0]] = original[2][sel3[2]]
                state[5][sel2[1]] = original[2][sel3[1]]
                state[5][sel2[2]] = original[2][sel3[0]]
            case 4:
                state[4][sel1[0]] = original[5][sel2[0]]
                state[4][sel1[1]] = original[5][sel2[1]]
                state[4][sel1[2]] = original[5][sel2[2]]
            default:
                print("sp left err")
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
    
    mutating func specialShiftUp(_ currentSide: Int, _ selected: [Int]) {
        let original = state
        var sideList: [Int]
        var sel1: [Int]
        var sel2: [Int]
        var sel3: [Int]
        
        if(currentSide == 2) {
            sideList = [2,5,4,1]
        } else {
            sideList = [4,1,2,5]
        }
        
        if(selected == [0,3,6]) {
            sel1 = [6,7,8]
            sel2 = [8,5,2]
            sel3 = [2,1,0]
            rotateS0(true)
        } else {
            sel1 = [0,1,2]
            sel2 = [6,3,0]
            sel3 = [8,7,6]
            rotateS3(true)
        }
        
        for side in 0..<sideList.count {
            print(sideList[side])

            switch(sideList[side]) {
            case 1:
                state[1][sel3[0]] = original[2][selected[0]]
                state[1][sel3[1]] = original[2][selected[1]]
                state[1][sel3[2]] = original[2][selected[2]]
            case 2:
                state[2][selected[0]] = original[5][sel1[0]]
                state[2][selected[1]] = original[5][sel1[1]]
                state[2][selected[2]] = original[5][sel1[2]]
            case 5:
                state[5][sel1[0]] = original[4][sel2[0]]
                state[5][sel1[1]] = original[4][sel2[1]]
                state[5][sel1[2]] = original[4][sel2[2]]
            case 4:
                state[4][sel2[0]] = original[1][sel3[0]]
                state[4][sel2[1]] = original[1][sel3[1]]
                state[4][sel2[2]] = original[1][sel3[2]]
            default:
                print("L150 err")
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
    
    mutating func specialShiftDown(_ currentSide: Int, _ selected: [Int]) {
        let original = state
        var sideList: [Int]
        var sel1: [Int]
        var sel2: [Int]
        var sel3: [Int]
        
        if(currentSide == 2) {
            sideList = [2,5,4,1]
        } else {
            sideList = [4,1,2,5]
        }
        
        if(selected == [0,3,6]) {
            sel1 = [6,7,8]
            sel2 = [8,5,2]
            sel3 = [2,1,0]
            rotateS0(true)
        } else {
            sel1 = [0,1,2]
            sel2 = [6,3,0]
            sel3 = [8,7,6]
            rotateS3(true)
        }
        
        for side in 0..<sideList.count {
            print(sideList[side])

            switch(sideList[side]) {
            case 1:
                state[1][sel3[0]] = original[4][sel2[0]]
                state[1][sel3[1]] = original[4][sel2[1]]
                state[1][sel3[2]] = original[4][sel2[2]]
            case 2:
                state[2][selected[0]] = original[1][sel3[0]]
                state[2][selected[1]] = original[1][sel3[1]]
                state[2][selected[2]] = original[1][sel3[2]]
            case 5:
                state[5][sel1[0]] = original[2][selected[0]]
                state[5][sel1[1]] = original[2][selected[1]]
                state[5][sel1[2]] = original[2][selected[2]]
            case 4:
                state[4][sel2[0]] = original[5][sel1[0]]
                state[4][sel2[1]] = original[5][sel1[1]]
                state[4][sel2[2]] = original[5][sel1[2]]
            default:
                print("L150 err")
            }
        }
    }
    
    func isSolved() -> Bool {
        for side in state {
            for square in side {
                if(square != side[0]) {
                    return false
                }
            }
        }
        
        return true
    }
}
