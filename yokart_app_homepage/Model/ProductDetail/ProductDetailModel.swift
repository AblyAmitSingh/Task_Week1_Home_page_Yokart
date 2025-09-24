//
//  ProductDetailModel.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import Foundation

//struct ProductDetailModel: Codable {
//    let status: String?
//    let responseCode: String?
//    let msg: String?
//    var data : ProductDetailResponse?
//}
//
//
//struct ProductDetailResponse: Codable {
//    let currencySymbol: String?
//    let pageCount: String?
//    var data: ProductResponse?
//}
//
//struct ProductResponse : Codable {
//    let type: String?
//    let title: String?
//    var content: [Content]?
//}
//
//struct Content : Codable {
//    let afileId: String?
//    let afileType: String?
//    let afilePhysicalPath: String?
//    let afileName: String?
//    let productImageUrl: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case afileId = "afile_id"
//        case afileType = "afile_type"
//        case afilePhysicalPath = "afile_physical_path"
//        case afileName = "afile_name"
//        case productImageUrl = "product_image_url"
//    }
//}
//

struct ProductDetailModel: Codable {
    let status: String?
    let responseCode: String?
    let msg: String?
    var data: ProductData?
}

struct ProductData: Codable {
    let currencySymbol: String?
    let totalFavouriteItems: String?
    let totalUnreadMessageCount: String?
    let totalUnreadNotificationCount: String?
    let cartItemsCount: String?
    let offerCheckout: [String: String]?
    let pageCount: String?
    let cartHasProducts: String?
    let cartSellerId: String?
    var data: [Content]?
}

struct Content: Codable {
    var type: String?
    var title: String?
    var productImages: [ProductImage]?
    var productDetail: ProductDetail?
    var productSpecifications: [ProductSpecification]?
    var store: Store?
    var productPolicies: [ProductPolicy]?
    var productDescription: String?
    var reviews: Reviews?
    var similarProducts: [ProductDetail]?
    var recommendedProducts: [ProductDetail]?
    var banners: [BannerModel]?

    enum CodingKeys: String, CodingKey {
        case type, title, content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        title = try container.decodeIfPresent(String.self, forKey: .title)

        productImages = nil
        productDetail = nil
        productSpecifications = nil
        store = nil
        productPolicies = nil
        productDescription = nil
        reviews = nil
        similarProducts = nil
        recommendedProducts = nil
        banners = nil

        guard let type = type else {
            return
        }

