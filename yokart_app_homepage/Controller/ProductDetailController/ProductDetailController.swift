//
//  ProductDetailController.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

import UIKit

enum ProductSection: String {
    case productImage = "2"
    case productPricing = "1"
    case productDescription = "15"
    case productSpecifications = "4"
    case shop = "13"
    case reviews = "9"
    case similarProduct = "7"
    case recommendedProducts = "8"
    case banner = "10"
    
    var cellIdentifier: String {
        switch self {
        case .productImage:
            return "ProductBannerTableCell"
        case .productPricing:
            return "ProductPricingCell"
        case .productDescription:
            return "ProductDescriptionCell"
        case .productSpecifications:
            return "ProductSpecificationCell"
        case .shop:
            return "QuestionSectionCell"
        case .reviews:
            return "ReviewsTableCell"
        case .similarProduct:
            return "SimilarProductTableCell"
        case .recommendedProducts:
            return "SimilarProductTableCell"
        case .banner:
            return "ProductBannerTableCell"
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .productImage:
            return 320
        case .productPricing:
            return UITableView.automaticDimension
        case .productDescription:
            return UITableView.automaticDimension
        case .productSpecifications:
            return UITableView.automaticDimension
        case .shop:
            return UITableView.automaticDimension
        case .reviews:
            return UITableView.automaticDimension
        case .similarProduct,.recommendedProducts:
            return 240
        case .banner:
            return 200
        }
    }
}

class ProductDetailController: UIViewController {
    
    // MARK: UIView IBOutlet Connections
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var productDetailTableView: UITableView!
    
    @IBOutlet weak var btnRequestQuote: UIButton!
    @IBOutlet weak var btnBookService: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bttnStackView: UIStackView!
    
    private let viewModel = ProductsViewModel()
    var productModel: Product?
    private var sectionsDataModel: [Content] = []
    var isProductDetail: Bool = false
    private var expandedIndexPaths: Set<IndexPath> = []
    
    // MARK: - UIView Lifecycle Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitView()
        registerTableViewCell()
        fetchProductDetail()
    }
    
    //  MARK: -  Configure Init View Layout
    private func configureInitView() {
        self.navigationController?.isNavigationBarHidden = true
        
        self.btnRequestQuote.layer.cornerRadius = 10
        self.btnRequestQuote.layer.borderWidth = 1
        self.btnRequestQuote.layer.borderColor = UIColor.darkGray.cgColor
        self.btnBookService.backgroundColor = UIColor.darkGray
        
        self.btnBookService.layer.cornerRadius = 10
        self.btnBookService.layer.borderWidth = 1
        self.btnBookService.layer.borderColor = UIColor.darkGray.cgColor
        self.btnBookService.backgroundColor = UIColor.darkGray
        self.btnBookService.tintColor = UIColor.white
        self.btnBookService.setTitleColor(UIColor.white, for: .normal)
        self.headerView.applyLightShadowAndBorder(borderColor: .darkGray, borderWidth: 0)
        self.bttnStackView.applyLightShadowAndBorder(borderColor: .darkGray, borderWidth: 0)
    }
    
    private func registerTableViewCell() {
        self.productDetailTableView.delegate = self
        self.productDetailTableView.dataSource = self
        self.productDetailTableView.register(UINib(nibName: "ProductBannerTableCell", bundle: nil), forCellReuseIdentifier: "ProductBannerTableCell")
        self.productDetailTableView.register(UINib(nibName: "ProductPricingCell", bundle: nil), forCellReuseIdentifier: "ProductPricingCell")
        self.productDetailTableView.register(UINib(nibName: "ProductDescriptionCell", bundle: nil), forCellReuseIdentifier: "ProductDescriptionCell")
        self.productDetailTableView.register(UINib(nibName: "ProductSpecificationCell", bundle: nil), forCellReuseIdentifier: "ProductSpecificationCell")
        self.productDetailTableView.register(UINib(nibName: "QuestionSectionCell", bundle: nil), forCellReuseIdentifier: "QuestionSectionCell")
        self.productDetailTableView.register(UINib(nibName: "ReviewsTableCell", bundle: nil), forCellReuseIdentifier: "ReviewsTableCell")
        self.productDetailTableView.register(UINib(nibName: "SimilarProductTableCell", bundle: nil), forCellReuseIdentifier: "SimilarProductTableCell")
        self.productDetailTableView.register(UINib(nibName: "ProductBannerTableCell", bundle: nil), forCellReuseIdentifier: "ProductBannerTableCell")
    }
    
    
    private func fetchProductDetail() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            
            if let collections = self.viewModel.productDetails?.data?.data {
                self.sectionsDataModel = collections.filter { content in
                    ProductSection(rawValue: content.type ?? "") != nil
                }
            }
            DispatchQueue.main.async {
                let title = "You are reliable electrician"
                self.lblHeaderTitle.text = title
                self.productDetailTableView.reloadData()
            }
        }
        
        self.viewModel.fetchProductDetailsAPI(productId: productModel?.selprodID ?? "0", page: 1)
    }
    
    // MARK: - Button Actions
    @IBAction func onClickBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UITableView Delegate & DataSource Methods
