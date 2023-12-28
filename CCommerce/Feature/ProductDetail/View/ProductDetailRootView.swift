//
//  ProductDetailRootView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI
import Kingfisher

struct ProductDetailRootView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                if let error = viewModel.state.isError {
                    Text("\(error)")
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                } else {
                    detailView
                    
                    ProductDetailPurchaseView(isFavorite: viewModel.state.isFavorite) {
                        viewModel.process(action: .didTapFavoriteButton)
                    } purchaseAction: {
                        viewModel.process(action: .didTapPurchaseButton)
                    }
                }
            }
        }
        .onAppear {
            viewModel.process(action: .loadData)
        }
    }
    
    private var detailView: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                if let banner = viewModel.state.banner {
                    ProductDetailBannerView(viewModel: banner)
                }
                
                if let rate = viewModel.state.rate {
                    HStack(spacing: 0) {
                        Spacer()
                        ProductDetailRateView(rate: rate)
                    }
                    .padding(.horizontal, 30)
                }
                
                if let title = viewModel.state.title {
                    HStack(spacing: 0) {
                        Text(title)
                            .font(CCFont.SwiftUI.m17)
                            .foregroundStyle(CCColor.SwiftUI.bk)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                }
                
                if let option = viewModel.state.option {
                    ProductDetailOptionView(viewModel: option)
                        .padding(.horizontal, 16)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.process(action: .didTapChangeOption)
                        } label: {
                            Text("옵션 선택하기")
                                .font(CCFont.SwiftUI.m12)
                                .foregroundStyle(CCColor.SwiftUI.keyColorBlue)
                                .underline()
                        }
                    }
                    .padding(.horizontal, 36)
                }
                
                if let price = viewModel.state.price {
                    ProductDetailPriceView(viewModel: price)
                        .padding(.horizontal, 30)
                }
                
                if let detailImageURLs = viewModel.state.detailImageURLs {
                    LazyVStack(spacing: 0) {
                        ForEach(detailImageURLs, id:\.self) { imageURL in
                            KFImage.url(URL(string: imageURL))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .padding(.bottom, 32)
                    .frame(
                        maxHeight: viewModel.state.needShowMore
                                    ? 300
                                    : .infinity,
                        alignment: .top
                    )
                    .clipped()
                    
                    moreButton
                        .padding(.top, -16)
                }
            }
        }
    }
    
    @ViewBuilder
    private var moreButton: some View {
        if viewModel.state.needShowMore {
            ProductDetailMoreButton {
                viewModel.process(action: .didTapMoreButton)
            }
        }
    }
}

#Preview {
    ProductDetailRootView(viewModel: .init())
}
