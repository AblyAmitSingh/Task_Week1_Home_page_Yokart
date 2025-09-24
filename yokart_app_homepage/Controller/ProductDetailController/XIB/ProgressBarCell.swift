//
//  ProgressBarCell.swift
//  yokart_app_homepage
//
//  Created by User on 24/09/25.
//

import UIKit

class ProgressBarCell: UITableViewCell {

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var lblProgressPercentage: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureCell(reviews: ReviewDataModel) {
        self.lblRatings.text = reviews.title
        self.progressBar.progress = (Float(reviews.rating) ?? 0.0) / 5.0
        
        self.progressBar.progressTintColor = UIColor.black.withAlphaComponent(0.5)
        self.progressBar.trackTintColor = UIColor.lightGray
    }
}
