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
    var money:Int = 0
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.timerFun), userInfo: nil, repeats: true)
        changeMonster()
        updateMoneyLabel()
    }
    @objc func timerFun(){
        decreaseQuality()
        return
    }
    
    func decreaseQuality(){}
    func increaseMoney(){
        money+=100
    }
    func updateMoneyLabel(){moneyLabel.text = "Money : \(money)$"}
    
    
    @IBAction func onHit(_ sender: Any) {
        print("hit")
        health.progress -= baseDamage
        if(health.progress == 0.0){
            changeMonster()
            increaseMoney()
            updateMoneyLabel()
        }
    }
    func changeMonster(){
        let numberOfMonsters:Int = 2
        let id:Int = Int.random(in: 1..<numberOfMonsters+1)
        Monster.setImage(UIImage(named: "m\(id)"), for: .normal)
        health.progress = 1.0
    }
    

}

