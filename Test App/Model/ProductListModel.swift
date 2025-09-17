//
//  ProductListModel.swift
//  Test App
//
//  Created by Ably Soft on 16/09/25.
//
import Foundation

// MARK: - ProductListModel
struct ProductListModel: Codable {
    let status, responseCode, msg: String?
    var data: ProductListResponse?
}

// MARK: - ProductListResponse
struct ProductListResponse: Codable {
    let currencySymbol, totalFavouriteItems, totalUnreadMessageCount, totalUnreadNotificationCount: String?
    let cartItemsCount: String?
    let offerCheckout: OfferCheckout?
    let page, pageSize, pageCount: String?
    var collections: [Collection]?
}

// MARK: - Collection
struct Collection: Codable {
    let collectionID, collectionName, collectionDescription, collectionLinkCaption: String?
    let collectionLinkURL, collectionLayoutType, collectionType, collectionCriteria: String?
    let collectionChildRecords, collectionPrimaryRecords, collectionDisplayMediaOnly, collectionForApp: String?
    let collectionForWeb, collectionFullWidth, collectionDisplayOrder, collectionUpdatedOn: String?
    let categories: [Category]?
    let totCategories: String?
    let products: [Product]?
    let totProducts: String?
    let banners: Banners?

    enum CodingKeys: String, CodingKey {
        case collectionID = "collection_id"
        case collectionName = "collection_name"
        case collectionDescription = "collection_description"
        case collectionLinkCaption = "collection_link_caption"
        case collectionLinkURL = "collection_link_url"
        case collectionLayoutType = "collection_layout_type"
        case collectionType = "collection_type"
        case collectionCriteria = "collection_criteria"
        case collectionChildRecords = "collection_child_records"
        case collectionPrimaryRecords = "collection_primary_records"
        case collectionDisplayMediaOnly = "collection_display_media_only"
        case collectionForApp = "collection_for_app"
        case collectionForWeb = "collection_for_web"
        case collectionFullWidth = "collection_full_width"
        case collectionDisplayOrder = "collection_display_order"
        case collectionUpdatedOn = "collection_updated_on"
        case categories, totCategories, products, totProducts, banners
    }
}

// MARK: - Banners
struct Banners: Codable {
    let blocationID, blocationIdentifier, blocationCollectionID, blocationBannerCount: String?
    let blocationPromotionCost, blocationActive, bldimensionBlocationID, bldimensionDeviceType: String?
    let blocationBannerWidth, blocationBannerHeight: String?
    let banners: [Banner]?

    enum CodingKeys: String, CodingKey {
        case blocationID = "blocation_id"
        case blocationIdentifier = "blocation_identifier"
        case blocationCollectionID = "blocation_collection_id"
        case blocationBannerCount = "blocation_banner_count"
        case blocationPromotionCost = "blocation_promotion_cost"
        case blocationActive = "blocation_active"
        case bldimensionBlocationID = "bldimension_blocation_id"
        case bldimensionDeviceType = "bldimension_device_type"
        case blocationBannerWidth = "blocation_banner_width"
        case blocationBannerHeight = "blocation_banner_height"
        case banners
    }
}

// MARK: - Banner
struct Banner: Codable {
    let bannerID, bannerBlocationID, bannerType, bannerRecordID: String?
    let bannerURL, bannerTarget, bannerTitle, promotionID: String?
    let userBalance, dailyCost, weeklyCost, monthlyCost: String?
    let totalCost, promotionBudget, promotionDuration, bannerUpdatedOn: String?
    let promotionName: String?
    let bannerImage: String?
    let bannerURLType, bannerURLTitle: String?

    enum CodingKeys: String, CodingKey {
        case bannerID = "banner_id"
        case bannerBlocationID = "banner_blocation_id"
        case bannerType = "banner_type"
        case bannerRecordID = "banner_record_id"
        case bannerURL = "banner_url"
        case bannerTarget = "banner_target"
        case bannerTitle = "banner_title"
        case promotionID = "promotion_id"
        case userBalance
        case dailyCost = "daily_cost"
        case weeklyCost = "weekly_cost"
        case monthlyCost = "monthly_cost"
        case totalCost = "total_cost"
        case promotionBudget = "promotion_budget"
        case promotionDuration = "promotion_duration"
        case bannerUpdatedOn = "banner_updated_on"
        case promotionName = "promotion_name"
        case bannerImage = "banner_image"
        case bannerURLType = "banner_url_type"
        case bannerURLTitle = "banner_url_title"
    }
}

