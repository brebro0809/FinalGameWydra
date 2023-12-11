//
//  ZBlock.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/8/23.
//

import Foundation

class ZBlock {
    var x: Int
    var y: Int
    var isGrounded = false
    var direction = 0
    var block1 = true
    var block2 = true
    var block3 = true
    var block4 = true
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func moveDown() {
        if (isGrounded) {
            return
        }
        
        if (direction == 0 && y + 1 > 19) {
            self.isGrounded = true
            return
        }
        if ((direction == 1 || direction == 2 || direction == 3) && y + 2 > 19) {
            self.isGrounded = true
            return
        }
        
        if (direction == 0) {
            if (AppDefaults.cells[(y + 1) * 10 + x] != 0 || AppDefaults.cells[y * 10 + x - 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0) {
                self.isGrounded = true
                return
            }
        } else if (direction == 1) {
            if (AppDefaults.cells[(y + 2) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0) {
                self.isGrounded = true
                return
            }
        } else if (direction == 2) {
            if (AppDefaults.cells[(y + 2) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 1] != 0) {
                self.isGrounded = true
                return
            }
        } else if (direction == 3) {
            if (AppDefaults.cells[(y + 2) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 1] != 0) {
                self.isGrounded = true
                return
            }
        }
        
        y += 1
    }
    
    func rotate() {
        if (isGrounded) {
            return
        }
        
        switch direction {
        case 0:
            if (AppDefaults.cells[(y + 1) * 10 + x] != 0 || AppDefaults.cells[(y - 1) * 10 + x + 1] != 0) {
                return
            }
        case 1:
            if (AppDefaults.cells[y * 10 + x - 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0) {
                return
            }
        case 2:
            if (AppDefaults.cells[(y - 1) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 1] != 0) {
                return
            }
        case 3:
            if (AppDefaults.cells[y * 10 + x + 1] != 0 || AppDefaults.cells[(y - 1) * 10 + x - 1] != 0) {
                return
            }
        default:
            print(":(")
        }
        
        if(direction == 3){
            direction = 0
        } else {
            direction += 1
        }
    }
    
    func moveLeft() {
        if ((direction == 0 || direction == 2 || direction == 3) && (x - 1 <= 0 || isGrounded)) {
            return
        }
        
        if (direction == 1 && (x - 1 < 0 || isGrounded)) {
            return
        }
        
        if (direction == 0 && ((AppDefaults.cells[y * 10 + x - 1] != 0) || (AppDefaults.cells[(y - 1) * 10 + x - 2] != 0))) {
            return
        }
        
        if (direction == 1 && ((AppDefaults.cells[y * 10 + x - 1] != 0) || (AppDefaults.cells[(y - 1) * 10 + x] != 0) || (AppDefaults.cells[(y + 1) * 10 + x - 1] != 0))) {
            return
        }
        
        if (direction == 2 && ((AppDefaults.cells[y * 10 + x - 2] != 0) || (AppDefaults.cells[(y + 1) * 10 + x - 1] != 0))) {
            return
        }
        
        if (direction == 3 && ((AppDefaults.cells[y * 10 + x - 2] != 0) || (AppDefaults.cells[(y - 1) * 10 + x - 2] != 0) || (AppDefaults.cells[(y + 1) * 10 + x - 1] != 0))) {
            return
        }
        
        x -= 1
    }
    
    func moveRight() {
        if ((direction == 0 || direction == 1 || direction == 2) && (x + 1 > 8 || isGrounded)) {
            return
        }
        
        if (direction == 3 && (x + 1 > 9 || isGrounded)) {
            return
        }
        
        if (direction == 0 && (AppDefaults.cells[y * 10 + x + 2] != 0 || AppDefaults.cells[(y - 1) * 10 + x + 1] != 0)) {
            return
        }
        
        if (direction == 1 && ((AppDefaults.cells[y * 10 + x + 2] != 0) || (AppDefaults.cells[(y - 1) * 10 + x + 2] != 0) || (AppDefaults.cells[(y + 1) * 10 + x + 1] != 0))) {
            return
        }
        
        if (direction == 2 && ((AppDefaults.cells[y * 10 + x + 1] != 0) || (AppDefaults.cells[(y + 1) * 10 + x + 2] != 0))) {
            return
        }
        
        if (direction == 3 && ((AppDefaults.cells[y * 10 + x + 1] != 0) || (AppDefaults.cells[(y - 1) * 10 + x + 1] != 0) || (AppDefaults.cells[(y + 1) * 10 + x] != 0))) {
            return
        }
        
        x += 1
    }
    
    func getBlocks() -> [Int] {
        var final = [Int]()
        if (block1) {
            final.append(0)
        }
        if (block2) {
            final.append(1)
        }
        if (block3) {
            final.append(2)
        }
        if (block4) {
            final.append(3)
        }
        return final
    }
    
    func getPos() -> [Int] {
        var final = [Int]()
        if (self.direction == 0) {
            final.append(y * 10 + x)
            final.append(y * 10 + x + 1)
            final.append((y - 1) * 10 + x)
            final.append((y - 1) * 10 + x - 1)
        } else if (self.direction == 1) {
            final.append(y * 10 + x)
            final.append((y + 1) * 10 + x)
            final.append(y * 10 + x + 1)
            final.append((y - 1) * 10 + x + 1)
        } else if (self.direction == 2) {
            final.append(y * 10 + x)
            final.append(y * 10 + x - 1)
            final.append((y + 1) * 10 + x)
            final.append((y + 1) * 10 + x + 1)
        } else if (self.direction == 3) {
            final.append(y * 10 + x)
            final.append((y - 1) * 10 + x)
            final.append(y * 10 + x - 1)
            final.append((y + 1) * 10 + x - 1)
        }
        if (direction == 0 && y + 1 > 19) {
            self.isGrounded = true
        }
        if ((direction == 1 || direction == 2 || direction == 3) && y + 2 > 19) {
            self.isGrounded = true
        }
        return final
    }
}
