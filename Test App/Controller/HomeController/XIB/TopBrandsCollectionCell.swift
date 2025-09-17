//
//  TopBrandsCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

class TopBrandsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // Configure cell data
    func configureCell(data: Banner) {
        if let iconURL = data.bannerImage, let url = URL(string: iconURL) {
            self.imgBanner.loadImage(from: url)
        }
        self.contentVw.layer.cornerRadius = self.contentVw.frame.size.height / 2.0
        self.contentVw.layer.borderWidth = 0.5
        self.contentVw.layer.borderColor = UIColor.lightGray.cgColor
        self.imgBanner.layer.cornerRadius = self.imgBanner.frame.size.height / 2.0
    }
}
