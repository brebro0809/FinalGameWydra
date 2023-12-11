//
//  RLBlock.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/8/23.
//

import Foundation

class RLBlock: block {
    func getColor() -> Int {
        return 2
    }
    
    var x: Int
    var y: Int
    var isGrounded = false
    var direction = 0
    var block0 = true
    var block1 = true
    var block2 = true
    var block3 = true
    var y0 = 0
    var y1 = 0
    var y2 = 0
    var y3 = -1
    
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
            if (AppDefaults.cells[(y + 1) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0) {
                self.isGrounded = true
                return
            }
        } else if (direction == 1) {
            if (AppDefaults.cells[(y + 2) * 10 + x] != 0 || AppDefaults.cells[y * 10 + x + 1] != 0) {
                self.isGrounded = true
                return
            }
        } else if (direction == 2) {
            if (AppDefaults.cells[(y + 2) * 10 + x + 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 1] != 0) {
                self.isGrounded = true
                return
            }
        } else if (direction == 3) {
            if (AppDefaults.cells[(y + 2) * 10 + x] != 0 || AppDefaults.cells[(y + 2) * 10 + x - 1] != 0) {
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
            if ((AppDefaults.cells[(y + 1) * 10 + x] != 0) || (AppDefaults.cells[(y - 1) * 10 + x] != 0) || (AppDefaults.cells[(y - 1) * 10 + x + 1] != 0)) {
                return
            }
        case 1:
            if (AppDefaults.cells[y * 10 + x + 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0 || AppDefaults.cells[y * 10 + x - 1] != 0) {
                return
            }
            if(direction == 1 && x < 1) {
                return
            }
        case 2:
            if (AppDefaults.cells[(y - 1) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x] != 0 || AppDefaults.cells[(y + 1) * 10 + x - 1] != 0) {
                return
            }
        case 3:
            if (AppDefaults.cells[(y - 1) * 10 + x - 1] != 0 || AppDefaults.cells[y * 10 + x - 1] != 0 || AppDefaults.cells[y * 10 + x + 1] != 0) {
                return
            }
            if (direction == 3 && x + 1 > 9) {
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
        
        switch direction {
        case 0:
            y0 = 0
            y1 = 0
            y2 = 0
            y3 = -1
        case 1:
            y0 = 0
            y1 = 1
            y2 = -1
            y3 = -1
        case 2:
            y0 = 0
            y1 = 0
            y2 = 0
            y3 = 1
        case 3:
            y0 = 0
            y1 = 1
            y2 = -1
            y3 = 1
        default:
            print(":(")
        }
    }
    
    func moveLeft() {
        if ((direction == 0 || direction == 2 || direction == 3) && x - 1 < 1) {
            return
        }
        if(direction == 1 && x < 1) {
            return
        }
        
        if (direction == 0 && ((AppDefaults.cells[y * 10 + x - 2] != 0) || (AppDefaults.cells[(y - 1) * 10 + x - 2] != 0))) {
            return
        }
        if (direction == 1 && ((AppDefaults.cells[y * 10 + x - 1] != 0) || (AppDefaults.cells[(y - 1) * 10 + x - 1] != 0) || (AppDefaults.cells[(y + 1) * 10 + x - 1] != 0))) {
            return
        }
        if (direction == 2 && (AppDefaults.cells[y * 10 + x - 2] != 0 || AppDefaults.cells[(y + 1) * 10 + x] != 0)) {
            return
        }
        if (direction == 3 && (AppDefaults.cells[(y + 1) * 10 + x - 2] != 0 || AppDefaults.cells[y * 10 + x - 1] != 0 || AppDefaults.cells[(y - 1) * 10 + x - 1] != 0)) {
            return
        }
        
        x -= 1
    }
    
    func moveRight() {
        if ((direction == 0 || direction == 1 || direction == 2) && x + 1 >= 9) {
            return
        }
        
        if (direction == 3 && x + 1 > 9) {
            return
        }
        
        if (direction == 0 && ((AppDefaults.cells[(y - 1) * 10 + x] != 0) || (AppDefaults.cells[y * 10 + x + 2] != 0))) {
            return
        }
        if (direction == 1 && ((AppDefaults.cells[(y - 1) * 10 + x + 2] != 0) || (AppDefaults.cells[(y + 1) * 10 + x + 1] != 0) || (AppDefaults.cells[y * 10 + x + 1] != 0))) {
            return
        }
        if (direction == 2 && (AppDefaults.cells[y * 10 + x + 2] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 2] != 0)) {
            return
        }
        if (direction == 3 && (AppDefaults.cells[y * 10 + x + 1] != 0 || AppDefaults.cells[(y - 1) * 10 + x + 1] != 0 || AppDefaults.cells[(y + 1) * 10 + x + 1] != 0)) {
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
        if (self.direction == 0) {
            final.append((y + y0) * 10 + x)
            final.append((y + y1) * 10 + x + 1)
            final.append((y + y2) * 10 + x - 1)
            final.append((y + y3) * 10 + x - 1)
        } else if (self.direction == 1) {
            final.append((y + y0) * 10 + x)
            final.append((y + y1) * 10 + x)
            final.append((y + y2) * 10 + x)
            final.append((y + y3) * 10 + x + 1)
        } else if (self.direction == 2) {
            final.append((y + y0) * 10 + x)
            final.append((y + y1) * 10 + x + 1)
            final.append((y + y2) * 10 + x - 1)
            final.append((y + y3) * 10 + x + 1)
        } else if (self.direction == 3) {
            final.append((y + y0) * 10 + x)
            final.append((y + y1) * 10 + x)
            final.append((y + y2) * 10 + x)
            final.append((y + y3) * 10 + x - 1)
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
