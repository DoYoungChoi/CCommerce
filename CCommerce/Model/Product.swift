//
//  Product.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import Foundation

struct Product: Decodable {
    var id: Int
    var imageUrl: String
    var title: String
    var discount: String
    var originalPrice: Int
    var discountPrice: Int
}
