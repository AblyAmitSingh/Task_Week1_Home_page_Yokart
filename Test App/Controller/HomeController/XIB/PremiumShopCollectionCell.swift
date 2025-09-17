//
//  PremiumShopCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit

class PremiumShopCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblShowLocation: UILabel!
    @IBOutlet weak var btnShopNow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    
    func configureCell() {
        lblShopName.text = "Paradise"
        lblShowLocation.text = "England United Kingdom"
        btnShopNow.layer.borderColor = UIColor.lightGray.cgColor
        btnShopNow.layer.borderWidth = 1.0
    }
}
