//
//  ProductResponse.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import Foundation

struct ProductResponse: Decodable {
    let bannerImages: [String]
    let product: ProductInfo
    let option: Option
    let detailImages: [String]
}

struct ProductInfo: Decodable {
    let name: String
    let discountPercent: Int
    let originalPrice: Int
    let discountPrice: Int
    let rate: Int
}

struct Option: Decodable {
    let type: String
    let name: String
    let image: String
}
