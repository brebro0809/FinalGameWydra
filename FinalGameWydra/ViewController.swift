//
//  ViewController.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/4/23.
//

import UIKit
import Foundation

class AppDefaults {
    static var cells = [Int](repeating: 0, count: 200)
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var gameBoard: UICollectionView!
    
    var timer = Timer()
    
    @IBOutlet weak var debugButton: UIButton!
    
    var blocks = [Any]()
    
    var clearedCells = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameBoard.dataSource = self
        gameBoard.delegate = self
        gameBoard.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        gameBoard.layer.borderWidth = 4
        
        debugButton.showsMenuAsPrimaryAction = true
        debugButton.changesSelectionAsPrimaryAction = true
        
        let optionClosure = {(action: UIAction) in
            switch action.title {
            case "T-Block":
                self.blocks.append(TBlock(x: 4, y: 1))
            default:
                print("AHHH")
            }
        }
        
        debugButton.menu = UIMenu(children: [
            UIAction(title: "T-Block", handler: optionClosure)
        ])
        blocks.append(TBlock(x: 4, y: 1))
        
        timer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    @objc func fire() {
        
        for block in blocks {
            let position = (block as! TBlock).getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
        }
        
        for cell in clearedCells {
            AppDefaults.cells[cell] = 0
        }
        clearedCells = [Int]()
        
        for block in blocks {
            var position = (block as! TBlock).getPos()
            
            
            (block as! TBlock).moveDown()
            
            position = (block as! TBlock).getPos()
            AppDefaults.cells[position[0]] = 1
            AppDefaults.cells[position[1]] = 1
            AppDefaults.cells[position[2]] = 1
            AppDefaults.cells[position[3]] = 1
        }
        
        
        gameBoard.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameBoard.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        if(AppDefaults.cells[indexPath.item] == 0) {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor(red: 0.251, green: 0.506, blue: 0.91, alpha: 1)
        }
        
        cell.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        cell.layer.borderWidth = 2
        return cell
    }
    @IBAction func leftButtonPress(_ sender: UIButton) {
        let position = (blocks[blocks.count - 1] as! TBlock).getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        (blocks[blocks.count - 1] as! TBlock).moveLeft(current: 1)
    }
    @IBAction func rightButtonPress(_ sender: UIButton) {
        let position = (blocks[blocks.count - 1] as! TBlock).getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        (blocks[blocks.count - 1] as! TBlock).moveRight()
    }
    
    @IBAction func rotatePress(_ sender: UIButton) {
        let position = (blocks[blocks.count - 1] as! TBlock).getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        (blocks[blocks.count - 1] as! TBlock).rotate()
    }
}

class TBlock {
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
            self.isGrounded = true
            return
        } else if (direction == 1 && y + 2 > 19) {
            self.isGrounded = true
            return
        } else if (direction == 2 && y + 2 > 19) {
            return
        }
        
        if (direction == 0) {
            if (AppDefaults.cells[(y + 1) * 10 + x] == 1 || AppDefaults.cells[(y + 1) * 10 + x - 1] == 1 || AppDefaults.cells[(y + 1) * 10 + x + 1] == 1) {
                return
            }
        } else if (direction == 1) {
            if (AppDefaults.cells[(y + 2) * 10 + x] == 1 || AppDefaults.cells[(y + 1) * 10 + x + 1] == 1) {
                return
            }
        } else if (direction == 2) {
            
        }
        
        y += 1
    }
    
    func rotate() {
        if (isGrounded) {
            return
        }
        
        if(direction == 2){
            direction = 0
        } else {
            direction += 1
        }
    }
    
    func moveLeft(current: Int) {
        if (direction == 0 && (x - 1 <= 0 || isGrounded)) {
            return
        }
        if (direction == 1 && (x - 1 < 0 || isGrounded)) {
            return
        }
        
        if (direction == 0 && (AppDefaults.cells[y * 10 + x - 2] != 0)) {
            return
        }
        
        x -= 1
    }
    
    func moveRight() {
        if ((direction == 0 || direction == 1) && (x + 1 > 8 || isGrounded)) {
            return
        }
        
        if (direction == 0 && (AppDefaults.cells[y * 10 + x + 2] != 0)) {
            return
        }
        
        x += 1
    }
    
    func getPos() -> [Int] {
        var final = [Int]()
        if (self.direction == 0) {
            final.append(((y - 1) * 10) + x)
            final.append(y * 10 + x - 1)
            final.append(y * 10 + x)
            final.append(y * 10 + x + 1)
        } else if (self.direction == 1) {
            final.append(y * 10 + x + 1)
            final.append((y - 1) * 10 + x)
            final.append(y * 10 + x)
            final.append((y + 1) * 10 + x)
        } else if (self.direction == 2) {
            final.append(y * 10 + x + 1)
            final.append((y - 1) * 10 + x)
            final.append(y * 10 + x)
            final.append((y + 1) * 10 + x)
        }
        return final
    }
}