extension ProductDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let collection = sectionsDataModel[section]
        let collectionName = collection.type ?? ""
        
        guard let collectionType = ProductSection(rawValue: collectionName) else {
            return 0
        }
        
        switch collectionType {
        case .productSpecifications:
            if let specs = collection.productSpecifications, !specs.isEmpty {
                return specs.count
            } else {
                return 0
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collection = sectionsDataModel[indexPath.section]
        let collectionName = collection.type ?? ""
        
        guard let collectionType = ProductSection(rawValue: collectionName) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionType.cellIdentifier, for: indexPath)
        
        switch collectionType {
        case .productImage:
            if let categoryCell = cell as? ProductBannerTableCell, let data = collection.productImages, !data.isEmpty {
                categoryCell.sectionType = .productImage
                categoryCell.contentDataModel = data
            }
        case .productPricing:
            if let pricingCell = cell as? ProductPricingCell, let priceData = collection.productDetail {
                pricingCell.configureCell(data: priceData)
            }
        case .productDescription:
            if let descriptionCell = cell as? ProductDescriptionCell,
               let pricingSection = sectionsDataModel.first(where: { $0.type == ProductSection.productPricing.rawValue }),
               let description = pricingSection.productDetail?.productDescription {
                
                let isExpanded = expandedIndexPaths.contains(indexPath)
                descriptionCell.configureCell(description: description, isExpanded: isExpanded)
                
                descriptionCell.onToggleExpand = { [weak self] in
                    guard let self = self else { return }
                    
                    if self.expandedIndexPaths.contains(indexPath) {
                        self.expandedIndexPaths.remove(indexPath)
                    } else {
                        self.expandedIndexPaths.insert(indexPath)
                    }
                    
                    self.productDetailTableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        case .productSpecifications:
            if let categoryCell = cell as? ProductSpecificationCell, let data = collection.productSpecifications
                , !data.isEmpty {
                categoryCell.configureCell(specifications: data[indexPath.row])
            }
        case .shop:
            if let categoryCell = cell as? QuestionSectionCell, let storeInfo = collection.store {
                categoryCell.configureCell(data: storeInfo)
            }
        case .reviews:
            if let categoryCell = cell as? ReviewsTableCell, let storeInfo = collection.reviews {
                categoryCell.configureCell(data: storeInfo)
            }
        case .similarProduct:
            if let categoryCell = cell as? SimilarProductTableCell, let products = collection.similarProducts {
                categoryCell.similarProductsModel = products
            }
        case .recommendedProducts:
            if let categoryCell = cell as? SimilarProductTableCell, let products = collection.recommendedProducts {
                categoryCell.similarProductsModel = products
            }
            
        case .banner:
            if let categoryCell = cell as? ProductBannerTableCell, let products = collection.banners {
                categoryCell.sectionType = .banner
                categoryCell.bannerDataModel = products
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let collection = sectionsDataModel[section]
        let collectionName = collection.type ?? ""
        if let collectionType = ProductSection(rawValue: collectionName), collectionType == .productDescription || collectionType == .productSpecifications || collectionType == .similarProduct || collectionType == .recommendedProducts || collectionType == .reviews || collectionType == .shop{
            return 40
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let collection = sectionsDataModel[section]
        let collectionName = collection.type ?? ""
        let sectionTitle = collection.title ?? ""
        let collectionType = ProductSection(rawValue: collectionName)
        if collectionType == .productDescription || collectionType == .productSpecifications || collectionType == .similarProduct || collectionType == .recommendedProducts || collectionType == .shop || collectionType == .reviews{
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            
            let label = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.width - 110, height: 30))
            label.font = .boldSystemFont(ofSize: 16)
            label.text = sectionTitle
            label.textColor = .label
            
            headerView.addSubview(label)
            return headerView
        }else {
            return nil
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let collection = sectionsDataModel[indexPath.section]
        let collectionName = collection.type ?? ""
        if let collectionType = ProductSection(rawValue: collectionName) {
            return collectionType.rowHeight
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        
        if indexPath.row == lastRow && !viewModel.isLoadingDetails && viewModel.currentDetailsPage < viewModel.totalDetailsPageCount {
            print("Reached last row, fetching page \(viewModel.currentDetailsPage + 1)")
            viewModel.loadNextDetailsPage(productId: productModel?.selprodID ?? "0")
        }
    }
}
