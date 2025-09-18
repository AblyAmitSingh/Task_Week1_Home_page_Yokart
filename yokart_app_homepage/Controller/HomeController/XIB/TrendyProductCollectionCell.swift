//
//  TrendyProductCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit
import SDWebImage

class TrendyProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var contentStackView: UIView!
    
    @IBOutlet weak var biggerStackView: UIView!
    @IBOutlet weak var smallStackViewS: UIView!
    @IBOutlet weak var smallStackViewT: UIView!
    
    @IBOutlet weak var viewPriceF: UIView!
    @IBOutlet weak var imgProductF: UIImageView!
    @IBOutlet weak var lblProductPricingF: UILabel!
    
    @IBOutlet weak var imgProductS: UIImageView!
    @IBOutlet weak var viewPriceS: UIView!
    @IBOutlet weak var lblPriceS: UILabel!
    
    @IBOutlet weak var imgProductT: UIImageView!
    @IBOutlet weak var viewPriceT: UIView!
    @IBOutlet weak var lblPriceT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellLayout()
    }
    
    
    
    // MARK: -  Configure Cell Data
    func configureProductCell(items: [Product]) {
        if items.indices.contains(0) {
            let p = items[0]
            lblProductPricingF.text = p.selprodPrice
            if let iconURL = p.productImageURL, let url = URL(string: iconURL) {
                self.imgProductF.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
            }
            biggerStackView.isHidden = false
        } else {
            biggerStackView.isHidden = true
        }
        
        if items.indices.contains(1) {
            let p = items[1]
            lblPriceS.text = p.selprodPrice
            if let iconURL = p.productImageURL, let url = URL(string: iconURL) {
                self.imgProductS.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
            }
            smallStackViewS.isHidden = false
        } else {
            smallStackViewS.isHidden = true
        }
        
        if items.indices.contains(2) {
            let p = items[2]
            lblPriceT.text = p.selprodPrice
            if let iconURL = p.productImageURL, let url = URL(string: iconURL) {
                self.imgProductT.sd_setImage(with: url, placeholderImage: UIImage(systemName: "placeholder"), options: .highPriority, completed: nil)
            }
            smallStackViewT.isHidden = false
        } else {
            smallStackViewT.isHidden = true
        }
    }
    
    //  Configure Cell Layout and styling
    private func configureCellLayout() {
        self.viewPriceF.layer.cornerRadius = 10
        self.viewPriceS.layer.cornerRadius = 10
        self.viewPriceT.layer.cornerRadius = 10
        
        self.biggerStackView.layer.cornerRadius = 10
        self.biggerStackView.layer.borderWidth = 1
        self.biggerStackView.layer.borderColor = UIColor.lightGray.cgColor
        self.imgProductF.layer.cornerRadius = 10
        
        self.smallStackViewS.layer.cornerRadius = 10
        self.smallStackViewS.layer.borderWidth = 1
        self.smallStackViewS.layer.borderColor = UIColor.lightGray.cgColor
        self.imgProductS.layer.cornerRadius = 10
        
        self.smallStackViewT.layer.cornerRadius = 10
        self.smallStackViewT.layer.borderWidth = 1
        self.smallStackViewT.layer.borderColor = UIColor.lightGray.cgColor
        self.imgProductT.layer.cornerRadius = 10
    }
    
}
