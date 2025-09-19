//
//  ProductsTableViewCell.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//

import UIKit

//  Tap Gesture event when usr will tap on cell
protocol ProductTapEventDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productCategoryCollectionView: UICollectionView!
    @IBOutlet weak var productCategoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var products: [Product]? {
        didSet {
            productsCollectionView.reloadData()
        }
    }
    
    var categories: [Category]? {
        didSet {
            productCategoryCollectionView.reloadData()
        }
    }
    

    
    var sectionType: CollectionType = .categories {
        didSet {
            if sectionType == .bestsellingCategories {
                productCategoryCollectionView.isHidden = false
                productCategoryHeightConstraint.constant = 30
            } else {
                productCategoryCollectionView.isHidden = true
                productCategoryHeightConstraint.constant = 0
            }
            productCategoryCollectionView.reloadData()
        }
    }
    
    var selectedIndex: Int = 0
    weak var delegate: ProductTapEventDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
        
        self.productCategoryCollectionView.isHidden = true
        self.productCategoryHeightConstraint.constant = 0
        
        if sectionType == .bestsellingCategories {
            self.productCategoryCollectionView.isHidden = false
            self.productCategoryHeightConstraint.constant = 30
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func registerCollectionCell() {
        productsCollectionView.register(UINib(nibName: "ProductsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCollectionCell")
        
        productCategoryCollectionView.register(UINib(nibName: "ProductSubcategoryCell", bundle: nil), forCellWithReuseIdentifier: "ProductSubcategoryCell")
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        productCategoryCollectionView.delegate = self
        productCategoryCollectionView.dataSource = self
    }
}

// MARK: - UICollectionView Delegate, DataSource, and FlowLayout
extension ProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productsCollectionView {
            return self.products?.count ?? 0
        } else if collectionView == productCategoryCollectionView {
            return self.categories?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionCell", for: indexPath) as! ProductsCollectionCell
            if let productModel = products?[indexPath.item] {
                cell.configureCell(data: productModel)
            }
            return cell
        } else if collectionView == productCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSubcategoryCell", for: indexPath) as! ProductSubcategoryCell
            if let subcategory = categories?[indexPath.item] {
                if indexPath.item == selectedIndex {
                    cell.contentVw.backgroundColor = UIColor.lightGray
                } else {
                    cell.contentVw.backgroundColor = UIColor.clear
                }
                cell.configureCell(data: subcategory)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCategoryCollectionView {
            selectedIndex = indexPath.row
            self.productCategoryCollectionView.reloadData()
        } else if collectionView == productsCollectionView && self.sectionType == .mostDemanded{
            if let product = products?[indexPath.item] {
                delegate?.didSelectProduct(product)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productsCollectionView {
            return CGSize(width: self.productsCollectionView.frame.size.width / 2.5, height: 240)
        } else if collectionView == productCategoryCollectionView {
            return CGSize(width: self.productCategoryCollectionView.frame.size.width / 2.5, height: 30)
        }
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

