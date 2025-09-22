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
    
    var bannerDataModel:[BannerModel]? {
        didSet{
            self.productsCollectionView.reloadData()
        }
    }
    
    var sectionType: ProductSection = .banner

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
        return (sectionType == .banner ) ? self.bannerDataModel?.count ?? 0 : self.contentDataModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBannerCollectionCell", for: indexPath) as! ProductBannerCollectionCell
        if (sectionType == .banner ) {
            if let data = bannerDataModel {
                cell.configureCell(data: data[indexPath.item].bannerImageUrl, type: .banner)
            }
        } else {
            if let data = contentDataModel {
                cell.configureCell(data: data[indexPath.item].productImageUrl, type: .productImage)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if sectionType == .productImage {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if sectionType == .productImage {
            return CGSize(width: self.productsCollectionView.frame.size.width, height: 320)
        } else {
            return CGSize(width: self.productsCollectionView.frame.size.width - 20, height: 200)
        }
    }
}
