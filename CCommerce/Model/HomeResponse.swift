//
//  HomeResponse.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import Foundation

struct HomeResponse: Decodable {
    var banners: [Banner]
    var horizontalProducts: [Product]
    var verticalProducts: [Product]
    var themes: [Banner]
}

struct Banner: Decodable {
    var id: Int
    var imageUrl: String
}

struct Product: Decodable {
    var id: Int
    var imageUrl: String
    var title: String
    var discount: String
    var originalPrice: Int
    var discountPrice: Int
}
