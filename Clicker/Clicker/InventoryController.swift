//
//  InventoryController.swift
//  Clicker
//
//  Created by Lou Favre on 17/04/2023.
//

import UIKit
var global:String? = nil
class InventoryController: UIViewController {

    @IBOutlet weak var myItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myItem.text = global
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
