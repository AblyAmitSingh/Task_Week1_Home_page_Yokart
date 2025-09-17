//
//  ShopCategoryCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

class ShopCategoryCollectionCell: UICollectionViewCell {

    //  MARK:  UICollectionView Cell IBOutlet Connections
    @IBOutlet weak var imgCategoryIcon: UIImageView!
    
    @IBOutlet weak var lblCategoryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    //  Configure Cell
    
    func configureCell(data: Category) {
        self.imgCategoryIcon.image = UIImage(systemName: "")
        self.lblCategoryName.text = data.prodcatName ?? "NA"
        self.imgCategoryIcon.layer.cornerRadius = self.imgCategoryIcon.frame.size.height / 2.0
        if let iconURL = data.categoryImageURL, let url = URL(string: iconURL) {
            self.imgCategoryIcon.loadImage(from: url)
        }
    }
}
