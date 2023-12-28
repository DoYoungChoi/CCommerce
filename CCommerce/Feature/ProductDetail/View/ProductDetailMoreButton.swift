//
//  ProductDetailMoreButton.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI

struct ProductDetailMoreButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                Text("상품정보 더보기")
                    .font(CCFont.SwiftUI.b17)
                    .foregroundStyle(CCColor.SwiftUI.keyColorBlue)
                
                Image(.down)
                    .foregroundStyle(CCColor.SwiftUI.icon)
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 40,
                maxHeight: 40
            )
            .border(
                CCColor.SwiftUI.keyColorBlue,
                width: 1
            )
        }
    }
}

#Preview {
    ProductDetailMoreButton() { }
}
