//
//  ProductDetailPriceView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI

final class ProductDetailPriceViewModel: ObservableObject {
    
    @Published var discountRate: String
    @Published var discountPrice: String
    @Published var originalPrice: String
    @Published var shippingType: String
    
    init(
        discountRate: String,
        discountPrice: String,
        originalPrice: String,
        shippingType: String
    ) {
        self.discountRate = discountRate
        self.discountPrice = discountPrice
        self.originalPrice = originalPrice
        self.shippingType = shippingType
    }
}

struct ProductDetailPriceView: View {
    @ObservedObject var viewModel: ProductDetailPriceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(viewModel.discountRate)
                    .font(CCFont.SwiftUI.b14)
                    .foregroundStyle(CCColor.SwiftUI.icon)
                Text(viewModel.originalPrice)
                    .font(CCFont.SwiftUI.b16)
                    .foregroundStyle(CCColor.SwiftUI.gray5)
                    .strikethrough()
                
                Spacer()
            }
            .padding(.bottom, 5)
            
            Text(viewModel.discountPrice)
                .font(CCFont.SwiftUI.b20)
                .foregroundStyle(CCColor.SwiftUI.keyColorRed)
                .padding(.bottom, 20)
            
            Text(viewModel.shippingType)
                .font(CCFont.SwiftUI.r12)
                .foregroundStyle(CCColor.SwiftUI.icon)
        }
    }
}

#Preview {
    ProductDetailPriceView(
        viewModel: .init(
            discountRate: "53%",
            discountPrice: 100_000.wonString,
            originalPrice: 153_000.wonString,
            shippingType: "무료배송"
        )
    )
}
