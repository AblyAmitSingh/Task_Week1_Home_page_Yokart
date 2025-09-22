//
//  SimilarProductTableCell.swift
//  yokart_app_homepage
//
//  Created by User on 22/09/25.
//

import UIKit

class SimilarProductTableCell: UITableViewCell {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var similarProductsModel:[ProductDetail]? {
        didSet{
            self.productsCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCollectionCell()
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func registerCollectionCell() {
        self.productsCollectionView.delegate = self
        self.productsCollectionView.dataSource = self
        self.productsCollectionView.register(UINib(nibName: "SimilarProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SimilarProductCollectionCell")
    }
    
}

//  MARK: - UITableView Delegate & DataSource Methods
extension SimilarProductTableCell : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarProductsModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarProductCollectionCell", for: indexPath) as! SimilarProductCollectionCell
        if let data = self.similarProductsModel {
            productCell.configureCell(data: data[indexPath.row])
        }
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.productsCollectionView.frame.size.width / 2.5, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
