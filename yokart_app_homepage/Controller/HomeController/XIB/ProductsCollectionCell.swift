//
//  ProductsCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit
import SDWebImage

class ProductsCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var contentVw: UIView!
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var lblProductPricing: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgProduct.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    
    // Configure cell data
    func configureCell(data: Product) {
        self.lblProductName.text = data.prodcatName ?? "No name"
        self.lblProductDescription.text = data.prodcatName
        self.lblProductPricing.text = "\(data.theprice ?? "0")"
        
        if let iconURL = data.productImageURL, let url = URL(string: iconURL) {
            self.imgProduct.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
        
        self.contentVw.layer.cornerRadius = 10.0
        self.contentVw.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        self.contentVw.layer.borderWidth = 1.5
    }
}
