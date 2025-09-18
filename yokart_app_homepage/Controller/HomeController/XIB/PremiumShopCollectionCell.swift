//
//  PremiumShopCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit
import SDWebImage

class PremiumShopCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblShowLocation: UILabel!
    @IBOutlet weak var btnShopNow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func configureCell(data: Shop) {
        lblShopName.text = data.shopName ?? ""
        lblShowLocation.text = data.countryName ?? ""
        if let iconURL = data.shopLogo, let url = URL(string: iconURL) {
            self.imgShop.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
        btnShopNow.layer.borderColor = UIColor.lightGray.cgColor
        btnShopNow.layer.borderWidth = 1.0
        btnShopNow.layer.cornerRadius = 5.0
        
        imgShop.layer.borderColor = UIColor.lightGray.cgColor
        imgShop.layer.borderWidth = 1.0
        imgShop.layer.cornerRadius = 5.0
    }
}
