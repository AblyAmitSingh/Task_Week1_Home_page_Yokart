//
//  ServicesCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit
import SDWebImage

class ServicesCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblProductType: UILabel!
    
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellLayout()
    }

    private func configureCellLayout() {
        self.contentVw.layer.cornerRadius = 8.0
        self.contentVw.layer.borderColor = UIColor.lightGray.cgColor
        self.contentVw.layer.borderWidth = 1.0
        self.imgService.layer.cornerRadius = 8.0

    }
    
    // Configure cell
    func configureCell(data: Product) {
        self.lblProductType.text = data.prodcatName ?? ""
        self.lblProductDescription.text = data.productName ?? "NA"
        self.lblProductPrice.text = data.selprodPrice ?? "NA"
        if let iconURL = data.productImageURL, let url = URL(string: iconURL) {
            self.imgService.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
        }
    }
}
