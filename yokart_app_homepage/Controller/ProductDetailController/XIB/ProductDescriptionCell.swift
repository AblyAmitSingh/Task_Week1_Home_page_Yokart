//
//  ProductDescriptionCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

class ProductDescriptionCell: UITableViewCell {

    @IBOutlet weak var lblProductDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(description: String) {
        self.lblProductDescription.text = description
    }
    
}
