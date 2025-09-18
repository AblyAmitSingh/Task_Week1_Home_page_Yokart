//
//  ImageCollectionViewCell.swift
//  yokart_app_homepage
//
//  Created by User on 18/09/25.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(data: Banner) {
        self.imgProduct.layer.cornerRadius = 8
        self.viewImage.layer.cornerRadius = 8
        self.viewImage.layer.borderWidth = 1
        self.viewImage.layer.borderColor = UIColor.lightGray.cgColor
        if let iconURL = data.bannerImage, let url = URL(string: iconURL) {
            self.imgProduct.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
