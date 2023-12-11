//
//  SQBlock.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/8/23.
//

import Foundation

class SQBlock: block {
    func getColor() -> Int {
        return 4
    }
    
    var x: Int
    var y: Int
    var isGrounded = false
    var block0 = true
    var block1 = true
    var block2 = true
    var block3 = true
    var y0 = 0
    var y1 = 0
    var y2 = 1
    var y3 = 1
    
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
            self.isGrounded = true
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
    
    func moveLine(testY: Int) {
        if (block0 && y + y0 < testY) {
            y0 += 1
        }
        if (block1 && y + y1 < testY) {
            y1 += 1
        }
        if (block2 && y + y2 < testY) {
            y2 += 1
        }
        if (block3 && y + y3 < testY) {
            y3 += 1
        }
    }
    
    func removeBlocks(testY: Int) {
        if (block0) {
            block0 = !(y + y0 == testY)
        }
        if (block1) {
            block1 = !(y + y1 == testY)
        }
        if (block2) {
            block2 = !(y + y2 == testY)
        }
        if (block3) {
            block3 = !(y + y3 == testY)
        }
    }
    
    func getBlocks() -> [Int] {
        var final = [Int]()
        if (block0) {
            final.append(0)
        }
        if (block1) {
            final.append(1)
        }
        if (block2) {
            final.append(2)
        }
        if (block3) {
            final.append(3)
        }
        return final
    }
    
    func getGrounded() -> Bool {
        return isGrounded
    }
    
    func getPos() -> [Int] {
        var final = [Int]()
        
        final.append((y + y0) * 10 + x)
        final.append((y + y1) * 10 + x - 1)
        final.append((y + y2) * 10 + x)
        final.append((y + y3) * 10 + x - 1)
        
        return final
    }
}
