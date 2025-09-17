//
//  ServicesCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit

class ServicesCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblProductType: UILabel!
    
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCellData() {
        self.lblProductType.text = "Packaging"
        self.lblProductDescription.text = "Luxury Candles"
        self.lblProductPrice.text = "Rs 200"
    }
}
