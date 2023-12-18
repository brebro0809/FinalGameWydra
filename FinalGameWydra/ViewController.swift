//
//  ViewController.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/4/23.
//

// Variables: 76
// Operators: 801
// If/Else: 314
// While/For Loops: 11
// Switches: 14
// Arrays: 2
// Functions(Excluding Built-In): 55
// Closures: 2
// Optionals: 1
// Classes: 6

import UIKit
import Foundation

protocol block {
    func moveDown()
    func rotate()
    func moveLeft()
    func moveRight()
    func moveLine(testY: Int)
    func removeBlocks(testY: Int)
    func getBlocks() -> [Int]
    func getPos() -> [Int]
    func getGrounded() -> Bool
    func getColor() -> Int
}

class AppDefaults {
    static var cells = [Int](repeating: 0, count: 200)
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var gameBoard: UICollectionView!
    
    var timer = Timer()
    
    var blocks = [block]()
    
    var clearedCells = [Int]()
    
    var isLost = false
    
    override func viewDidDisappear(_ animated: Bool) {
        AppDefaults.cells = [Int](repeating: 0, count: 200)
        blocks = [block]()
        isLost = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        gameBoard.dataSource = self
        gameBoard.delegate = self
        gameBoard.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        gameBoard.layer.borderWidth = 4
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
        switch Int.random(in: 1...6) {
        case 1:
            blocks.append(TBlock(x: 5, y: 1))
        case 2:
            blocks.append(RLBlock(x: 5, y: 1))
        case 3:
            blocks.append(LLBlock(x: 5, y: 1))
        case 4:
            blocks.append(SQBlock(x: 5, y: 1))
        case 5:
            blocks.append(STRBlock(x: 5, y: 1))
        case 6:
            blocks.append(ZBlock(x: 5, y: 1))
        default:
            print(":(")
        }
        isLost = false
    }
    
    func update(didFall: Bool) {
        if (isLost) {
            return
        }
        
        for block in blocks {
            let position = block.getPos()
            let currBlocks = block.getBlocks()
            
            for i in currBlocks {
                clearedCells.append(position[i])
            }
        }
        
        for cell in clearedCells {
            AppDefaults.cells[cell] = 0
        }
        clearedCells = [Int]()
        
        for block in blocks {
            if (didFall) {
                block.moveDown()
            }
            
            let currBlocks = block.getBlocks()
            let position = block.getPos()
            let color = block.getColor()
            
            for i in currBlocks {
                print(i)
                AppDefaults.cells[position[i]] = color
            }
        }
        
        gameBoard.reloadData()
        
        if (!didFall) {
            return
        }
        
        for x in 0...9 {
            if(AppDefaults.cells[x] != 0) {
                isLost = true
                let alert = UIAlertController(title: "You Lost :(", message: "pro tip: clear more lines", preferredStyle: .alert)
                let continueAction = UIAlertAction(title: "Play Again", style: .default) { (action) in
                    self.isLost = false
                    self.blocks = [block]()
                    for x in 0...199 {
                        AppDefaults.cells[x] = 0
                    }
                }
                let backAction = UIAlertAction(title: "Main Menu", style: .default) { (action) in
                    _ = self.navigationController?.popViewController(animated: true)
                }

                alert.addAction(continueAction)
                alert.addAction(backAction)
                present(alert, animated: true)
                return
            }
        }
        
        if (blocks.count >= 1) {
            if (!blocks[blocks.count - 1].getGrounded()) {
                return
            }
        }
        
        for y in 1..<20 {
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
                let position = block.getPos()
                clearedCells.append(position[0])
                clearedCells.append(position[1])
                clearedCells.append(position[2])
                clearedCells.append(position[3])
                block.removeBlocks(testY: y)
            }
            for block in blocks {
                block.moveLine(testY: y)
            }
            for x in 0...9 {
                AppDefaults.cells[y * 10 + x] = 7
            }
        }
        
        switch Int.random(in: 1...6) {
        case 1:
            blocks.append(TBlock(x: 5, y: 1))
        case 2:
            blocks.append(RLBlock(x: 5, y: 1))
        case 3:
            blocks.append(LLBlock(x: 5, y: 1))
        case 4:
            blocks.append(SQBlock(x: 5, y: 1))
        case 5:
            blocks.append(STRBlock(x: 5, y: 1))
        case 6:
            blocks.append(ZBlock(x: 5, y: 1))
        default:
            print(":(")
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
        } else if (AppDefaults.cells[indexPath.item] == 7) {
            cell.backgroundColor = UIColor.white
        }
        
        cell.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        cell.layer.borderWidth = 2
        return cell
    }
    @IBAction func leftButtonPress(_ sender: UIButton) {
        let block = blocks[blocks.count - 1]
        let position = block.getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        block.moveLeft()
        update(didFall: false)
    }
    @IBAction func rightButtonPress(_ sender: UIButton) {
        let block = blocks[blocks.count - 1]
        let position = block.getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        block.moveRight()
        update(didFall: false)
    }
    
    @IBAction func rotatePress(_ sender: UIButton) {
        let block = blocks[blocks.count - 1]
        let position = block.getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        block.rotate()
        update(didFall: false)
    }
}
