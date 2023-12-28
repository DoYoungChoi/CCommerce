//
//  PurchaseItemView.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import UIKit

struct PurchaseItemViewModel {
    var title: String
    var description: String
}

final class PurchaseItemView: UIView {
    
    var viewModel: PurchaseItemViewModel
    
    private var containerStackViewConstraints: [NSLayoutConstraint]?
    private var containerStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var contentStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private var titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.bk
        label.numberOfLines = 0
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.font = CCFont.UIKit.r12
        label.textColor = CCColor.UIKit.gray5
        return label
    }()
    private var spacer: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .clear
        return view
    }()
    
    init(viewModel: PurchaseItemViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        customInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customInit() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(contentStackView)
        containerStackView.addArrangedSubview(spacer)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        setBorder()
        setViewModel()
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
    
    private func setViewModel() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}

#Preview {
    PurchaseItemView(
        viewModel: .init(
            title: "아이엠판다 펀치리버스 스포츠스트랩 38/40mm, 애플워치 SE",
            description: "수량 1개 / 무료배송"
        )
    )
}
