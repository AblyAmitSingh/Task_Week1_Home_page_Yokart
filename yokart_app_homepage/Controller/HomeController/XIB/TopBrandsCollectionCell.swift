//
//  TopBrandsCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit
import SDWebImage

class TopBrandsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInitLayout()
    }

    private func configureInitLayout() {
        self.imgBanner.layer.cornerRadius = 10
        self.contentVw.layer.cornerRadius = 10
        self.contentVw.layer.borderWidth = 0.5
        self.contentVw.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // Configure cell data
    func configureCell(data: Banner) {
        if let iconURL = data.bannerImage, let url = URL(string: iconURL) {
            self.imgBanner.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
