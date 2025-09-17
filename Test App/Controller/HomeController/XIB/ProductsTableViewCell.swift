//
//  ProductsTableViewCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var products: [Product]? {
        didSet {
            productsCollectionView.reloadData()
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
        productsCollectionView.register(UINib(nibName: "ProductsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCollectionCell")
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
}


//  MARK: -  UICollectionView Delegate , DataSource and FlowLayout
extension ProductsTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionCell", for: indexPath) as! ProductsCollectionCell
        if let productModel = products?[indexPath.item] {
            cell.configureCell(data: productModel)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.productsCollectionView.frame.size.width / 2.5, height: 250)
    }
}
