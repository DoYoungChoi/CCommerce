//
//  FavoriteViewModel.swift
//  CCommerce
//
//  Created by dodor on 12/26/23.
//

import Foundation

final class FavoriteViewModel {
    
    enum Action {
        case getFavoritesFromAPI
        case getFavoritesSuccess(FavoriteResponse)
        case getFavoritesFailure(Error)
        case didTapPurchaseButton
    }
    
    final class State {
        @Published var favoriteViewModels: [FavoriteTableViewCellViewModel]? = nil
    }
    
    private(set) var state: State = .init()
    private var loadDataTask: Task<Void, Never>?
    
    func process(action: Action) {
        switch action {
        case .getFavoritesFromAPI:
            loadData()
        case .getFavoritesSuccess(let response):
            Task { await transformFavorite(response) }
        case .getFavoritesFailure(let error):
            print("network error: \(error.localizedDescription)")
        case .didTapPurchaseButton:
            return
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension FavoriteViewModel {
    
    private func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getFavoriteData()
                process(action: .getFavoritesSuccess(response))
            } catch {
                process(action: .getFavoritesFailure(error))
            }
        }
    }
    
    @MainActor
    private func transformFavorite(_ response: FavoriteResponse) async {
        state.favoriteViewModels = response.favorites.map {
            FavoriteTableViewCellViewModel(
                imageURL: $0.imageUrl,
                productName: $0.title,
                productPrice: $0.discountPrice.wonString
            )
        }
    }
}
