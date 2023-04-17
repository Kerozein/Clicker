//
//  WalkingController.swift
//  Clicker
//
//  Created by Tom Kowal--Picchi on 17/04/2023.
//

import UIKit
import CoreMotion
import CoreLocation

class WalkingController: UIViewController, CLLocationManagerDelegate {
    var timer = Timer()
    var isMoving:Bool = false
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerFun), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if(location.speed > 2)
        {
            isMoving=true
            speedLabel.text = "Vitesse : \(location.speed * 3.6) km/h"
            Inventory.sharedInstance.money += 5
            moneyLabel.text = "Argent : \(Inventory.sharedInstance.money)"
        }
    }
    
    @objc func timerFun(){
        if(isMoving == false){
            speedLabel.text = "Vitesse : 0.0 km/h"
            moneyLabel.text = "Argent : \(Inventory.sharedInstance.money)"
        }
        else {isMoving = false}
    }
}

