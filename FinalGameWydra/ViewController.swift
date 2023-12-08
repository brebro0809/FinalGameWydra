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
            case "Right L-Block":
                self.blocks.append(RLBlock(x: 4, y: 1))
            default:
                print("AHHH")
            }
        }
        
        debugButton.menu = UIMenu(children: [
            UIAction(title: "T-Block", handler: optionClosure),
            UIAction(title: "Right L-Block", handler: optionClosure)
        ])
        
        timer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    @objc func fire() {
        
        for block in blocks {
            if let temp = block as? TBlock {
                let position = temp.getPos()
                clearedCells.append(position[0])
                clearedCells.append(position[1])
                clearedCells.append(position[2])
                clearedCells.append(position[3])
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
        }
        
        for cell in clearedCells {
            AppDefaults.cells[cell] = 0
        }
        clearedCells = [Int]()
        
        for block in blocks {
            
            if let temp = block as? TBlock {
                var position = temp.getPos()
                
                
                temp.moveDown()
                
                position = temp.getPos()
                AppDefaults.cells[position[0]] = 1
                AppDefaults.cells[position[1]] = 1
                AppDefaults.cells[position[2]] = 1
                AppDefaults.cells[position[3]] = 1
                continue
            }
            if let temp = block as? RLBlock {
                var position = temp.getPos()
                
                
                temp.moveDown()
                
                position = temp.getPos()
                AppDefaults.cells[position[0]] = 2
                AppDefaults.cells[position[1]] = 2
                AppDefaults.cells[position[2]] = 2
                AppDefaults.cells[position[3]] = 2
                continue
            }
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
        } else if (AppDefaults.cells[indexPath.item] == 1) {
            cell.backgroundColor = UIColor(red: 0.757, green: 0, blue: 1, alpha: 1)
        } else if (AppDefaults.cells[indexPath.item] == 2) {
            cell.backgroundColor = UIColor(red: 0.165, green: 0.196, blue: 0.98, alpha: 1)
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
        }
        if let block = blocks[blocks.count - 1] as? RLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveLeft()
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
        }
        if let block = blocks[blocks.count - 1] as? RLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.moveRight()
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
        }
        if let block = blocks[blocks.count - 1] as? RLBlock {
            let position = block.getPos()
            clearedCells.append(position[0])
            clearedCells.append(position[1])
            clearedCells.append(position[2])
            clearedCells.append(position[3])
            
            block.rotate()
        }
    }
}
