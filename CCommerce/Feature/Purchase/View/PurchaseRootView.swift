//
//  PurchaseRootView.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import UIKit

final class PurchaseRootView: UIView {
    
    private var scrollViewConstraints: [NSLayoutConstraint]?
    private var titleLableConstraints: [NSLayoutConstraint]?
    private var purchaseItemStackViewConstraints: [NSLayoutConstraint]?
    private var purchaseButtonConstraints: [NSLayoutConstraint]?
    
    private var scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private var containerView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var titleLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "주문 상품 목록"
        label.font = CCFont.UIKit.m17
        label.textColor = CCColor.UIKit.bk
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var purchaseItemStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var purchaseButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(CCColor.UIKit.wh, for: .normal)
        button.titleLabel?.font = CCFont.UIKit.m16
        button.layer.backgroundColor = CCColor.UIKit.keyColorBlue.cgColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(purchaseItemStackView)
        addSubview(purchaseButton)
    }
    
    override func updateConstraints() {
        if scrollViewConstraints == nil {
            let constraints = [
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor, constant: 20),
                
                containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            scrollViewConstraints = constraints
        }
        
        if titleLableConstraints == nil,
           let superView = titleLabel.superview {
            let constraints = [
                titleLabel.topAnchor.constraint(equalTo: superView.topAnchor, constant: 33),
                titleLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 33),
                titleLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -33),
            ]
            NSLayoutConstraint.activate(constraints)
            titleLableConstraints = constraints
        }
        
        if purchaseItemStackViewConstraints == nil,
           let superView = purchaseItemStackView.superview {
            let constraints = [
                purchaseItemStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                purchaseItemStackView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20),
                purchaseItemStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20),
                purchaseItemStackView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -20),
            ]
            NSLayoutConstraint.activate(constraints)
            purchaseItemStackViewConstraints = constraints
        }
        
        if purchaseButtonConstraints == nil {
            let constraints = [
                purchaseButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
                purchaseButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
                purchaseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
                purchaseButton.heightAnchor.constraint(equalToConstant: 50)
            ]
            NSLayoutConstraint.activate(constraints)
            purchaseItemStackViewConstraints = constraints
        }
        
        super.updateConstraints()
    }
    
    func setPurchaseItems(_ viewModels: [PurchaseItemViewModel]) {
        purchaseItemStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        viewModels.forEach {
            purchaseItemStackView.addArrangedSubview(PurchaseItemView(viewModel: $0))
        }
    }
    
    func setFinalPrices(_ viewModel: FinalPurchasePriceViewModel) {
        purchaseItemStackView.addArrangedSubview(
            FinalPurchasePriceView(viewModel: viewModel)
        )
    }
    
    func setPurchaseButtonAction(handler: @escaping () -> Void) {
        purchaseButton.addAction(UIAction(handler: { _ in
            handler()
        }), for: .touchUpInside)
    }
}
