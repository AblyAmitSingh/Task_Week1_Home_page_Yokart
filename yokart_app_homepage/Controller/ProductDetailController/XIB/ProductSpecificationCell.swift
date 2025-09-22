//
//  ProductSpecificationCell.swift
//  yokart_app_homepage
//
//  Created by User on 22/09/25.
//

import UIKit

class ProductSpecificationCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // Configure cell
    func configureCell(specifications: ProductSpecification) {
        self.lblTitle.text = specifications.prodspecName ?? ""
        self.lblDescription.text = specifications.prodspecValue ?? ""
        self.lblDescription.numberOfLines = 0
        self.lblDescription.lineBreakMode = .byWordWrapping
    }
}