        do {
            switch type {
            case "1":
                productDetail = try container.decodeIfPresent(ProductDetail.self, forKey: .content)
            case "2":
                productImages = try container.decodeIfPresent([ProductImage].self, forKey: .content)
            case "4":
                productSpecifications = try container.decodeIfPresent([ProductSpecification].self, forKey: .content)
            case "7":
                similarProducts = try container.decodeIfPresent([ProductDetail].self, forKey: .content)
            case "8":
                recommendedProducts = try container.decodeIfPresent([ProductDetail].self, forKey: .content)
            case "9":
                reviews = try container.decodeIfPresent(Reviews.self, forKey: .content)
            case "10":
                banners = try container.decodeIfPresent([BannerModel].self, forKey: .content)
            case "13":
                store = try container.decodeIfPresent(Store.self, forKey: .content)
            case "14":
                productPolicies = try container.decodeIfPresent([ProductPolicy].self, forKey: .content)
            case "15":
                productDescription = try container.decodeIfPresent(String.self, forKey: .content)
            default:
                print("Unknown content type '\(type)'")
            }
        } catch {
            print("Decoding error for type '\(type)': \(error)")
            throw error
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(title, forKey: .title)

        switch type {
        case "1":
            try container.encodeIfPresent(productDetail, forKey: .content)
        case "2":
            try container.encodeIfPresent(productImages, forKey: .content)
        case "4":
            try container.encodeIfPresent(productSpecifications, forKey: .content)
        case "7":
            try container.encodeIfPresent(similarProducts, forKey: .content)
        case "8":
            try container.encodeIfPresent(recommendedProducts, forKey: .content)
        case "9":
            try container.encodeIfPresent(reviews, forKey: .content)
        case "10":
            try container.encodeIfPresent(banners, forKey: .content)
        case "13":
            try container.encodeIfPresent(store, forKey: .content)
        case "14":
            try container.encodeIfPresent(productPolicies, forKey: .content)
        case "15":
            try container.encodeIfPresent(productDescription, forKey: .content)
        default:
            print("Unknown content type '\(type ?? "nil")' encoding")
        }
    }
}

struct ProductDetail: Codable {
    let availableInLocation: String?
    let isInAnyWishlist: String?
    let productId: String?
    let selprodSku: String?
    let productIdentifier: String?
    let productName: String?
    let productSellerId: String?
    let productModel: String?
    let productType: String?
    let prodcatId: String?
    let prodcatName: String?
    let productUpc: String?
    let productIsbn: String?
    let productShortDescription: String?
    let productDescription: String?
    let selprodId: String?
    let selprodUserId: String?
    let selprodCode: String?
    let selprodCondition: String?
    let selprodPrice: String?
    let specialPriceFound: String?
    let splpriceStartDate: String?
    let splpriceEndDate: String?
    let selprodTitle: String?
    let selprodWarranty: String?
    let selprodReturnPolicy: String?
    let selprodComments: String?
    let theprice: String?
    let selprodStock: String?
    let selprodThresholdStockLevel: String?
    let inStock: String?
    let brandId: String?
    let brandName: String?
    let brandShortDescription: String?
    let userName: String?
    let shopId: String?
    let shopName: String?
    let splpriceDisplayDisType: String?
    let splpriceDisplayDisVal: String?
    let splpriceDisplayListPrice: String?
    let productAttrgrpId: String?
    let productYoutubeVideo: String?
    let productCodEnabled: String?
    let selprodCodEnabled: String?
    let selprodAvailableFrom: String?
    let selprodMinOrderQty: String?
    let productUpdatedOn: String?
    let productWarranty: String?
    let selprodReturnAge: String?
    let selprodCancellationAge: String?
    let shopReturnAge: String?
    let shopCancellationAge: String?
    let selprodFulfillmentType: String?
    let shopFulfillmentType: String?
    let productFulfillmentType: String?
    let productAttachementsWithInventory: String?
    let selprodProductId: String?
    let shopStateName: String?
    let shopCountryName: String?
    let productWarrantyUnit: String?
    let shopRfqEnabled: String?
    let selprodCartType: String?
    let selprodHidePrice: String?
    let spreviewSelprodId: String?
    let spreviewProductId: String?
    let prodRating: String?
    let totReviews: String?
    let selectedOptionValues: [String]?
    let selprodConditionTitle: String?
    let ribbons: [Badge]?
    let badges: [Badge]?
    let productWarrantyUnitLabel: String?
    let discount: String?
    let inclusiveTax: String?
    let youtubeUrlThumbnail: String?
    let productUrl: String?
    let selprodReturnPolicies: [String: String]?
    let selprodWarrantyPolicies: [String: String]?
    let productCartBtn: String?
    let productRfqBtn: String?
    let codEnabled: String?
    let isOutOfMinOrderQty: String?
    let shippingDetails: [String: String]?
    let socialShareContent: SocialShareContent?
    let productDefaultImage: String?
    let productImageUrl: String?
    let shopLat: String?
    let shopLng: String?
    let prodcatCode: String?

    enum CodingKeys: String, CodingKey {
        case availableInLocation, productId, selprodSku, productIdentifier, productName = "product_name", productSellerId, productModel
        case productType, prodcatId, prodcatName = "prodcat_name", productUpc, productIsbn, productShortDescription
        case productDescription = "product_description", selprodId, selprodUserId, selprodCode, selprodCondition, selprodPrice = "selprod_price"
        case specialPriceFound, splpriceStartDate, splpriceEndDate, selprodTitle, selprodWarranty
        case selprodReturnPolicy, selprodComments, theprice, selprodStock, selprodThresholdStockLevel
        case inStock, brandId, brandName = "brand_name", brandShortDescription, userName, shopId, shopName
        case splpriceDisplayDisType, splpriceDisplayDisVal, splpriceDisplayListPrice, productAttrgrpId
        case productYoutubeVideo, productCodEnabled, selprodCodEnabled, selprodAvailableFrom
        case selprodMinOrderQty = "selprod_min_order_qty", productUpdatedOn, productWarranty, selprodReturnAge, selprodCancellationAge
        case shopReturnAge, shopCancellationAge, selprodFulfillmentType, shopFulfillmentType
        case productFulfillmentType, productAttachementsWithInventory, selprodProductId, shopStateName
        case shopCountryName, productWarrantyUnit, shopRfqEnabled, selprodCartType, selprodHidePrice
        case spreviewSelprodId, spreviewProductId, prodRating, totReviews, selectedOptionValues
        case selprodConditionTitle, ribbons, badges, productWarrantyUnitLabel, discount, inclusiveTax
        case youtubeUrlThumbnail, productUrl, selprodReturnPolicies, selprodWarrantyPolicies
        case productCartBtn, productRfqBtn, codEnabled, isOutOfMinOrderQty, shippingDetails
        case socialShareContent, productDefaultImage, isInAnyWishlist = "is_in_any_wishlist"
        case shopLat = "shop_lat", shopLng = "shop_lng", prodcatCode = "prodcat_code"
        case productImageUrl = "product_image_url"
    }
}

struct Badge: Codable {
    let url: String?
    let badgeName: String?
    let blinkcondId: String?
    let blinkcondBadgeId: String?
    let blinkcondPosition: String?
    let badgeDisplayInside: String?
    let badgeShapeType: String?
    let badgeTextColor: String?
    let badgeColor: String?
    let badgelinkId: String?
    let badgelinkRecordId: String?
    let selprodId: String?

