//
//  RLBlock.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/8/23.
//

import Foundation

class RLBlock {
    var x: Int
    var y: Int
    var isGrounded = false
    var direction = 0
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func moveDown() {
        if (direction == 0 && y + 1 > 19) {
            return
        } else if (direction == 1 && y + 2 > 19) {
            return
        }
        
        y += 1
    }
    
    func rotate() {
        if (isGrounded) {
            return
        }
        
        switch direction {
        case 0:
            if (AppDefaults.cells[(y + 1) * 10 + x] != 0) {
                return
            }
        case 1:
            if (AppDefaults.cells[y * 10 + x - 1] != 0) {
                return
            }
        case 2:
            if (AppDefaults.cells[((y - 1) * 10) + x] != 0) {
                return
            }
        case 3:
            if (AppDefaults.cells[y * 10 + x + 1] != 0) {
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
        if (direction == 0 && x - 1 < 1) {
            return
        } else if(direction == 1 && x < 1) {
            return
        }
        
        x -= 1
    }
    
    func moveRight() {
        if ((direction == 0 || direction == 1) && x + 1 >= 9) {
            return
        }
        
        x += 1
    }
    
    func getPos() -> [Int] {
        var final = [Int]()
        if (self.direction == 0) {
            final.append(y * 10 + x)
            final.append(y * 10 + x + 1)
            final.append(y * 10 + x - 1)
            final.append((y - 1) * 10 + x - 1)
        } else if (self.direction == 1) {
            final.append(y * 10 + x)
            final.append((y + 1) * 10 + x)
            final.append((y - 1) * 10 + x)
            final.append((y - 1) * 10 + x + 1)
        } else if (self.direction == 2) {
            final.append(((y + 1) * 10) + x)
            final.append(y * 10 + x + 1)
            final.append(y * 10 + x)
            final.append(y * 10 + x - 1)
        } else if (self.direction == 3) {
            final.append(y * 10 + x - 1)
            final.append((y + 1) * 10 + x)
            final.append(y * 10 + x)
            final.append((y - 1) * 10 + x)
        }
        return final
    }
}
