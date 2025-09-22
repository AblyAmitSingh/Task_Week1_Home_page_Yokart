//
//  SimilarProductCollectionCell.swift
//  yokart_app_homepage
//
//  Created by User on 22/09/25.
//

import UIKit
import SDWebImage

class SimilarProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInitView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgProduct.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    // Configure Cell
    func configureInitView() {
        self.contentVw.layer.cornerRadius = 10.0
        self.contentVw.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        self.contentVw.layer.borderWidth = 1.5
    }
    
    // Configure cell data
    func configureCell(data: ProductDetail) {
        self.lblProductName.text = data.prodcatName ?? "No name"
        self.lblProductDescription.text = data.productName ?? ""
        self.lblProductPrice.text = "\(data.theprice ?? "0") - \(data.discount ?? "0")"
        
        if let iconURL = data.productImageUrl, let url = URL(string: iconURL) {
            self.imgProduct.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