    enum CodingKeys: String, CodingKey {
        case url
        case badgeName = "badge_name"
        case blinkcondId = "blinkcond_id"
        case blinkcondBadgeId = "blinkcond_badge_id"
        case blinkcondPosition = "blinkcond_position"
        case badgeDisplayInside = "badge_display_inside"
        case badgeShapeType = "badge_shape_type"
        case badgeTextColor = "badge_text_color"
        case badgeColor = "badge_color"
        case badgelinkId = "badgelink_id"
        case badgelinkRecordId = "badgelink_record_id"
        case selprodId = "selprod_id"
    }
}

struct Reviews: Codable {
    let withImages: ReviewWithImages?
    let withoutImages: ReviewWithoutImages?

    enum CodingKeys: String, CodingKey {
        case withImages
        case withoutImages
    }
}


struct ReviewWithImages: Codable {
    let imageReviewsPageCount: String?
    let imageReviewsRecordCount: String?
    let imageReviewsList: [ImageReview]?

    enum CodingKeys: String, CodingKey {
        case imageReviewsPageCount
        case imageReviewsRecordCount
        case imageReviewsList
    }
}

struct ImageReview: Codable {
    let spreviewId: String?
    let userUpdatedOn: String?
    let spreviewPostedbyUserId: String?
    let userImage: String?
    let images: [ReviewImage]?

    enum CodingKeys: String, CodingKey {
        case spreviewId = "spreview_id"
        case userUpdatedOn = "user_updated_on"
        case spreviewPostedbyUserId = "spreview_postedby_user_id"
        case userImage = "user_image"
        case images
    }
}

struct ReviewImage: Codable {
    let imageUrl: String?
    let largeImageUrl: String?

    enum CodingKeys: String, CodingKey {
        case imageUrl
        case largeImageUrl
    }
}

struct ReviewWithoutImages: Codable {
    let spreviewSelprodId: String?
    let spreviewProductId: String?
    let prodRating: String?
    let totReviews: String?
    let rated1: String?
    let rated2: String?
    let rated3: String?
    let rated4: String?
    let rated5: String?
    let totRatings: String?
    let totalType: String?
    let ratingAspects: [RatingAspect]?

    enum CodingKeys: String, CodingKey {
        case spreviewSelprodId = "spreview_selprod_id"
        case spreviewProductId = "spreview_product_id"
        case prodRating = "prod_rating"
        case totReviews
        case rated1 = "rated_1"
        case rated2 = "rated_2"
        case rated3 = "rated_3"
        case rated4 = "rated_4"
        case rated5 = "rated_5"
        case totRatings
        case totalType
        case ratingAspects
    }
}

struct RatingAspect: Codable {
    let spratingRatingtypeId: String?
    let ratingtypeName: String?
    let prodRating: String?

    enum CodingKeys: String, CodingKey {
        case spratingRatingtypeId = "sprating_ratingtype_id"
        case ratingtypeName = "ratingtype_name"
        case prodRating = "prod_rating"
    }
}

struct BannerModel: Codable {
    let bannerId: String?
    let bannerBlocationId: String?
    let bannerType: String?
    let bannerRecordId: String?
    let bannerUrl: String?
    let bannerTarget: String?
    let bannerTitle: String?
    let promotionId: String?
    let userBalance: String?
    let dailyCost: String?
    let weeklyCost: String?
    let monthlyCost: String?
    let totalCost: String?
    let promotionBudget: String?
    let promotionDuration: String?
    let bannerUpdatedOn: String?
    let promotionName: String?
    let bannerImageUrl: String?
    let bannerUrlType: String?

    enum CodingKeys: String, CodingKey {
        case bannerId = "banner_id"
        case bannerBlocationId = "banner_blocation_id"
        case bannerType = "banner_type"
        case bannerRecordId = "banner_record_id"
        case bannerUrl = "banner_url"
        case bannerTarget = "banner_target"
        case bannerTitle = "banner_title"
        case promotionId = "promotion_id"
        case userBalance
        case dailyCost
        case weeklyCost
        case monthlyCost
        case totalCost
        case promotionBudget
        case promotionDuration
        case bannerUpdatedOn = "banner_updated_on"
        case promotionName
        case bannerImageUrl = "banner_image_url"
        case bannerUrlType = "banner_url_type"
    }
}

struct ProductImage: Codable {
    let afileId: String?
    let afileType: String?
    let afileRecordId: String?
    let afileRecordSubid: String?
    let afileLangId: String?
    let afileScreen: String?
    let afilePhysicalPath: String?
    let afileName: String?
    let afileAttachmentType: String?
    let afileAttributeTitle: String?
    let afileAttributeAlt: String?
    let afileAspectRatio: String?
    let afileDisplayOrder: String?
    let afileUpdatedAt: String?
    let afileDownloadedTimes: String?
    let productImageUrl: String?

