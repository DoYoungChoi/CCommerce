//
//  ProductDetailRateView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI

struct ProductDetailRateView: View {
    var rate: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<rate, id:\.self) { _ in
                starImage
                    .foregroundStyle(CCColor.SwiftUI.yellow)
            }
            
            ForEach(0..<(5-rate), id:\.self) { _ in
                starImage
                    .foregroundStyle(CCColor.SwiftUI.gray2)
            }
        }
    }
    
    private var starImage: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 16, height: 16)
    }
}

#Preview {
    ProductDetailRateView(rate: 4)
}