// MARK: - Category
struct Category: Codable {
    let prodcatID, prodcatName, prodcatDescription, prodcatCode: String?
    let categoryImageURL: String?

    enum CodingKeys: String, CodingKey {
        case prodcatID = "prodcat_id"
        case prodcatName = "prodcat_name"
        case prodcatDescription = "prodcat_description"
        case prodcatCode = "prodcat_code"
        case categoryImageURL = "category_image_url"
    }
}

// MARK: - Product
struct Product: Codable {
    let availableInLocation, productID, selprodID, productName: String?
    let prodcatCode, selprodTitle, productUpdatedOn, specialPriceFound: String?
    let splpriceDisplayListPrice, splpriceDisplayDisVal: SplpriceDisplay?
    let splpriceDisplayDisType, theprice, selprodPrice, selprodStock: String?
    let selprodCondition, prodcatID, prodcatName, selprodSoldCount: String?
    let inStock, shopID, selprodMinOrderQty, selprodCartType: String?
    let selprodHidePrice, productRating, shopRfqEnabled, productType: String?
    let prodRating: String?
    let productImageURL: String?
    let discount: Discount?
    let ribbons: [Ribbon]?

    enum CodingKeys: String, CodingKey {
        case availableInLocation
        case productID = "product_id"
        case selprodID = "selprod_id"
        case productName = "product_name"
        case prodcatCode = "prodcat_code"
        case selprodTitle = "selprod_title"
        case productUpdatedOn = "product_updated_on"
        case specialPriceFound = "special_price_found"
        case splpriceDisplayListPrice = "splprice_display_list_price"
        case splpriceDisplayDisVal = "splprice_display_dis_val"
        case splpriceDisplayDisType = "splprice_display_dis_type"
        case theprice
        case selprodPrice = "selprod_price"
        case selprodStock = "selprod_stock"
        case selprodCondition = "selprod_condition"
        case prodcatID = "prodcat_id"
        case prodcatName = "prodcat_name"
        case selprodSoldCount = "selprod_sold_count"
        case inStock = "in_stock"
        case shopID = "shop_id"
        case selprodMinOrderQty = "selprod_min_order_qty"
        case selprodCartType = "selprod_cart_type"
        case selprodHidePrice = "selprod_hide_price"
        case productRating = "product_rating"
        case shopRfqEnabled = "shop_rfq_enabled"
        case productType = "product_type"
        case prodRating = "prod_rating"
        case productImageURL = "product_image_url"
        case discount, ribbons
    }
}

enum Discount: String, Codable {
    case empty = ""
    case the2387Off = "23.87% OFF"
    case the415Off = "4.15% OFF"
    case the434Off = "43.4% OFF"
}

// MARK: - Ribbon
struct Ribbon: Codable {
    let blinkcondID, blinkcondBadgeID, blinkcondPosition, badgeDisplayInside: String?
    let badgeShapeType, badgeTextColor, badgeColor, badgeName: String?
    let badgelinkID, badgelinkRecordID, selprodID: String?

    enum CodingKeys: String, CodingKey {
        case blinkcondID = "blinkcond_id"
        case blinkcondBadgeID = "blinkcond_badge_id"
        case blinkcondPosition = "blinkcond_position"
        case badgeDisplayInside = "badge_display_inside"
        case badgeShapeType = "badge_shape_type"
        case badgeTextColor = "badge_text_color"
        case badgeColor = "badge_color"
        case badgeName = "badge_name"
        case badgelinkID = "badgelink_id"
        case badgelinkRecordID = "badgelink_record_id"
        case selprodID = "selprod_id"
    }
}

enum SplpriceDisplay: String, Codable {
    case empty = ""
    case the000 = "0.00"
}

// MARK: - OfferCheckout
struct OfferCheckout: Codable {
}
