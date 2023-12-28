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
    }
   
    private func binding() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let viewModels = self?.viewModel.state.purchaseItems else { return }
                self?.rootView.setPurchaseItems(viewModels)
            }
            .store(in: &subscriptions)
    }
}

#Preview {
    PurchaseViewController()
}
