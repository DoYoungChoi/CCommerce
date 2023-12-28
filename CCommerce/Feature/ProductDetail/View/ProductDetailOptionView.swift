//
//  ProductDetailOptionView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI
import Kingfisher

final class ProductDetailOptionViewModel: ObservableObject {
    
    @Published var name: String
    @Published var description: String
    @Published var imageURL: String
    
    init(name: String, description: String, imageURL: String) {
        self.name = name
        self.description = description
        self.imageURL = imageURL
    }
}
struct ProductDetailOptionView: View {
    @ObservedObject var viewModel: ProductDetailOptionViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text(viewModel.name)
                        .foregroundStyle(CCColor.SwiftUI.gray5)
                        .font(CCFont.SwiftUI.r12)
                    
                    Text(viewModel.description)
                        .foregroundStyle(CCColor.SwiftUI.bk)
                        .font(CCFont.SwiftUI.b14)
                }
                
                Spacer()
                
                KFImage(URL(string: viewModel.imageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .foregroundStyle(CCColor.SwiftUI.gray3)
                .frame(height: 1)
        }
    }
}

#Preview {
    ProductDetailOptionView(
        viewModel: .init(
            name: "색상",
            description: "코랄",
            imageURL: "https://picsum.photos/id/96/100/100"
        )
    )
}
