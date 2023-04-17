//
//  ViewController.swift
//  Clicker
//
//  Created by Tom Kowal--Picchi on 03/04/2023.
//

import UIKit

class ClickerViewController: UIViewController {

    
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var health: UIProgressView!
    @IBOutlet weak var Monster: UIButton!
    var baseDamage:Float = 0.1
    var timer = Timer()
    var prevId:Int = 1
    var id:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseQuality), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateMoneyLabel), userInfo: nil, repeats: true)
        changeMonster()
    }
    
    @objc func decreaseQuality(){
        if(Inventory.sharedInstance.buffTime > 0)
        {
            Inventory.sharedInstance.buffTime -= 1
            if(Inventory.sharedInstance.buffTime==0){
                Inventory.sharedInstance.buff = 1.0
            }
        }
    }
    func increaseMoney(){
        Inventory.sharedInstance.money+=100
    }
    @objc func updateMoneyLabel(){moneyLabel.text = "Argent : \(Inventory.sharedInstance.money)$"}
    
    
    @IBAction func onHit(_ sender: Any) {
        health.progress -= baseDamage*Float(Inventory.sharedInstance.buff)
        if(health.progress == 0.0){
            onMonsterKill()
        }
    }
    
    func onMonsterKill(){
        changeMonster()
        increaseMoney()
        updateMoneyLabel()
    }
    
    func changeMonster(){
        let numberOfMonsters:Int = 5
        id = Int.random(in: 1..<numberOfMonsters+1)
        while(prevId==id)
        {
            id = Int.random(in: 1..<numberOfMonsters+1)
        }
        Monster.setImage(UIImage(named: "m\(id)"), for: .normal)
        health.progress = 1.0
        prevId = id
    }
    

}

