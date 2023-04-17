//
//  TableViewCell.swift
//  Clicker
//
//  Created by Lou Favre on 17/04/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    @IBOutlet var buyItemButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
