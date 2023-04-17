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
    var count = 0
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var footprint: UIImageView!
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        timerFun()
        updateMoneyLabel()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.timerFun), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateMoneyLabel), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        // Sert a ne pas utiliser le premier appel du detecteur de vitesse
        if(count == 0){
            count = 1
            return
        }
        
        if(location.speed > 2)
        {
            footprint.image=UIImage(named: "foot_green")
            isMoving=true
            speedLabel.text = "Vitesse : \(round(location.speed * 3.6 * 100) / 100.0) km/h"
            Inventory.sharedInstance.money += 5
        }
    }
    
    @objc func timerFun(){
        if(isMoving == false){
            speedLabel.text = "Vitesse : 0.0 km/h"
            footprint.image=UIImage(named: "foot_red")
        }
        else {isMoving = false}
    }
    
    @objc func updateMoneyLabel(){moneyLabel.text = "Argent : \(Inventory.sharedInstance.money)$"}
}

