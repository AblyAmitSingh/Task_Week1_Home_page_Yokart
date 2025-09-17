//
//  TrendyProductCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit

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
    }
    
    
    
    // MARK: -  Configure Cell Data
    func configureProductCell(items: [Product]) {
        if items.indices.contains(0) {
            let p = items[0]
            lblProductPricingF.text = p.selprodPrice
            biggerStackView.isHidden = false
        } else {
            biggerStackView.isHidden = true
        }
        
        if items.indices.contains(1) {
            let p = items[1]
            lblPriceS.text = p.selprodPrice
            smallStackViewS.isHidden = false
        } else {
            smallStackViewS.isHidden = true
        }
        
        if items.indices.contains(2) {
            let p = items[2]
            lblPriceT.text = p.selprodPrice
            smallStackViewT.isHidden = false
        } else {
            smallStackViewT.isHidden = true
        }
    }
    
}
