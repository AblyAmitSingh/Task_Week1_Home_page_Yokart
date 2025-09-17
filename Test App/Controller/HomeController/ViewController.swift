//
//  ProductListModel.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//


import UIKit

enum CollectionType: String {
    case categories = "Categories"
    case topProducts = "Top Products/Services"
    case mostDemanded = "Most Demanded Services"
    case trendyProducts = "Trendy Products"
    case bestsellingCategories = "Bestselling Categories"
    case segmentBanners = "Segment Banners"
    case premiumShops = "Premium Shops"
    
    var cellIdentifier: String {
        switch self {
        case .categories:
            return "ShopCategoryTableCell"
        case .topProducts, .mostDemanded:
            return "ProductsTableViewCell"
        case .trendyProducts:
            return "TrendyProductsTableCell"
        case .bestsellingCategories:
            return "ProductsTableViewCell"
        case .segmentBanners:
            return "TopBrandsTableCell"
        case .premiumShops:
            return "PremiumShopTableCell"
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .categories, .segmentBanners:
            return 100
        case .topProducts, .mostDemanded:
            return 200
        case .trendyProducts:
            return 250
        case .bestsellingCategories:
            return 200
        case .premiumShops:
            return 250
            
        }
    }
}


class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var btnRfq: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var productListTableView: UITableView!
    
    // MARK: - Properties
    private let viewModel = ProductsViewModel()
    private var sectionsDataModel: [Collection] = []
    
    // MARK: - UIView Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerTableViewCells()
        fetchProducts()
    }
    
    // MARK: - Setup
    private func configureView() {
        btnRfq.layer.cornerRadius = 10
        btnCart.layer.cornerRadius = 10
    }
    
    private func registerTableViewCells() {
        productListTableView.delegate = self
        productListTableView.dataSource = self
        
        productListTableView.register(UINib(nibName: "ShopCategoryTableCell", bundle: nil), forCellReuseIdentifier: "ShopCategoryTableCell")
        productListTableView.register(UINib(nibName: "ProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductsTableViewCell")
        productListTableView.register(UINib(nibName: "TopBrandsTableCell", bundle: nil), forCellReuseIdentifier: "TopBrandsTableCell")
        productListTableView.register(UINib(nibName: "TrendyProductsTableCell", bundle: nil), forCellReuseIdentifier: "TrendyProductsTableCell")
    }
    
    // MARK: - Data Fetching
    private func fetchProducts() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            
            if let collections = self.viewModel.productList?.data?.collections {
                self.sectionsDataModel = collections.filter {
                    ($0.categories?.isEmpty == false) ||
                    ($0.products?.isEmpty == false) ||
                    ($0.banners?.banners?.isEmpty == false)
                }
            }
            
            DispatchQueue.main.async {
                self.productListTableView.reloadData()
            }
        }
        
        viewModel.fetchProductAPI(page: 1)
    }
    
    // MARK: - Actions
    @objc func viewProductActions(_ sender: UIButton) {
        let sectionIndex = sender.tag
        let collection = sectionsDataModel[sectionIndex]
        print("See all: \(collection.collectionName ?? "")")
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collection = sectionsDataModel[indexPath.section]
        let collectionName = collection.collectionName ?? ""
        
        guard let collectionType = CollectionType(rawValue: collectionName) else {
            let cell = UITableViewCell()
            cell.textLabel?.text = ""
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionType.cellIdentifier, for: indexPath)
        
        switch collectionType {
        case .categories:
            if let categoryCell = cell as? ShopCategoryTableCell, let categories = collection.categories, !categories.isEmpty {
                categoryCell.categories = categories
            }
        case .topProducts, .mostDemanded:
            if let productCell = cell as? ProductsTableViewCell, let products = collection.products, !products.isEmpty {
                productCell.products = products
            }
        case .trendyProducts:
            if let productCell = cell as? TrendyProductsTableCell, let products = collection.products, !products.isEmpty {
                productCell.products = products
            }
            
        case .bestsellingCategories:
            if let productCell = cell as? ProductsTableViewCell, let products = collection.products, !products.isEmpty {
                productCell.products = products
            }

        case .segmentBanners:
            if let bannerCell = cell as? TopBrandsTableCell, let banners = collection.banners?.banners, !banners.isEmpty {
                bannerCell.banners = banners
            }
        
        case .premiumShops:
            if let bannerCell = cell as? PremiumShopTableCell {
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let collection = sectionsDataModel[section]
        let collectionName = collection.collectionName ?? ""
        if let collectionType = CollectionType(rawValue: collectionName), collectionType == .categories {
            return 0
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let collection = sectionsDataModel[section]
        let collectionName = collection.collectionName ?? ""
        
        if let collectionType = CollectionType(rawValue: collectionName), collectionType == .categories {
            return nil
        }
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.width - 110, height: 34))
        label.font = .boldSystemFont(ofSize: 16)
        label.text = collectionName
        label.textColor = .label
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: tableView.frame.width - 90, y: 5, width: 80, height: 34)
        button.setTitle("See All", for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(viewProductActions(_:)), for: .touchUpInside)
        
        headerView.addSubview(label)
        headerView.addSubview(button)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let collection = sectionsDataModel[indexPath.section]
        let collectionName = collection.collectionName ?? ""
        if let collectionType = CollectionType(rawValue: collectionName) {
            return collectionType.rowHeight
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1

        if indexPath.section == lastSection && indexPath.row == lastRow {
            viewModel.loadNextPage()
        }
    }
}
