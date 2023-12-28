//
//  ProductDetailViewModel.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import Foundation
import Combine

final class ProductDetailViewModel: ObservableObject {
    
    enum Action {
        case loadData
        case getDataSuccess(ProductResponse)
        case getDataFailure(Error)
        case loading(Bool)
        case didTapChangeOption
        case didTapMoreButton
        case didTapFavoriteButton
        case didTapPurchaseButton
    }
    struct State {
        var isLoading: Bool = false
        var banner: ProductDetailBannerViewModel?
        var rate: Int?
        var title: String?
        var option: ProductDetailOptionViewModel?
        var price: ProductDetailPriceViewModel?
        var detailImageURLs: [String]?
        var needShowMore: Bool = true
        var isFavorite: Bool = false
        var isError: String?
    }
    @Published private(set) var state: State = .init()
    
    private(set) var showOptionViewController: PassthroughSubject<Void, Never> = .init()
    private var loadDataTask: Task<Void, Never>?
    
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case .getDataSuccess(let response):
            Task { await transformProductDetailResponse(response) }
        case .getDataFailure(let error):
            Task { await getDataFailure(error) }
        case .loading(let loading):
            Task { await toggleLoading(loading) }
        case .didTapChangeOption:
            showOptionViewController.send()
        case .didTapMoreButton:
            state.needShowMore = false
        case .didTapFavoriteButton:
            state.isFavorite.toggle()
        case .didTapPurchaseButton:
            return
        }
    }
    
}

extension ProductDetailViewModel {
    private func loadData() {
        loadDataTask = Task {
            defer {
                process(action: .loading(false))
            }
            
            do {
                process(action: .loading(true))
                let response = try await NetworkService.shared.getProductDetailData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    @MainActor
    private func transformProductDetailResponse(_ response: ProductResponse) async {
        state.banner = ProductDetailBannerViewModel(imageURLs: response.bannerImages)
        state.rate = response.product.rate
        state.title = response.product.name
        state.option = ProductDetailOptionViewModel(
            name: response.option.type,
            description: response.option.name,
            imageURL: response.option.image
        )
        state.price = ProductDetailPriceViewModel(
            discountRate: "\(response.product.discountPercent)%",
            discountPrice: response.product.discountPrice.wonString,
            originalPrice: response.product.originalPrice.wonString,
            shippingType: "무료배송"
        )
        state.detailImageURLs = response.detailImages
        state.isError = nil
    }
    
    @MainActor
    private func toggleLoading(_ loading: Bool) async {
        state.isLoading = loading
    }
    
    @MainActor
    private func getDataFailure(_ error: Error) {
        state.isError = "에러가 발생했습니다. \(error.localizedDescription)"
    }
}
