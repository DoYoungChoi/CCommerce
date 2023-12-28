//
//  PurchaseViewModel.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import Foundation

final class PurchaseViewModel: ObservableObject {
    
    enum Action {
        case loadData
        case getDataSuccess
        case getDataFailure
        case didTapPurchaseButton
    }
    struct State {
        var purchaseItems: [PurchaseItemViewModel]?
    }
    @Published private(set) var state: State = .init()
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
        }
    }
    
    @MainActor
    private func didTapPurchaseButton() async {
        print("구매버튼 눌림")
    }
}
