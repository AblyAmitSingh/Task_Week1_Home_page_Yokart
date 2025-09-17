//
//  ShopCategoryTableCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

class ShopCategoryTableCell: UITableViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categories: [Category]? {
        didSet {
            categoryCollectionView.reloadData()
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
        categoryCollectionView.register(UINib(nibName: "ShopCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ShopCategoryCollectionCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
}


//  MARK: -  UICollectionView Delegate , DataSource and FlowLayout
extension ShopCategoryTableCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCategoryCollectionCell", for: indexPath) as! ShopCategoryCollectionCell
        if let category = categories?[indexPath.item] {
            cell.configureCell(data: category)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.categoryCollectionView.frame.size.width / 5.0, height: 100)
    }
}