    enum CodingKeys: String, CodingKey {
        case afileId = "afile_id"
        case afileType = "afile_type"
        case afileRecordId = "afile_record_id"
        case afileRecordSubid = "afile_record_subid"
        case afileLangId = "afile_lang_id"
        case afileScreen = "afile_screen"
        case afilePhysicalPath = "afile_physical_path"
        case afileName = "afile_name"
        case afileAttachmentType = "afile_attachment_type"
        case afileAttributeTitle = "afile_attribute_title"
        case afileAttributeAlt = "afile_attribute_alt"
        case afileAspectRatio = "afile_aspect_ratio"
        case afileDisplayOrder = "afile_display_order"
        case afileUpdatedAt = "afile_updated_at"
        case afileDownloadedTimes = "afile_downloaded_times"
        case productImageUrl = "product_image_url"
    }
}

struct ProductSpecification: Codable {
    let prodspecId: String?
    let prodspecName: String?
    let prodspecValue: String?
    let prodspecGroup: String?

    enum CodingKeys: String, CodingKey {
        case prodspecId = "prodspec_id"
        case prodspecName = "prodspec_name"
        case prodspecValue = "prodspec_value"
        case prodspecGroup = "prodspec_group"
    }
}

struct Store: Codable {
    let shopId: String?
    let shopUserId: String?
    let shopLtemplateId: String?
    let shopCreatedOn: String?
    let shopName: String?
    let shopDescription: String?
    let shopPaymentPolicy: String?
    let shopDeliveryPolicy: String?
    let shopRefundPolicy: String?
    let shopCountryName: String?
    let shopStateName: String?
    let shopCity: String?
    let moreSellersArr: [Seller]?
    let shopTotalReviews: String?
    let shopRating: String?

    enum CodingKeys: String, CodingKey {
        case shopId = "shop_id"
        case shopUserId = "shop_user_id"
        case shopLtemplateId = "shop_ltemplate_id"
        case shopCreatedOn = "shop_created_on"
        case shopName = "shop_name"
        case shopDescription = "shop_description"
        case shopPaymentPolicy = "shop_payment_policy"
        case shopDeliveryPolicy = "shop_delivery_policy"
        case shopRefundPolicy = "shop_refund_policy"
        case shopCountryName = "shop_country_name"
        case shopStateName = "shop_state_name"
        case shopCity = "shop_city"
        case moreSellersArr
        case shopTotalReviews
        case shopRating = "shop_rating"
    }
}

struct Seller: Codable {
    let availableInLocation: String?
    let selprodId: String?
    let selprodUserId: String?
    let selprodPrice: String?
    let specialPriceFound: String?
    let theprice: String?
    let shopId: String?
    let shopName: String?
    let shopUserId: String?
    let productSellerId: String?
    let productId: String?
    let shopCountryName: String?
    let shopStateName: String?
    let shopCity: String?
    let shopRfqEnabled: String?
    let selprodCodEnabled: String?
    let productCodEnabled: String?
    let inStock: String?
    let selprodMinOrderQty: String?
    let selprodAvailableFrom: String?
    let shopLat: String?
    let shopLng: String?
    let productUpdatedOn: String?
    let selprodTitle: String?
    let selprodCode: String?
    let selprodCartType: String?
    let selprodHidePrice: String?
    let shopRating: String?
    let shopTotalReviews: String?
    let discount: String?
    let badges: [Badge]?

    enum CodingKeys: String, CodingKey {
        case availableInLocation, selprodId, selprodUserId, selprodPrice, specialPriceFound, theprice
        case shopId, shopName, shopUserId, productSellerId, productId, shopCountryName, shopStateName
        case shopCity, shopRfqEnabled, selprodCodEnabled, productCodEnabled, inStock
        case selprodMinOrderQty, selprodAvailableFrom, shopLat, shopLng, productUpdatedOn
        case selprodTitle, selprodCode, selprodCartType, selprodHidePrice, shopRating
        case shopTotalReviews, discount, badges
    }
}

struct ProductPolicy: Codable {
    let title: String?
    let isSvg: String?
    let icon: String?
}

struct SocialShareContent: Codable {
    let type: String?
    let title: String?
    let description: String?
    let image: String?
}
