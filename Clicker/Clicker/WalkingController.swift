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
    var count:Int = 0
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var footprint: UIImageView!
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initatialisation du detecteur de position/vitesse
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        resetSpeedAndPicture()
        updateMoneyLabel()
        
        //Lancement des timers
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.resetSpeedAndPicture), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateMoneyLabel), userInfo: nil, repeats: true)
    }
    
    //Fonction appellé lorsqu'un deplacement est detecté
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        // Sert a ne pas utiliser le premier appel du detecteur de vitesse
        if(count == 0){
            count = 1
            return
        }
        
        // On s'assure que le joueur se déplace a plus de 2km/h avant de lui donner une récompense
        if(location.speed*3.6 > 2)
        {
            footprint.image=UIImage(named: "foot_green")
            isMoving=true
            speedLabel.text = "Vitesse : \(round(location.speed * 3.6 * 100) / 100.0) km/h"
            Inventory.sharedInstance.money += 5
        }
    }
    
    @objc func resetSpeedAndPicture(){
        if(isMoving == false){
            speedLabel.text = "Vitesse : 0.0 km/h"
            footprint.image=UIImage(named: "foot_red")
        }
        else {isMoving = false}
    }
    
    @objc func updateMoneyLabel(){moneyLabel.text = "Argent : \(Inventory.sharedInstance.money)$"}
}

