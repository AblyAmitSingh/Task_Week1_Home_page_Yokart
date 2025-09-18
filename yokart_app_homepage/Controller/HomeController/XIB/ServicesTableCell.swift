//
//  ServicesTableCell.swift
//  yokart_app_homepage
//
//  Created by User on 18/09/25.
//

import UIKit

class ServicesTableCell: UITableViewCell {

    //  MARK:  IBOutlet Connections
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    
    var servicesDataModel: [Product]? {
        didSet {
            servicesCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //  Register Collection view cell
    private func registerCollectionCell() {
        self.servicesCollectionView.delegate = self
        self.servicesCollectionView.dataSource = self
        self.servicesCollectionView.register(UINib(nibName: "ServicesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ServicesCollectionCell")
    }
    
}


//  MARK: - UICollection View Delegate & DataSource Methods
extension ServicesTableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servicesDataModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCollectionCell", for: indexPath) as! ServicesCollectionCell
        if let dataModel = servicesDataModel {
            cell.configureCell(data: dataModel[indexPath.item])
        }
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.servicesCollectionView.frame.size.width / 1.3, height: 120)
    }
}
