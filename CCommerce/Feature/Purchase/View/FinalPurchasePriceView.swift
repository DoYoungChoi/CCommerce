//
//  FinalPurchasePriceView.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import UIKit

struct FinalPurchasePriceViewModel {
    var totalSalePrice: String
    var discountPrice: String
    var shippedFee: String
    var totalPrice: String
}

final class FinalPurchasePriceView: UIView {
    
    var viewModel: FinalPurchasePriceViewModel
    
    private var containerStackViewConstraints: [NSLayoutConstraint]?
    private var containerStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var priceContentStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.m17
        label.textColor = CCColor.UIKit.bk
        label.text = "최종 결제 금액"
        return label
    }()
    private var totalSaleStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private var totalSaleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.bk
        label.text = "총 상품가격"
        return label
    }()
    private var totalSalePriceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.bk
        label.text = "0원"
        return label
    }()
    private var discountStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private var discountLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.bk
        label.text = "쿠폰할인"
        return label
    }()
    private var discountPriceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.keyColorRed2
        label.text = "0원"
        return label
    }()
    private var shippedStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private var shippedLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.bk
        label.text = "배송비"
        return label
    }()
    private var shippedFeeLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.bk
        label.text = "0원"
        return label
    }()
    private var totalStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private var totalLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.m12
        label.textColor = CCColor.UIKit.bk
        label.text = "총 결제 금액"
        return label
    }()
    private var totalPriceLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.b20
        label.textColor = CCColor.UIKit.bk
        label.text = "0원"
        return label
    }()
    private var divider: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CCColor.UIKit.gray0
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    private var spacer: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .clear
        return view
    }()
    
    init(viewModel: FinalPurchasePriceViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        customInit()
        setViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customInit() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(priceContentStackView)
        
        priceContentStackView.addArrangedSubview(totalSaleStackView)
        totalSaleStackView.addArrangedSubview(totalSaleLabel)
        totalSaleStackView.addArrangedSubview(spacer)
        totalSaleStackView.addArrangedSubview(totalSalePriceLabel)
        
        priceContentStackView.addArrangedSubview(discountStackView)
        discountStackView.addArrangedSubview(discountLabel)
        discountStackView.addArrangedSubview(discountPriceLabel)
        
        priceContentStackView.addArrangedSubview(shippedStackView)
        shippedStackView.addArrangedSubview(shippedLabel)
        shippedStackView.addArrangedSubview(shippedFeeLabel)

        containerStackView.addArrangedSubview(divider)
        containerStackView.addArrangedSubview(totalStackView)
        totalStackView.addArrangedSubview(totalLabel)
        totalStackView.addArrangedSubview(totalPriceLabel)
        
        setBorder()
    }
    
    override func updateConstraints() {
        if containerStackViewConstraints == nil {
            let constraints = [
                containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            ]
            NSLayoutConstraint.activate(constraints)
            containerStackViewConstraints = constraints
        }

        super.updateConstraints()
    }
    
    private func setBorder() {
        layer.borderColor = CCColor.UIKit.gray0.cgColor
        layer.borderWidth = 1
    }
    
    func setViewModel() {
        totalSalePriceLabel.text = viewModel.totalSalePrice
        discountPriceLabel.text = viewModel.discountPrice
        shippedFeeLabel.text = viewModel.shippedFee
        totalPriceLabel.text = viewModel.totalPrice
    }
}

#Preview {
    FinalPurchasePriceView(
        viewModel: .init(
            totalSalePrice: 35_000.wonString,
            discountPrice: 5_000.wonString,
            shippedFee: 0.wonString,
            totalPrice: 30_000.wonString
        )
    )
}
