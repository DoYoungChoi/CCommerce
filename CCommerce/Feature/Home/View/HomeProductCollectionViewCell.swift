//
//  HomeProductCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import Kingfisher

struct HomeProductCollectionViewCellViewModel: Hashable {
    let imageURLString: String
    let name: String
    let discountReason: String
    let originalPrice: String
    let discountPrice: String
}

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeProductCollectionViewCell"
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            productImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDiscountReasonLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeProductCollectionViewCellViewModel) {
        productImageView.kf.setImage(with: URL(string: viewModel.imageURLString))
        productNameLabel.text = viewModel.name
        productDiscountReasonLabel.text = viewModel.discountReason
        originalPriceLabel.attributedText = NSMutableAttributedString(
            string: viewModel.originalPrice,
            attributes: [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        discountPriceLabel.text = viewModel.discountPrice
    }
}

extension HomeProductCollectionViewCell {
    static func horizontalProductsLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(117),
            heightDimension: .estimated(224)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 30, leading: 30, bottom: 0, trailing: 30)
        section.interGroupSpacing = 14
        return section
    }
    
    static func verticalProductsLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .estimated(277)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 2, bottom: 10, trailing: 2)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(277)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 20, leading: 19 - 2, bottom: 20, trailing: 19 - 2)
        return section
    }
}
