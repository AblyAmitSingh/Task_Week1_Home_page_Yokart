//
//  ProductsCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

class ProductsCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var contentVw: UIView!
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var lblProductPricing: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // Configure cell data
    func configureCell(data: Product) {
        self.lblProductName.text = data.prodcatName ?? "No name"
        self.lblProductDescription.text = data.prodcatName
        self.lblProductPricing.text = "Rs: \(data.theprice ?? "0")"
        if let iconURL = data.productImageURL, let url = URL(string: iconURL) {
            self.imgProduct.loadImage(from: url)
        }
    
        self.contentVw.layer.cornerRadius = 10.0
        self.imgProduct.layer.cornerRadius = 10.0
        self.contentVw.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        self.contentVw.layer.borderWidth = 1.5
    }
}
