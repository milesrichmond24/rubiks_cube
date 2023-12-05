//
//  cube.swift
//  rubiks_cube
//
//  Created by Miles Richmond on 12/4/23.
//

import Foundation

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
}
