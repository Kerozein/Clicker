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
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {action, indexPath in
            self.myItems.remove(at: indexPath.row)
            Inventory.sharedInstance.inventoryItems.remove(at: indexPath.row)
            self.inventoryTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
