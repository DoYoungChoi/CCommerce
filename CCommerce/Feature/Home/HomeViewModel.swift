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
    
    func loadData() {
        Task {
            do {
                let homeResponse = try await NetworkService.shared.getHomeData()
                let bannerViewModels = homeResponse.banners.map {
                    HomeBannerCollectionViewCellViewModel(bannerImageURL: $0.imageUrl)
                }
                let horizontalProductViewModels = homeResponse.horizontalProducts.map {
                    HomeProductCollectionViewCellViewModel(
                        imageURLString: $0.imageUrl,
                        name: $0.title,
                        discountReason: $0.discount == "Coupon" ? "쿠폰 할인가" : "",
                        originalPrice: "\($0.originalPrice)원",
                        discountPrice: "\($0.discountPrice)원"
                    )
                }
                let verticalProductViewModels = homeResponse.verticalProducts.map {
                    HomeProductCollectionViewCellViewModel(
                        imageURLString: $0.imageUrl,
                        name: $0.title,
                        discountReason: $0.discount == "Coupon" ? "쿠폰 할인가" : "",
                        originalPrice: "\($0.originalPrice)원",
                        discountPrice: "\($0.discountPrice)원"
                    )
                }
                
                self.bannerViewModels = bannerViewModels
                self.horizontalProductViewModels = horizontalProductViewModels
                self.verticalProductViewModels = verticalProductViewModels
            } catch {
                print("network error: \(error.localizedDescription)")
            }
        }
    }
}
