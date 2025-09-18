//
//  TrendyProductCollectionCell.swift
//  Test App
//
//  Created by Ably Soft on 17/09/25.
//

import UIKit

class TrendyProductsTableCell: UITableViewCell {
    
    @IBOutlet weak var trendyProductsCollectionView: UICollectionView!
    
    var products: [Product]? {
        didSet {
            trendyProductsCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }
    
    private func registerCollectionCell() {
        trendyProductsCollectionView.register(UINib(nibName: "TrendyProductCollectionCell", bundle: nil),
                                              forCellWithReuseIdentifier: "TrendyProductCollectionCell")
        trendyProductsCollectionView.delegate = self
        trendyProductsCollectionView.dataSource = self
    }
}

extension TrendyProductsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = products else { return 0 }
        return Int(ceil(Double(products.count) / 3.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendyProductCollectionCell", for: indexPath) as! TrendyProductCollectionCell
        
        guard let products = products else { return cell }
        
        let startIndex = indexPath.item * 3
        let endIndex = min(startIndex + 3, products.count)
        
        let chunk = Array(products[startIndex..<endIndex])
        
        cell.configureProductCell(items: chunk)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 220)
    }
}
