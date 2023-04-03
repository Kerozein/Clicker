//
//  ViewController.swift
//  Clicker
//
//  Created by Tom Kowal--Picchi on 03/04/2023.
//

import UIKit

class ViewController: UIViewController {

    var money:Int = 0
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.timerFun), userInfo: nil, repeats: true)

        
    }
    @objc func timerFun(){
        decreaseQuality()
        increaseMoney()
        print(money)
        return
    }
    
    func decreaseQuality(){}
    func increaseMoney(){money+=100}


}

