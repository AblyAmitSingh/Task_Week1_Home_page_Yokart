//
//  ShopCategoryCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit
import SDWebImage

class ShopCategoryCollectionCell: UICollectionViewCell {
    
    //  MARK:  UICollectionView Cell IBOutlet Connections
    @IBOutlet weak var imgCategoryIcon: UIImageView!
    
    @IBOutlet weak var lblCategoryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //  Configure Cell
    func configureCell(data: Category) {
        self.lblCategoryName.text = data.prodcatName ?? "NA"
        self.imgCategoryIcon.layer.cornerRadius = self.imgCategoryIcon.frame.size.height / 2.0
        
        if let iconURL = data.categoryImageURL, let url = URL(string: iconURL) {
            self.imgCategoryIcon.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
    
    // To configure brand type model
    func configureCell(brand: Brand) {
        self.lblCategoryName.text = brand.brandName ?? "NA"
        self.imgCategoryIcon.layer.cornerRadius = self.imgCategoryIcon.frame.size.height / 2.0
        
        if let iconURL = brand.brandImage, let url = URL(string: iconURL) {
            self.imgCategoryIcon.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
