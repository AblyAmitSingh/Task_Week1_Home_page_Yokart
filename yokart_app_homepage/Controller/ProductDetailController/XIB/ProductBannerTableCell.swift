//
//  ProductBannerTableCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

class ProductBannerTableCell: UITableViewCell {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var contentDataModel:[ProductImage]? {
        didSet{
            self.productsCollectionView.reloadData()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // Register cell
    private func registerCollectionCell() {
        self.productsCollectionView.delegate = self
        self.productsCollectionView.dataSource = self
        self.productsCollectionView.register(UINib(nibName: "ProductBannerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProductBannerCollectionCell")
    }
}

//  MARK: - UICollectionView Delegate , DataSource and FlowLayout Delegate Methods
extension ProductBannerTableCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contentDataModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBannerCollectionCell", for: indexPath) as! ProductBannerCollectionCell
        if let data = contentDataModel {
            cell.configureCell(data: data[indexPath.item])
        }
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.productsCollectionView.frame.size.width, height: 300)
    }
}
