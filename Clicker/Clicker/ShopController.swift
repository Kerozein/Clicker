//
//  ShopController.swift
//  Clicker
//
//  Created by Lou Favre on 03/04/2023.
//

import UIKit

class ShopController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    // liste des items pouvant être acheter dans le shop
    let itemData = ["Epée","Dague","Claymore","Machette","Rapière","Potion"]
    // prix pour chaque item
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
    
    // Implémentation d'une table view pour avoir la liste de tous les items
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
    
    // Fonction du click du bouton "Acheter"
    @objc func buyItemButtonAction(sender:UIButton) {
        let indexPath = IndexPath(row:sender.tag, section:0)
        
        let cell = itemData[indexPath.row]
        
        // on vérifie si l'utilisateur a assez d'argent pour acheter l'item, avant de l'ajouter à l'inventaire
        if(Inventory.sharedInstance.money >= Int(itemPrice[indexPath.row].dropLast())!){
            Inventory.sharedInstance.inventoryItems.append(cell)
            Inventory.sharedInstance.update = true
            Inventory.sharedInstance.money -= Int(itemPrice[indexPath.row].dropLast())!
            self.showToast(message: "\(itemData[indexPath.row]) achetée", font: .systemFont(ofSize: 12.0))
        }
        else {
            self.showToast(message: "Vous n'avez pas assez d'argent", font: .systemFont(ofSize: 12.0))
        }

    }
}

//Ajout d'une extension pour pouvoir faire des toasts.
extension UIViewController {
    func showToast(message: String, font:UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height - 200, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in toastLabel.removeFromSuperview()})
    }
}
