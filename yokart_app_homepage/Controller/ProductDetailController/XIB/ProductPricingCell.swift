//
//  ProductPricingCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

class ProductPricingCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{


    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductSubtitle: UILabel!
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    
    var badgesModel:[Badge]? {
        didSet{
            self.badgesCollectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func registerCell() {
        self.badgesCollectionView.delegate = self
        self.badgesCollectionView.dataSource = self
        self.badgesCollectionView.register(UINib(nibName: "BadgesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BadgesCollectionCell")
    }
    
    //  Configure Cell
    func configureCell(data:ProductDetail) {
        self.lblProductTitle.text = data.brandName ?? ""
        self.lblProductSubtitle.text = data.socialShareContent?.title ?? ""
        self.lblPrice.text = "\(data.selprodPrice ?? "0")"
        self.lblQuantity.text = "Min Order QTY is:\(data.selprodMinOrderQty ?? "0")"
        self.badgesModel = data.badges ?? []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badgesModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgesCollectionCell", for: indexPath) as! BadgesCollectionCell
        if let data = self.badgesModel {
            cell.configureBadges(badges: data[indexPath.row])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}
