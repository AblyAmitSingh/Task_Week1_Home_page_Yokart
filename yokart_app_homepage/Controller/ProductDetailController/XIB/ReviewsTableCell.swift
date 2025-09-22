//
//  ReviewsTableCell.swift
//  yokart_app_homepage
//
//  Created by User on 22/09/25.
//

import UIKit

class ReviewsTableCell: UITableViewCell {
    
    @IBOutlet weak var lblAverageRating: UILabel!
    @IBOutlet weak var lblTotalReview: UILabel!
    
    @IBOutlet weak var progressBarF: UIProgressView!  // first progress bar
    @IBOutlet weak var lblProgressValueF: UILabel!
    
    @IBOutlet weak var progressBarS: UIProgressView!  // second progress bar
    @IBOutlet weak var lblProgressValueS: UILabel!
    
    @IBOutlet weak var progressBarT: UIProgressView!  // third progress bar
    @IBOutlet weak var lblProgressValueT: UILabel!
    
    @IBOutlet weak var progressBarFourth: UIProgressView!  // fourth progress bar
    @IBOutlet weak var lblProgressValueFourth: UILabel!
    
    @IBOutlet weak var progressBarFifth: UIProgressView!  // fifth progress bar
    @IBOutlet weak var lblProgressValueFifth: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInitViewLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func configureInitViewLayout(){
        self.progressBarF.trackTintColor = .darkGray
        self.progressBarS.trackTintColor = .darkGray
        self.progressBarT.trackTintColor = .darkGray
        self.progressBarFourth.trackTintColor = .darkGray
        self.progressBarFifth.trackTintColor = .darkGray
        
        let progressTint = UIColor(white: 0.4, alpha: 1.0)
        
        self.progressBarF.progressTintColor = progressTint
        self.progressBarS.progressTintColor = progressTint
        self.progressBarT.progressTintColor = progressTint
        self.progressBarFourth.progressTintColor = progressTint
        self.progressBarFifth.progressTintColor = progressTint
    }
    
    func configureCell(data: Reviews) {
        let totalRatings = Float(data.withoutImages?.totRatings ?? "0") ?? 0.0
        let rated1 = Float(data.withoutImages?.rated1 ?? "0") ?? 0.0
        let rated2 = Float(data.withoutImages?.rated2 ?? "0") ?? 0.0
        let rated3 = Float(data.withoutImages?.rated3 ?? "0") ?? 0.0
        let rated4 = Float(data.withoutImages?.rated4 ?? "0") ?? 0.0
        let rated5 = Float(data.withoutImages?.rated5 ?? "0") ?? 0.0
        
        self.lblAverageRating.text = "\(data.withoutImages?.prodRating ?? "0.0")"
        self.lblTotalReview.text = "\(Int(totalRatings)) Reviews"
        self.lblProgressValueF.text = "\(rated5)"     // 5 star
        self.lblProgressValueS.text = "\(rated4)"     // 4 star
        self.lblProgressValueT.text = "\(rated3)"     // 3 star
        self.lblProgressValueFourth.text = "\(rated2)"// 2 star
        self.lblProgressValueFifth.text = "\(rated1)" // 1 star
        
        guard totalRatings > 0 else {
            self.progressBarF.progress = 0
            self.progressBarS.progress = 0
            self.progressBarT.progress = 0
            self.progressBarFourth.progress = 0
            self.progressBarFifth.progress = 0
            return
        }
        
        self.progressBarF.progress = rated5 / totalRatings
        self.progressBarS.progress = rated4 / totalRatings
        self.progressBarT.progress = rated3 / totalRatings
        self.progressBarFourth.progress = rated2 / totalRatings
        self.progressBarFifth.progress = rated1 / totalRatings
        
    }
}
