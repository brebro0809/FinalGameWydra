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
                self.blocks.append(TBlock(x: 5, y: 1))
            case "Right L-Block":
                self.blocks.append(RLBlock(x: 5, y: 1))
            case "Left L-Block":
                self.blocks.append(LLBlock(x: 5, y: 1))
            case "Square Block":
                self.blocks.append(SQBlock(x: 5, y: 1))
            case "Straight Block":
                self.blocks.append(STRBlock(x: 5, y: 1))
            case "Z-Block":
                self.blocks.append(ZBlock(x: 5, y: 1))
            case "Clear":
                self.blocks = [Any]()
                for i in 0..<200 {
                    self.clearedCells.append(i)
                }
            default:
                print("AHHH")
            }
        }
        
        debugButton.menu = UIMenu(children: [
            UIAction(title: "T-Block", handler: optionClosure),
            UIAction(title: "Right L-Block", handler: optionClosure),
            UIAction(title: "Left L-Block", handler: optionClosure),
            UIAction(title: "Square Block", handler: optionClosure),
            UIAction(title: "Straight Block", handler: optionClosure),
            UIAction(title: "Z-Block", handler: optionClosure),
            UIAction(title: "Clear", handler: optionClosure)
        ])
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    func update(didFall: Bool) {
        for block in blocks {
            if let temp = block as? TBlock {
                let position = temp.getPos()
                let currBlocks = temp.getBlocks()
                
                for i in currBlocks {
                    clearedCells.append(position[i])
                }
                continue
            }
            if let temp = block as? RLBlock {
                let position = temp.getPos()
                clearedCells.append(position[0])
                clearedCells.append(position[1])
                clearedCells.append(position[2])
                clearedCells.append(position[3])
                continue
            }
            if let temp = block as? LLBlock {
                let position = temp.getPos()
                clearedCells.append(position[0])
                clearedCells.append(position[1])
                clearedCells.append(position[2])
                clearedCells.append(position[3])
                continue
            }
            if let temp = block as? SQBlock {
                let position = temp.getPos()
                clearedCells.append(position[0])
                clearedCells.append(position[1])
                clearedCells.append(position[2])
                clearedCells.append(position[3])
                continue
            }
            if let temp = block as? STRBlock {
                let position = temp.getPos()
                clearedCells.append(position[0])
                clearedCells.append(position[1])
                clearedCells.append(position[2])
                clearedCells.append(position[3])
                continue
            }
            if let temp = block as? ZBlock {
                let position = temp.getPos()
                let currBlocks = temp.getBlocks()
                
                for i in currBlocks {
                    clearedCells.append(position[i])
                }
                continue
            }
        }
        
        for cell in clearedCells {
            AppDefaults.cells[cell] = 0
        }
        clearedCells = [Int]()
        
        for block in blocks {
            
            if let temp = block as? TBlock {
                if (didFall) {
                    temp.moveDown()
                }
                
                let currBlocks = temp.getBlocks()
                let position = temp.getPos()
                
                for i in currBlocks {
                    AppDefaults.cells[position[i]] = 1
                }
                continue
            }
            if let temp = block as? RLBlock {
                var position = temp.getPos()
                
                
                if (didFall) {
                    temp.moveDown()
                }
                
                position = temp.getPos()
                AppDefaults.cells[position[0]] = 2
                AppDefaults.cells[position[1]] = 2
                AppDefaults.cells[position[2]] = 2
                AppDefaults.cells[position[3]] = 2
                continue
            }
            if let temp = block as? LLBlock {
                var position = temp.getPos()
                
                
                if (didFall) {
                    temp.moveDown()
                }
                
                position = temp.getPos()
                AppDefaults.cells[position[0]] = 3
                AppDefaults.cells[position[1]] = 3
                AppDefaults.cells[position[2]] = 3
                AppDefaults.cells[position[3]] = 3
                continue
            }
            if let temp = block as? SQBlock {
                var position = temp.getPos()
                
                
                if (didFall) {
                    temp.moveDown()
                }
                
                position = temp.getPos()
                AppDefaults.cells[position[0]] = 4
                AppDefaults.cells[position[1]] = 4
                AppDefaults.cells[position[2]] = 4
                AppDefaults.cells[position[3]] = 4
                continue
            }
            if let temp = block as? STRBlock {
                var position = temp.getPos()
                
                
                if (didFall) {
                    temp.moveDown()
                }
                
                position = temp.getPos()
                AppDefaults.cells[position[0]] = 5
                AppDefaults.cells[position[1]] = 5
                AppDefaults.cells[position[2]] = 5
                AppDefaults.cells[position[3]] = 5
                continue
            }
            if let temp = block as? ZBlock {
                if (didFall) {
                    temp.moveDown()
                }
                
                let currBlocks = temp.getBlocks()
                let position = temp.getPos()
                
                for i in currBlocks {
                    AppDefaults.cells[position[i]] = 6
                }
                continue
            }
        }
        
        for y in 0..<20 {
            var isFilled = true
            for x in 0...9 {
                if(AppDefaults.cells[y * 10 + x] == 0) {
                    isFilled = false
                    break
                }
            }
            if (!isFilled) {
                continue
            }
            for block in blocks {
                if let temp = block as? TBlock {
                    temp.removeBlocks(testY: y)
                }
            }
        }
        
        gameBoard.reloadData()
    }
    
    @objc func fire() {
        update(didFall: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameBoard.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        if(AppDefaults.cells[indexPath.item] == 0) {
            cell.backgroundColor = UIColor.clear
        } else if (AppDefaults.cells[indexPath.item] == 1) {
            cell.backgroundColor = UIColor(red: 0.757, green: 0, blue: 1, alpha: 1)
        } else if (AppDefaults.cells[indexPath.item] == 2) {
            cell.backgroundColor = UIColor(red: 0.255, green: 0.408, blue: 1, alpha: 1)
        } else if (AppDefaults.cells[indexPath.item] == 3) {
            cell.backgroundColor = UIColor(red: 0.929, green: 0.58, blue: 0.071, alpha: 1)
        } else if (AppDefaults.cells[indexPath.item] == 4) {
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
        } else if (AppDefaults.cells[indexPath.item] == 5) {
            cell.backgroundColor = UIColor(red: 0, green: 1, blue: 0.961, alpha: 1)
        } else if (AppDefaults.cells[indexPath.item] == 6) {
            cell.backgroundColor = UIColor(red: 1, green: 0.161, blue: 0.161, alpha: 1)
        }
        
        cell.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        cell.layer.borderWidth = 2
        return cell
    }
    @IBAction func leftButtonPress(_ sender: UIButton) {
        if let block = blocks[blocks.count - 1] as? TBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? RLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? LLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? SQBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? STRBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? ZBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
            update(didFall: false)
        }
    }
    @IBAction func rightButtonPress(_ sender: UIButton) {
        if let block = blocks[blocks.count - 1] as? TBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? RLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? LLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? SQBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? STRBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? ZBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
            update(didFall: false)
        }
    }
    
    @IBAction func rotatePress(_ sender: UIButton) {
        if let block = blocks[blocks.count - 1] as? TBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? RLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? LLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? SQBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? STRBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
            update(didFall: false)
        }
        if let block = blocks[blocks.count - 1] as? ZBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
            update(didFall: false)
        }
    }
}
