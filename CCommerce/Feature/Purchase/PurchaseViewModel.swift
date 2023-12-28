//
//  PurchaseViewModel.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import Foundation
import Combine

final class PurchaseViewModel: ObservableObject {
    
    enum Action {
        case loadData
        case getDataSuccess
        case getDataFailure
        case didTapPurchaseButton
    }
    struct State {
        var purchaseItems: [PurchaseItemViewModel]?
        var finalPurchasePrices: FinalPurchasePriceViewModel?
    }
    @Published private(set) var state: State = .init()
    private(set) var showPaymentViewController: PassthroughSubject<Void, Never> = .init()
    
    func process(action: Action) {
        switch action {
        case .loadData:
            Task { await loadData() }
        case .getDataSuccess:
            return
        case .getDataFailure:
            return
        case .didTapPurchaseButton:
            Task { await didTapPurchaseButton() }
        }
    }
}

extension PurchaseViewModel {
    @MainActor
    private func loadData() async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.state.purchaseItems = [
                .init(title: "양반현미밥, 130g, 24개", description: "수량 1개 / 무료배송"),
                .init(title: "아이엠판다 펀치리버스 스포츠스트랩 38/40mm, 애플워치 SE", description: "수량 1개 / 무료배송"),
            ]
            self?.state.finalPurchasePrices = .init(
                totalSalePrice: 34_500.wonString,
                discountPrice: 5_000.wonString,
                shippedFee: 0.wonString,
                totalPrice: 29_500.wonString
            )
        }
    }
    
    @MainActor
    private func didTapPurchaseButton() async {
        showPaymentViewController.send()
    }
}
