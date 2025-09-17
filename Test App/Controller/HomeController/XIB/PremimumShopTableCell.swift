//
//  PremimumShopTableCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit

class PremimumShopTableCell: UITableViewCell {
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // Register Collection View Cell
    private func registerCollectionCell() {
        shopsCollectionView.delegate = self
        shopsCollectionView.dataSource = self
        shopsCollectionView.register(UINib(nibName: "PremiumShopCollectionCel", bundle: nil), forCellWithReuseIdentifier: "PremiumShopCollectionCel")
    }
}

//  MARK: -  CollectionView Delegate & DataSource Methods
extension PremimumShopTableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! PremiumShopCollectionCell
        return cell
    }
    
    // flow layout setup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.5, height: 250)
    }
}
