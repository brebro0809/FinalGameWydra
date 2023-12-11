//
//  SQBlock.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/8/23.
//

import Foundation

class SQBlock {
    var x: Int
    var y: Int
    var isGrounded = false
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func moveDown() {
        if (isGrounded) {
            return
        }
        if (y + 2 > 19) {
            self.isGrounded = true
            return
        }
        
        if (AppDefaults.cells[(y + 2) * 10 + x] != 0 || AppDefaults.cells[(y + 2) * 10 + x - 1] != 0) {
            return
        }
        
        y += 1
    }
    
    func rotate() {
        
    }
    
    func moveLeft() {
        if (x - 1 <= 0 || isGrounded) {
            return
        }
        if (AppDefaults.cells[y * 10 + x - 2] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 2] != 0) {
            return
        }
        
        x -= 1
    }
    
    func moveRight() {
        if (x + 1 > 9 || isGrounded) {
            return
        }
        if (AppDefaults.cells[y * 10 + x + 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0) {
            return
        }
        
        x += 1
    }
    
    func getPos() -> [Int] {
        var final = [Int]()
        
        final.append(y * 10 + x)
        final.append(y * 10 + x - 1)
        final.append((y + 1) * 10 + x)
        final.append((y + 1) * 10 + x - 1)
        
        return final
    }
}
