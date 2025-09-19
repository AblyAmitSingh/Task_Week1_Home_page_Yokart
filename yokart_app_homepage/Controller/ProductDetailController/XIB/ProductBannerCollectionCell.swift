//
//  ProductBannerCollectionCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit
import SDWebImage

class ProductBannerCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func configureCell(data: ProductImage) {
        if let iconURL = data.productImageUrl, let url = URL(string: iconURL) {
            self.imgProduct.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
