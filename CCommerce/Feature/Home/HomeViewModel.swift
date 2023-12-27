//
//  HomeViewModel.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import Foundation

final class HomeViewModel {
    
    enum Action {
        case loadData
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
        case loadCategories
        case loadCoupons
        case getCouponSuccess(Bool)
        case didTapCouponButton
    }
    
    final class State {
        @Published var collectionViewModels: CollectionViewModels = .init()
        
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?
            var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var categoryViewModels: [HomeCategoryCollectionViewCellViewModel]?
            var couponState: [HomeCouponButtonCollectionViewCellViewModel]?
            var homeThemeViewModels: (headerViewModel: HomeThemeHeaderCollectionReusableViewModel,
                                      items: [HomeThemeCollectionViewCellViewModel])?
            var seperator1: [HomeSeperatorCollectionViewCellViewModel] = [.init()]
            var seperator2: [HomeSeperatorCollectionViewCellViewModel] = [.init()]
        }
    }
    
    private(set) var state: State = .init()
    private var loadDataTask: Task<Void, Never>?
    private let couponDownloadedKey: String = "CouponDownloaded"
    
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case let .getDataSuccess(response):
            transformResponse(response)
        case let .getDataFailure(error):
            print("network error: \(error.localizedDescription)")
        case .loadCategories:
            loadCategories()
        case .loadCoupons:
            loadCoupon()
        case let .getCouponSuccess(isDownloaded):
            Task { await transformCoupon(isDownloaded) }
        case .didTapCouponButton:
            downloadCoupon()
        }
    }

    deinit {
        loadDataTask?.cancel()
    }
    
}

extension HomeViewModel {
    
    private func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getHomeData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    private func transformResponse(_ response: HomeResponse) {
        Task { await transformBanner(response) }
        Task { await transformHorizontalProduct(response) }
        Task { await transformVerticalProduct(response) }
        Task { await transformTheme(response) }
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        state.collectionViewModels.bannerViewModels = response.banners.map {
            HomeBannerCollectionViewCellViewModel(bannerImageURL: $0.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.horizontalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.horizontalProducts)
    }
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.verticalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.verticalProducts)
    }
    
    @MainActor
    private func transformTheme(_ response: HomeResponse) async {
        let items = response.themes.map {
            HomeThemeCollectionViewCellViewModel(themeImageURL: $0.imageUrl)
        }
        state.collectionViewModels.homeThemeViewModels = (
            HomeThemeHeaderCollectionReusableViewModel(headerText: "테마관"),
            items
        )
    }
    
    private func productToHomeProductCollectionViewCellViewModel(_ products: [Product]) -> [HomeProductCollectionViewCellViewModel] {
        products.map {
            HomeProductCollectionViewCellViewModel(
                imageURLString: $0.imageUrl,
                name: $0.title,
                discountReason: $0.discount == "Coupon" ? "쿠폰 할인가" : "",
                originalPrice: $0.originalPrice.wonString,
                discountPrice: $0.discountPrice.wonString
            )
        }
    }
    
    private func loadCategories() {
        state.collectionViewModels.categoryViewModels = [
            .init(image: CCImage.category1Big, categoryName: "패션"),
            .init(image: CCImage.category2Big, categoryName: "식품"),
            .init(image: CCImage.category3Big, categoryName: "생활용품"),
            .init(image: CCImage.category4Big, categoryName: "가전디지털"),
            .init(image: CCImage.category5Big, categoryName: "스포츠"),
            .init(image: CCImage.category6Big, categoryName: "애완용품"),
            .init(image: CCImage.category7Big, categoryName: "파티용품"),
            .init(image: CCImage.category8Big, categoryName: "가구"),
        ]
    }
    
    private func loadCoupon() {
        let couponState: Bool = UserDefaults.standard.bool(forKey: couponDownloadedKey)
        process(action: .getCouponSuccess(couponState))
    }
    
    @MainActor
    private func transformCoupon(_ isDownloaded: Bool) {
        state.collectionViewModels.couponState = [.init(state: isDownloaded ? .disable : .enable)]
    }
    
    private func downloadCoupon() {
        UserDefaults.standard.setValue(true, forKey: couponDownloadedKey)
        process(action: .loadCoupons)
    }
}
