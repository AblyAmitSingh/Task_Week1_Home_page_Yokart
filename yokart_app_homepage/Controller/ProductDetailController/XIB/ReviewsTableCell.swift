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
    

    @IBOutlet weak var progressTableView: UITableView!
    

    
    var reviews: [ReviewDataModel]? {
        didSet {
            self.progressTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInitViewLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func configureInitViewLayout(){
        self.progressTableView.delegate = self
        self.progressTableView.dataSource = self
        self.progressTableView.register(UINib(nibName: "ProgressBarCell", bundle: nil), forCellReuseIdentifier: "ProgressBarCell")
    }
    
    func configureCell(data: Reviews) {
        let totalRatings = Float(data.withoutImages?.totRatings ?? "0") ?? 0.0
        self.lblAverageRating.text = "\(data.withoutImages?.prodRating ?? "0.0")"
        self.lblTotalReview.text = "\(Int(totalRatings)) Reviews"
    }
}

extension ReviewsTableCell : UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressBarCell", for: indexPath) as! ProgressBarCell
        if let review = self.reviews {
            cell.configureCell(reviews: review[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
