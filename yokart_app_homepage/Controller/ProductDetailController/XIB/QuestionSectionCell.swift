//
//  QuestionSectionCell.swift
//  yokart_app_homepage
//
//  Created by User on 22/09/25.
//

import UIKit

class QuestionSectionCell: UITableViewCell {

    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTotalReviews: UILabel!
    
    @IBOutlet weak var btnQuestion: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configureCell() {
        self.btnQuestion.layer.cornerRadius = 8.0
        self.btnQuestion.layer.borderWidth = 1.5
        self.btnQuestion.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    //  Configure cell
    func configureCell(data: Store) {
        self.lblShopName.text = data.shopName ?? ""
        self.lblTotalReviews.text = "\(data.shopTotalReviews ?? "0")"
        self.lblRating.text = "\(data.shopRating ?? "0") Reviews"
    }
    
    //  MARK: - Button Action
    @IBAction func onClickAskQuestionAction(_ sender: Any) {
        
    }
    
}
