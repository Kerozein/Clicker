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
    var money = 0

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if(location.speed > 2)
        {
            speedLabel.text = "Vitesse : \(location.speed * 3.6) km/h"
            money += 5
            moneyLabel.text = "Argent : \(money)"
        }
        //TODO : RESET VITESSE A 0 BOUFFON
    }
}

