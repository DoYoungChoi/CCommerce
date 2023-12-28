//
//  ProductDetailViewController.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import UIKit
import SwiftUI
import Combine

final class ProductDetailViewController: UIViewController {
    
    let viewModel: ProductDetailViewModel = .init()
    lazy var rootView: UIHostingController = .init(rootView: ProductDetailRootView(viewModel: viewModel))
    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRootView()
        binding()
    }
    
    private func addRootView() {
        addChild(rootView)
        view.addSubview(rootView.view)
        
        rootView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootView.view.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func binding() {
        viewModel.showOptionViewController
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                let viewController = OptionViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            }.store(in: &subscriptions)
    }
}
