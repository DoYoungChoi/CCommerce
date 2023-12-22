//
//  HomeViewModel.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import Foundation

class HomeViewModel {
    @Published var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?
    @Published var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
    @Published var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
    
    private var loadDataTask: Task<Void, Never>?
    
    func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getHomeData()
                Task { await transformBanner(response) }
                Task { await transformHorizontalProduct(response) }
                Task { await transformVerticalProduct(response) }
            } catch {
                print("network error: \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        bannerViewModels = response.banners.map {
            HomeBannerCollectionViewCellViewModel(bannerImageURL: $0.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        horizontalProductViewModels = response.horizontalProducts.map {
            HomeProductCollectionViewCellViewModel(
                imageURLString: $0.imageUrl,
                name: $0.title,
                discountReason: $0.discount == "Coupon" ? "쿠폰 할인가" : "",
                originalPrice: "\($0.originalPrice)원",
                discountPrice: "\($0.discountPrice)원"
            )
        }
    }
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        verticalProductViewModels = response.verticalProducts.map {
            HomeProductCollectionViewCellViewModel(
                imageURLString: $0.imageUrl,
                name: $0.title,
                discountReason: $0.discount == "Coupon" ? "쿠폰 할인가" : "",
                originalPrice: "\($0.originalPrice)원",
                discountPrice: "\($0.discountPrice)원"
            )
        }
    }
}
