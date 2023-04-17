//
//  ShopController.swift
//  Clicker
//
//  Created by Lou Favre on 03/04/2023.
//

import UIKit

class ShopController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let itemData = ["Epée","Dague","Claymore","Espadon","Rapière","Potion"]
    let itemPrice = ["250$", "300$", "450$","350$","600$","150$"]
    let price = [1,2,3,4,5,6]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.itemLabel.text = itemData[indexPath.row]
        cell.itemPriceLabel.text = itemPrice[indexPath.row]
        cell.buyItemButton.tag = indexPath.row
        cell.buyItemButton.addTarget(self, action: #selector(buyItemButtonAction), for: .touchUpInside)
        return cell
    }
    
    @objc func buyItemButtonAction(sender:UIButton) {
        let indexPath = IndexPath(row:sender.tag, section:0)
        
        let cell = itemData[indexPath.row]
        
        let inventoryItem:InventoryController = self.storyboard?.instantiateViewController(withIdentifier: "inventory") as! InventoryController
        
        global = cell
        
        self.navigationController?.pushViewController(inventoryItem, animated: false)
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
