//
//  InventoryController.swift
//  Clicker
//
//  Created by Lou Favre on 17/04/2023.
//

import UIKit
class InventoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var myItems = Inventory.sharedInstance.inventoryItems
    @IBOutlet var inventoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.getItems), userInfo: nil, repeats: true)
        
        let inventoryNib = UINib(nibName: "InventoryTableViewCell", bundle: nil)
        inventoryTableView.register(inventoryNib, forCellReuseIdentifier: "InventoryTableViewCell")
        inventoryTableView.delegate = self
        inventoryTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Supprimer") {action, indexPath in
            self.myItems.remove(at: indexPath.row)
            Inventory.sharedInstance.inventoryItems.remove(at: indexPath.row)
            self.inventoryTableView.deleteRows(at: [indexPath], with: .automatic)
            self.showToast(message: "Item supprimé", font: .systemFont(ofSize: 12.0))
        }
        
        let useAction = UITableViewRowAction(style: .normal, title: "Utiliser") {action, indexPath in
            if(Inventory.sharedInstance.buffTime == 0){
                switch self.myItems[indexPath.row] {
                case "Epée":
                    Inventory.sharedInstance.buff = 3
                    Inventory.sharedInstance.hitCooldown = 1
                case "Dague":
                    Inventory.sharedInstance.buff = 1.2
                case "Claymore":
                    Inventory.sharedInstance.buff = 5
                    Inventory.sharedInstance.hitCooldown = 4
                case "Machette":
                    Inventory.sharedInstance.buff = 1.3
                case "Rapière":
                    Inventory.sharedInstance.buff = 1.6
                case "Potion":
                    Inventory.sharedInstance.buff = 1.05
                default:
                    Inventory.sharedInstance.buff = 1
                }
                Inventory.sharedInstance.buffTime = 20
                self.myItems.remove(at: indexPath.row)
                Inventory.sharedInstance.inventoryItems.remove(at: indexPath.row)
                self.inventoryTableView.deleteRows(at: [indexPath], with: .automatic)
                self.showToast(message: "Item utilisé pour une durée de 20 secondes", font: .systemFont(ofSize: 12.0))
            }
            else{
                self.showToast(message: "Un objet est deja en cours d'utilisation", font: .systemFont(ofSize: 12.0))
            }
            
        }
        return [deleteAction,useAction]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryTableViewCell", for: indexPath) as! InventoryTableViewCell
        cell.myItemLabel.text = myItems[indexPath.row]
        
        return cell
    }
    @objc func getItems(){
        if(Inventory.sharedInstance.update == true){
            myItems = Inventory.sharedInstance.inventoryItems
            
            self.inventoryTableView.reloadData()
            Inventory.sharedInstance.update = false
        }

    }
}
