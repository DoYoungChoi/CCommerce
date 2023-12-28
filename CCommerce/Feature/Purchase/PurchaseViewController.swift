//
//  PurchaseViewController.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import UIKit
import Combine

class PurchaseViewController: UIViewController {
    private var viewModel: PurchaseViewModel = .init()
    private var subscriptions: Set<AnyCancellable> = []
    private var rootView: PurchaseRootView = .init()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        binding()
        viewModel.process(action: .loadData)
        rootView.setPurchaseButtonAction { [weak self] in
            self?.viewModel.process(action: .didTapPurchaseButton)
        }
    }
   
    private func binding() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let itemViewModels = self?.viewModel.state.purchaseItems,
                      let priceViewModel = self?.viewModel.state.finalPurchasePrices
                else { return }
                self?.rootView.setPurchaseItems(itemViewModels)
                self?.rootView.setFinalPrices(priceViewModel)
            }
            .store(in: &subscriptions)
        
        viewModel.showPaymentViewController
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                let paymentViewController: PaymentViewController = .init()
                self?.navigationController?.pushViewController(paymentViewController, animated: true)
            }.store(in: &subscriptions)
    }
}

#Preview {
    PurchaseViewController()
}
