//
//  PremiumShopTableCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit

class PremiumShopTableCell: UITableViewCell {
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //  Register Collection Cell
    private func registerCollectionCell() {
        shopsCollectionView.delegate = self
        shopsCollectionView.dataSource = self
        shopsCollectionView.register(UINib(nibName: "PremiumShopCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PremiumShopCollectionCell")
    }
    
}

//  MARK: -  UICollectionView Delegate & DataSource Methods
extension PremiumShopTableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PremiumShopCollectionCell", for: indexPath) as! PremiumShopCollectionCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.shopsCollectionView.frame.size.width / 2.5, height: 250)
    }
}
