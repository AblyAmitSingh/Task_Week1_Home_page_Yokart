//
//  ProductDetailController.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

enum ProductSection: String {
    case productImage = "2"
    case productPricing = "1"
   case productDescription = "15"
    
    var cellIdentifier: String {
        switch self {
        case .productImage:
            return "ProductBannerTableCell"
        case .productPricing:
            return "ProductPricingCell"
        case .productDescription:
            return "ProductDescriptionCell"
        }
    
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .productImage:
            return 300
        case .productPricing:
            return UITableView.automaticDimension
        case .productDescription:
            return 200
        }
    }
}

class ProductDetailController : UIViewController {
    
    //  MARK: UIView IBOutlet Connections
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var productDetailTableView: UITableView!
    
    private let viewModel = ProductsViewModel()
    var productModel: Product?
    private var sectionsDataModel: [Content] = []

    var isProductDetail: Bool = false
   
    // MARK: - UIView Lifecycle Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        registerTableViewCell()
        fetchProductDetail()
    }
    
    
    private func registerTableViewCell() {
        self.productDetailTableView.delegate = self
        self.productDetailTableView.dataSource = self
        self.productDetailTableView.register(UINib(nibName: "ProductBannerTableCell", bundle: nil), forCellReuseIdentifier: "ProductBannerTableCell")
        self.productDetailTableView.register(UINib(nibName: "ProductPricingCell", bundle: nil), forCellReuseIdentifier: "ProductPricingCell")
        self.productDetailTableView.register(UINib(nibName: "ProductDescriptionCell", bundle: nil), forCellReuseIdentifier: "ProductDescriptionCell")
    }
    
    private func fetchProductDetail() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            
            if let collections = self.viewModel.productDetails?.data?.data {
                self.sectionsDataModel = collections
            }
            DispatchQueue.main.async {
                self.productDetailTableView.reloadData()
            }
        }
        
        self.viewModel.fetchProductDetailsAPI(productId: productModel?.selprodID ?? "0", page: 1)
    }
    
    //  MARK: - Button Actions
    @IBAction func onClickBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//  MARK: UITableView Delegate & DataSource Methods
extension ProductDetailController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collection = sectionsDataModel[indexPath.section]
        let collectionName = collection.type ?? ""
        
        guard let collectionType = ProductSection(rawValue: collectionName) else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Unknown Collection"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionType.cellIdentifier, for: indexPath)
        
        switch collectionType {
        case .productImage:
            if let categoryCell = cell as? ProductBannerTableCell, let data = sectionsDataModel[indexPath.section].productImages,!data.isEmpty {
                categoryCell.contentDataModel = data
            }
        case .productPricing:
            if let pricingCell = cell as? ProductPricingCell, let priceData = sectionsDataModel[indexPath.section].productDetail{
                pricingCell.configureCell(data: priceData)
            }
            return cell
        case .productDescription:
            if let descriptionCell = cell as? ProductDescriptionCell, let description = sectionsDataModel[indexPath.section].productDescription{
                descriptionCell.configureCell(description: description)
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let collection = sectionsDataModel[indexPath.section]
        let collectionName = collection.type ?? ""
        if let collectionType = ProductSection(rawValue: collectionName) {
            return collectionType.rowHeight
        }
        return 200
    }
}
