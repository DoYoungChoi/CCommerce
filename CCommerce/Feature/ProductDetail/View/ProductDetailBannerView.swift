//
//  ProductDetailBannerView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI
import Kingfisher

final class ProductDetailBannerViewModel: ObservableObject {
    @Published var imageURLs: [String]
    
    init(imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
}

struct ProductDetailBannerView: View {
    @ObservedObject var viewModel: ProductDetailBannerViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.imageURLs, id:\.self) { imageURL in
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                }
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.width
        )
        .scrollTargetBehavior(.paging)
    }
}

#Preview {
    ProductDetailBannerView(
        viewModel: .init(
            imageURLs: [
                "https://picsum.photos/id/1/500/500",
                "https://picsum.photos/id/2/500/500",
                "https://picsum.photos/id/3/500/500"
            ]
        )
    )
}
