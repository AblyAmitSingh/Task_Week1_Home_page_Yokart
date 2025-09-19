//
//  BadgesCollectionCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit
import SDWebImage

class BadgesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgBadges: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureBadges(badges: Badge) {
        if let iconURL = badges.url, let url = URL(string: iconURL) {
            self.imgBadges.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
