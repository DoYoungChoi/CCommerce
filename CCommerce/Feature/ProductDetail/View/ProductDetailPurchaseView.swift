//
//  ProductDetailPurchaseView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI

struct ProductDetailPurchaseView: View {
    var isFavorite: Bool
    var favoriteAction: () -> Void
    var purchaseAction: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Rectangle()
                .fill(CCColor.SwiftUI.gray3)
                .frame(height: 1)
            
            HStack(spacing: 30) {
                Button {
                    favoriteAction()
                } label: {
                    Image(
                        isFavorite
                        ? .favoriteOn
                        : .favoriteOff
                    )
                }
                
                Button {
                    purchaseAction()
                } label: {
                    Text("구매하기")
                        .font(CCFont.SwiftUI.m16)
                        .foregroundStyle(CCColor.SwiftUI.wh)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 40,
                            maxHeight: 40
                        )
                        .background(CCColor.SwiftUI.keyColorBlue)
                        .cornerRadius(5)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ProductDetailPurchaseView(
        isFavorite: true,
        favoriteAction: { },
        purchaseAction: { }
    )
}
