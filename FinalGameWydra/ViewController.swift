//
//  ViewController.swift
//  FinalGameWydra
//
//  Created by Brian Wydra on 12/4/23.
//

import UIKit
import Foundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var gameBoard: UICollectionView!
    
    var timer = Timer()
    
    var cells = [Int](repeating: 0, count: 200)
    
    var blocks = [Any]()
    
    var clearedCells = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameBoard.dataSource = self
        gameBoard.delegate = self
        gameBoard.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        gameBoard.layer.borderWidth = 4
        
        blocks.append(TBlock(x: 4, y: 1))
        
        timer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    @objc func fire() {
        print("ran")
        var position = (blocks[0] as! TBlock).getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        for cell in clearedCells {
            cells[cell] = 0
        }
        clearedCells = [Int]()
        (blocks[0] as! TBlock).moveDown()
        position = (blocks[0] as! TBlock).getPos()
        cells[position[0]] = 1
        cells[position[1]] = 1
        cells[position[2]] = 1
        cells[position[3]] = 1
        gameBoard.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameBoard.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        if(cells[indexPath.item] == 0){
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor(red: 0.251, green: 0.506, blue: 0.91, alpha: 1)
        }
        
        cell.layer.borderColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        cell.layer.borderWidth = 2
        return cell
    }
    @IBAction func leftButtonPress(_ sender: UIButton) {
        var position = (blocks[0] as! TBlock).getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        (blocks[0] as! TBlock).moveLeft()
    }
    @IBAction func rightButtonPress(_ sender: UIButton) {
        var position = (blocks[0] as! TBlock).getPos()
        clearedCells.append(position[0])
        clearedCells.append(position[1])
        clearedCells.append(position[2])
        clearedCells.append(position[3])
        
        (blocks[0] as! TBlock).moveRight()
    }
}

class TBlock {
    var x: Int
    var y: Int
    var isGrounded = false
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func moveDown() {
        if (y + 1 > 19) {
            self.isGrounded = true
            return
        }
        y += 1
    }
    
    func moveLeft() {
        if (x - 1 < 1 || isGrounded) {
            return
        }
        x -= 1
    }
    
    func moveRight() {
        if (x + 1 > 8 || isGrounded) {
            return
        }
        x += 1
    }
    
    func getPos() -> [Int] {
        var final = [Int]()
        final.append(((y - 1) * 10) + x)
        final.append(y * 10 + x - 1)
        final.append(y * 10 + x)
        final.append(y * 10 + x + 1)
        return final
    }
}
