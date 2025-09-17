//
//  TopBrandsTableCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

class TopBrandsTableCell: UITableViewCell {

    @IBOutlet weak var brandsListCollectionView: UICollectionView!
    
    var banners: [Banner]? {
        didSet {
            brandsListCollectionView.reloadData()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func registerCollectionCell() {
        brandsListCollectionView.register(UINib(nibName: "TopBrandsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TopBrandsCollectionCell")
        brandsListCollectionView.delegate = self
        brandsListCollectionView.dataSource = self
    }
    
}

////  MARK: -  UICollectionView Delegate , DataSource and FlowLayout
extension TopBrandsTableCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopBrandsCollectionCell", for: indexPath) as! TopBrandsCollectionCell
        if let banner = banners?[indexPath.item] {
            cell.configureCell(data: banner)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.brandsListCollectionView.frame.size.width / 2.5, height: 200)
    }
}
