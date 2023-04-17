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
        //Demarrage des timers
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseBuffAndCooldownTime), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateMoneyLabel), userInfo: nil, repeats: true)
        
        //Charge le premier monstre aléatoirement
        changeMonster()
    }
    
    @objc func decreaseBuffAndCooldownTime(){
        // Gestion des buffs
        if(Inventory.sharedInstance.buffTime > 0)
        {
            Inventory.sharedInstance.buffTime -= 1
        }
        else {
            Inventory.sharedInstance.buff = 1.0
        }
        
        // Gestion des cooldowns
        if(Inventory.sharedInstance.cooldownLeft > 0)
        {
            Inventory.sharedInstance.cooldownLeft -= 1
        }
        else {
            Inventory.sharedInstance.cooldownLeft = 0
            Inventory.sharedInstance.hitCooldown = 0
        }
    }
    
    func increaseMoneyOnKill(){
        Inventory.sharedInstance.money+=100
    }
    
    @objc func updateMoneyLabel(){moneyLabel.text = "Argent : \(Inventory.sharedInstance.money)$"}
    
    @IBAction func onHit(_ sender: Any) {
        //Permet de taper que si le cooldown est a 0, par défaut on peut taper tout le temps, mais certaines armes on un cooldown élevé (Claymore et Epée)
        if(Inventory.sharedInstance.cooldownLeft == 0)
        {
            Inventory.sharedInstance.cooldownLeft = Inventory.sharedInstance.hitCooldown
            health.progress -= baseDamage*Float(Inventory.sharedInstance.buff)
            if(health.progress == 0.0){
                onMonsterKill()
            }
        }
    }
    

    // Change de monstre par un autre tiré aléatoirement, sachant qu'un meme monstre ne peut apparaitre deux fois d'affilé
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
    
    func onMonsterKill(){
        changeMonster()
        increaseMoneyOnKill()
        updateMoneyLabel()
    }
    

}

