//
//  ProductSubcategoryCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

class ProductSubcategoryCell: UICollectionViewCell {

    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }

    
    private func setLayout() {
        self.contentVw.layer.cornerRadius = 15.0
        self.contentVw.layer.borderWidth = 1.0
        self.contentVw.layer.borderColor = UIColor.blue.cgColor
    }
    
    func configureCell(data: Category) {
        self.lblTitle.text = data.prodcatName ?? ""
    }
}
